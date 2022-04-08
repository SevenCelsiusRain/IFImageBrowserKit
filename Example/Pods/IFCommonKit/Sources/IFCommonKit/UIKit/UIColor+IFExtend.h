//
//  UIColor+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define IFHexColor(hexColorStr) [UIColor if_colorWithHexString:hexColorStr]

#define IFHexColorAlpha(hexColorStr, alphaNum) [UIColor if_colorWithHexString:hexColorStr alpha:alphaNum]

@interface UIColor (IFExtend)

/**
 由十六进制的字符串和透明通道来生成对应的颜色对象。
 字符串必须是6-8位，字符串可以以0X、0x或#开头，后面紧跟6位置颜色值。
 e.g. 0xAAAAAA 0Xff6d2d ffffff

 @param hexStr 十六进制的字符串
 @param alpha 透明度
 @return 颜色对象
 */
+ (UIColor *)if_colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

/**
 e.g. 0xAAAAAA
 
 @see if_colorWithHexString:alpha: 默认alpha为1.0

 @param hexStr 十六进制的字符串
 @return 颜色对象
 */
+ (UIColor *)if_colorWithHexString:(NSString *)hexStr;

@end

NS_ASSUME_NONNULL_END
