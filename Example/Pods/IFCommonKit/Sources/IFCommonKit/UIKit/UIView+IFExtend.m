//
//  UIView+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "UIView+IFExtend.h"
#import <objc/runtime.h>
#import "IFKitMacros.h"

@implementation UIView (IFExtend)

- (CGFloat)if_left {
    return self.frame.origin.x;
}

- (void)setIf_left:(CGFloat)if_left {
    CGRect frame = self.frame;
    frame.origin.x = if_left;
    self.frame = frame;
}

- (CGFloat)if_top {
    return self.frame.origin.y;
}

- (void)setIf_top:(CGFloat)if_top {
    CGRect frame = self.frame;
    frame.origin.y = if_top;
    self.frame = frame;
}

- (CGFloat)if_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setIf_right:(CGFloat)if_right {
    CGRect frame = self.frame;
    frame.origin.x = if_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)if_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setIf_bottom:(CGFloat)if_bottom {
    CGRect frame = self.frame;
    frame.origin.y = if_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)if_width {
    return self.frame.size.width;
}

- (void)setIf_width:(CGFloat)if_width {
    CGRect frame = self.frame;
    frame.size.width = if_width;
    self.frame = frame;
}

- (CGFloat)if_height {
    return self.frame.size.height;
}

- (void)setIf_height:(CGFloat)if_height {
    CGRect frame = self.frame;
    frame.size.height = if_height;
    self.frame = frame;
}

- (CGFloat)if_centerX {
    return self.center.x;
}

- (void)setIf_centerX:(CGFloat)if_centerX {
    self.center = CGPointMake(if_centerX, self.center.y);
}

- (CGFloat)if_centerY {
    return self.center.y;
}

- (void)setIf_centerY:(CGFloat)if_centerY {
    self.center = CGPointMake(self.center.x, if_centerY);
}

- (CGPoint)if_origin {
    return self.frame.origin;
}

- (void)setIf_origin:(CGPoint)if_origin{
    CGRect frame = self.frame;
    frame.origin = if_origin;
    self.frame = frame;
}

- (CGSize)if_size {
    return self.frame.size;
}

- (void)setIf_size:(CGSize)if_size {
    CGRect frame = self.frame;
    frame.size = if_size;
    self.frame = frame;
}

- (void)if_removeAllSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (UIImage *)if_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}


@end


@implementation UIView (IFScreenshot)

- (UIImage *)if_screenShot {
    
    if (self && self.frame.size.height && self.frame.size.width) {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
        
    } else {
        
        return nil;
    }
}

- (UIImage *)if_screenShotWithHeight:(CGFloat)height {
    
    if (self && height && self.frame.size.width) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.frame.size.width, height), NO, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
        
    } else {
        return nil;
    }
}

- (UIImage *)if_screentableViewShot:(UITableView *)tableView{

    if (tableView.contentSize.height < [UIScreen mainScreen].bounds.size.height) {
        //如果tableview数据的高度小于屏幕高度, 就截整屏显示, 否则数据源只有1、2条时, 截取的内容就会很少,不美观
        tableView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }

      // 开启图形上下文
      UIGraphicsBeginImageContextWithOptions(tableView.contentSize, YES, [UIScreen mainScreen].scale);

      CGPoint savedContentOffset = tableView.contentOffset;
      CGRect savedFrame = tableView.frame;
      tableView.contentOffset = CGPointZero;
      tableView.frame = CGRectMake(13, kIFNaviBarHeight, tableView.contentSize.width-26, tableView.contentSize.height);

      [tableView.layer renderInContext: UIGraphicsGetCurrentContext()];

      //因为 renderInContext 渲染时会导致内存急剧上升,可能会造成crash, 所以要清除 layer 绘制过后产生的缓存
      tableView.layer.contents = nil; //释放缓存
      UIImage *image = [[UIImage alloc]init];
      image = UIGraphicsGetImageFromCurrentImageContext(); //从图形上下文获取图片
      UIGraphicsEndImageContext();
      tableView.tableHeaderView = nil;
      tableView.contentOffset= savedContentOffset;
      tableView.frame= savedFrame;

      return image;
}

@end


