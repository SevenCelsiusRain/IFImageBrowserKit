//
//  UIButton+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, IFButtonAlignmentStyle) {
    IFButtonAlignmentStyleTop,//图片在上，文字在下
    IFButtonAlignmentStyleLeft,//图片在左，文字在右
    IFButtonAlignmentStyleBottom,//图片在下，文字在上
    IFButtonAlignmentStyleRight//图片在右，文字在左
};

@interface UIButton (IFExtend)

/// 创建button
/// @param font 字体
/// @param nolTitleColor 标题颜色 normal
+ (instancetype)buttonWithFont:(UIFont *)font nolTitleColor:(UIColor *)nolTitleColor;

/// 创建button
/// @param nolTitle 标题 normal
/// @param nolTitleColor 标题颜色 normal
/// @param font 标题字体
+ (instancetype)buttonWithNolTitle:(NSString *)nolTitle nolTitleColor:(UIColor *)nolTitleColor font:(UIFont *)font;

/**
 扩大点击范围
 */
- (void)if_enlargeClickInsets:(UIEdgeInsets)insets;

/**
 设置按钮图片和文字的布局样式和间距
 @param style 布局样式
 @param padding 文字和图片的间距

 */
- (void)if_setButtonAlignmentStyle:(IFButtonAlignmentStyle)style padding:(CGFloat)padding;

/**
 设置背景色
 */
- (void)if_setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end

@interface UIButton (IFTimer)

/*! 计时时间 默认 60s*/
@property(nonatomic, assign) NSInteger time;

/*!倒计时格式 默认 剩余%ld秒 */
@property(nonatomic, copy) NSString * format;
/*!重新获取标题 默认 重新获取 */
@property (nonatomic, copy) NSString *retrieveTitle;

/// 开启计时器
- (void)startTimer;

/// 结束计时器
- (void)endTimer;

@end

NS_ASSUME_NONNULL_END
