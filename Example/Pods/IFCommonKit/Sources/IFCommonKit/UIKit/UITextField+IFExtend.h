//
//  UITextField+IFExtend.h
//  IFCommonKit
//
//  Created by MrGLZh on 2022/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (IFExtend)

/// 设置placeholder
/// @param placeholder 文本
/// @param color 颜色
/// @param font 字体
- (void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