@implementation UIView(IFTheme)

// MARK: 添加阴影
- (void)if_addShodowWithColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius options:(IFShadowOptions)options {
    if(![self if_shouldShadowByOption:options shadowOffset:offset shadowRadius:radius]){
        return;
    }
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    
    if(options == 0 || options == IFShadowAll){
        self.layer.shadowPath = NULL;
        return;
    }
    
    CGPoint topLeft = CGPointZero;
    CGPoint topRight = CGPointMake(CGRectGetWidth(self.frame), 0);
    CGPoint bottomLeft = CGPointMake(0, CGRectGetHeight(self.frame));
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5);
    
    UIBezierPath *shadowPath = [[UIBezierPath alloc] init];
    if(options & IFShadowTop){
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:topLeft];
        [path addLineToPoint:center];
        [path addLineToPoint:topRight];
        [shadowPath appendPath:path];
    }
    
    if(options & IFShadowLeft){
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:topLeft];
        [path addLineToPoint:center];
        [path addLineToPoint:bottomLeft];
        [shadowPath appendPath:path];
    }
    
    if(options & IFShadowBottom){
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:bottomLeft];
        [path addLineToPoint:center];
        [path addLineToPoint:bottomRight];
        [shadowPath appendPath:path];
    }
    
    if(options & IFShadowRight){
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:topRight];
        [path addLineToPoint:center];
        [path addLineToPoint:bottomRight];
        [shadowPath appendPath:path];
    }
    
    self.layer.shadowPath = shadowPath.CGPath;
    [self if_setOptions:options shadowOffset:offset shadowRadius:radius];
}

// MARK: 画虚线
- (void)if_drawDashLineWithLength:(CGFloat)length color:(UIColor *)color space:(CGFloat)space width:(CGFloat)width startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    CGFloat distance = sqrt(pow((startPoint.x - endPoint.x), 2) + pow((startPoint.y - endPoint.y), 2));
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.bounds = CGRectMake(0, 0, distance, width);
    //        只要是CALayer这种类型,他的anchorPoint默认都是(0.5,0.5)
    shapeLayer.anchorPoint = CGPointMake(0, 0);
    //        shapeLayer.fillColor = UIColor.blue.cgColor
    shapeLayer.strokeColor = color.CGColor;
    
    shapeLayer.lineWidth = 1;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineDashPattern = @[@(length), @(space)];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL, startPoint.x,startPoint.y);
    CGPathAddLineToPoint(path,NULL,endPoint.x,endPoint.y);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [self.layer addSublayer:shapeLayer];
}



#pragma mark - private method

- (BOOL)if_shouldShadowByOption:(IFShadowOptions)options shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius{
    if(shadowRadius > 0){
        IFShadowOptions oldOptions = [self if_shadowoptions];
        CGSize oldShadowOffset = [self if_shadowOffset];
        CGFloat oldShadowRadius = [self if_shadowRadius];
        return !(oldOptions == options &&
                 CGSizeEqualToSize(oldShadowOffset, shadowOffset) &&
                 oldShadowRadius == shadowRadius);
    }
    
    return NO;
}

- (void)if_setOptions:(IFShadowOptions)options shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius{
    [self if_setShadowOptions:options];
    [self if_setShadowOffset:shadowOffset];
    [self if_setShadowRadius:shadowRadius];
}

- (void)if_setShadowOptions:(IFShadowOptions)options{
    objc_setAssociatedObject(self, @selector(if_shadowoptions), @(options), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)if_setShadowOffset:(CGSize)shadowOffset{
    NSValue *value = [NSValue valueWithCGSize:shadowOffset];
    objc_setAssociatedObject(self, @selector(if_shadowOffset), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)if_setShadowRadius:(CGFloat)shadowRadius{
    objc_setAssociatedObject(self, @selector(if_shadowRadius), @(shadowRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (IFShadowOptions)if_shadowoptions{
    return (IFShadowOptions)[objc_getAssociatedObject(self, _cmd) intValue];
}

- (CGSize)if_shadowOffset{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (CGFloat)if_shadowRadius{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}


@end


@implementation UIView (IFController)

- (UIViewController *)if_viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
