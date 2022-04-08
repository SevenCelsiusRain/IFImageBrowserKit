//
//  UILabel+IFExtend.h
//  IFCommonKit
//
//  Created by MrGLZh on 2022/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class IFAttributed;
@interface UILabel (IFExtend)
@property (nonatomic, strong) IFAttributed *if_attributed;

/// 创建 label
/// @param font 字体
/// @param color 字体颜色
+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)color;


/// 创建label
/// @param font 字体
/// @param color 字体颜色
/// @param textAlignment 对齐方式
+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;


- (void)setAttributed:(void(^)(IFAttributed *attributed))attributed;

@end

NS_ASSUME_NONNULL_END
