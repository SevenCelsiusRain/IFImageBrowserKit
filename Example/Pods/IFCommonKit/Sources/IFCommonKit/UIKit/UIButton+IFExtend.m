//
//  UIButton+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "UIButton+IFExtend.h"
#import <objc/runtime.h>
#import "UIImage+IFExtend.h"

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;
@implementation UIButton (IFExtend)

+ (instancetype)buttonWithFont:(UIFont *)font nolTitleColor:(UIColor *)nolTitleColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = font;
    [button setTitleColor:nolTitleColor forState:UIControlStateNormal];
    return button;
}

+ (instancetype)buttonWithNolTitle:(NSString *)nolTitle nolTitleColor:(UIColor *)nolTitleColor font:(UIFont *)font {
    UIButton *btn = [UIButton buttonWithFont:font nolTitleColor:nolTitleColor];
    [btn setTitle:nolTitle forState:UIControlStateNormal];
    return btn;
}


#pragma mark - public method
- (void)if_enlargeClickInsets:(UIEdgeInsets)insets {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:insets.top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:insets.right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:insets.bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:insets.left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)if_setButtonAlignmentStyle:(IFButtonAlignmentStyle)style padding:(CGFloat)padding {
    
    /**
        UIButton中titleLabel和imageView的位置依赖：
     如果只有文字（或者图片）时，titleEdgeInsets（或imageEdgeInsets）是button中titleLabel（或imageView）相对于button的上下左右的内边距；
     如果同时有titleLabel和imageView，那么imageView的上下左是相对于button，右边是相对于titleLabel的；
     titleLabel的上下左右是相对于button，左边是相对于imageView的。
     */
    //获取imageView的宽，高
    CGFloat imageWidth = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    
    //获取titleLabel的宽，高
    //intrinsicContentSize:也就是空间内置大小，比如UILabel，UIButton等控件
    //他们都有自己的内置大小，控件的内置大小往往是由空间本身内容所决定的
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labenHeight = self.titleLabel.intrinsicContentSize.height;
    
    //初始化imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    //根据参数style和space设置imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case IFButtonAlignmentStyleTop: {
            imageEdgeInsets = UIEdgeInsetsMake(-labenHeight-padding/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-padding/2.0, 0);
        }
            break;
        case IFButtonAlignmentStyleLeft: {
            imageEdgeInsets = UIEdgeInsetsMake(0, -padding/2.0, 0, padding/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, padding/2.0, 0, -padding/2.0);
        }
            break;;
        case IFButtonAlignmentStyleBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labenHeight-padding/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-padding/2.0, -imageWidth, 0, 0);
        }
            break;
        case IFButtonAlignmentStyleRight: {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+padding/2.0, 0, -labelWidth-padding/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-padding/2.0, 0, imageWidth+padding/2.0);
        }
            break;
    }
    //重新设置titleEdgeInsets和imageEdgeInsets
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

// MARK: 设置背景色
- (void)if_setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    UIImage *image = [UIImage if_imageWithColor:color];
    [self setBackgroundImage:image forState:state];
}

#pragma mark - private method
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

@end

@interface UIButton ()
/*!*/
@property(nonatomic,strong)dispatch_source_t timer;
/*! 记录外边的时间 */
@property(nonatomic,assign)NSInteger userTime;

@end

static const char kButtonTime;
static const char kButtonTitle;
static const char kTimer;
static const char kUserTime;
static const char kRetrieveTitle;

static NSInteger const TimeInterval = 60; // 默认时间
static NSString * const ButtonTitleFormat = @"剩余%ld秒";
static NSString * const RetainTitle = @"重新获取";

@implementation UIButton (IFTimer)

- (void)startTimer {
    if (!self.time) {
        self.time = TimeInterval;
    }
    if (!self.format) {
        self.format = ButtonTitleFormat;
    }
    if (!self.retrieveTitle) {
        self.retrieveTitle = RetainTitle;
    }
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (self.time <= 1) {
            dispatch_source_cancel(self.timer);
        }else
        {
            self.time --;
            dispatch_async(mainQueue, ^{
                self.enabled = NO;
                [self setTitle:[NSString stringWithFormat:self.format,self.time] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_source_set_cancel_handler(self.timer, ^{
        dispatch_async(mainQueue, ^{
            self.enabled = YES;
            [self setTitle:self.retrieveTitle forState:UIControlStateNormal];
            if (self.userTime) {
                self.time = self.userTime;
            }else{
                self.time = TimeInterval;
            }
        });
    });
    dispatch_resume(self.timer);
}

- (void)endTimer {
    dispatch_source_cancel(self.timer);
}

#pragma mark - getter & setter

- (NSInteger)time {
    return  [objc_getAssociatedObject(self, (&kButtonTime)) integerValue];
}

- (NSString *)retrieveTitle {
    return objc_getAssociatedObject(self, &kRetrieveTitle);
}

- (NSString *)format {
    return objc_getAssociatedObject(self, &kButtonTitle);
}

- (NSInteger)userTime {
    return  [objc_getAssociatedObject(self, &kUserTime) integerValue];
}

- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, &kTimer);
}


- (void)setTime:(NSInteger)time {
    objc_setAssociatedObject(self, &kButtonTime, @(time), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setFormat:(NSString *)format {
    objc_setAssociatedObject(self, &kButtonTitle, format, OBJC_ASSOCIATION_COPY);
}

- (void)setUserTime:(NSInteger)userTime {
    objc_setAssociatedObject(self, &kUserTime, @(userTime), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, &kTimer, timer, OBJC_ASSOCIATION_RETAIN);
}

- (void)setRetrieveTitle:(NSString *)retrieveTitle {
    objc_setAssociatedObject(self, &kRetrieveTitle, retrieveTitle, OBJC_ASSOCIATION_COPY);
}

@end
