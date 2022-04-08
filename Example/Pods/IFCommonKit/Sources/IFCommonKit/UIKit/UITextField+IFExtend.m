//
//  UITextField+IFExtend.m
//  IFCommonKit
//
//  Created by MrGLZh on 2022/3/3.
//

#import "UITextField+IFExtend.h"

@implementation UITextField (IFExtend)

- (void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [attriStr setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:font} range:NSMakeRange(0, placeholder.length)];
    self.attributedPlaceholder = attriStr;
}

@end
