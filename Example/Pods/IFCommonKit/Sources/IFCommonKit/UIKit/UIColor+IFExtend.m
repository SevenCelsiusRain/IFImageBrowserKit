//
//  UIColor+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "UIColor+IFExtend.h"

@implementation UIColor (IFExtend)

+ (UIColor *)if_colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    NSString *cString = [hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cString = [cString  uppercaseString];
    
    // String should be 6 - 8 characters
    if ([cString length] < 6) return nil;
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return nil;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int red, green, blue;
    [[NSScanner scannerWithString:rString] scanHexInt:&red];
    [[NSScanner scannerWithString:gString] scanHexInt:&green];
    [[NSScanner scannerWithString:bString] scanHexInt:&blue];
    
    return [UIColor colorWithRed:((float) red / 255.0)
                           green:((float) green / 255.0)
                            blue:((float) blue / 255.0)
                           alpha:alpha];
}

+ (UIColor *)if_colorWithHexString:(NSString *)hexStr {
    return [self if_colorWithHexString:hexStr alpha:1.0];
}

@end
