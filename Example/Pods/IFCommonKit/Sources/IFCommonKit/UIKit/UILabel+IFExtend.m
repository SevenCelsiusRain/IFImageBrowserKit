//
//  UILabel+IFExtend.m
//  IFCommonKit
//
//  Created by MrGLZh on 2022/3/3.
//

#import <objc/runtime.h>
#import "UILabel+IFExtend.h"
#import "IFAttributed.h"
#import "NSArray+IFExtend.h"

static const char * if_attributed_key = "if_attributed_key";
@implementation UILabel (IFExtend)
@dynamic if_attributed;

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)color {
    UILabel *label = [UILabel new];
    label.textColor = color;
    label.font = font;
    
    return label;
}

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [UILabel labelWithFont:font textColor:color];
    label.textAlignment = textAlignment;
    return label;
}

- (void)setAttributed:(void (^)(IFAttributed * _Nonnull))attributed {
    if (attributed) {
        attributed(self.if_attributed);
    }
    if (self.if_attributed.text.length <= 0) {
        return;
    }
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:self.if_attributed.text];
    [attriStr setAttributes:@{NSForegroundColorAttributeName:self.if_attributed.normalColor, NSFontAttributeName:self.if_attributed.normalFont} range:NSMakeRange(0, attriStr.length)];
    if (self.if_attributed.lineSpace > 0) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = self.if_attributed.lineSpace;
        [attriStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attriStr.length)];
    }
    
    for (int i = 0; i < self.if_attributed.subRangs.count; i++) {
        NSRange rang = self.if_attributed.subRangs[i].rangeValue;
        UIColor *color = [self.if_attributed.subColors if_objectOrNilAtIndex:i];
        if (color) {
            [attriStr addAttribute:NSForegroundColorAttributeName value:color range:rang];
        }
        UIFont *font = [self.if_attributed.subFonts if_objectOrNilAtIndex:i];
        if (font) {
            [attriStr addAttribute:NSFontAttributeName value:font range:rang];
        }
    }
    self.attributedText = attriStr;
}

- (IFAttributed *)if_attributed {
    IFAttributed *attributed = objc_getAssociatedObject(self, &if_attributed_key);
    if (!attributed) {
        attributed = [IFAttributed attributed];
        self.if_attributed = attributed;
    }
    return attributed;
}

- (void)setIf_attributed:(IFAttributed *)if_attributed {
    objc_setAssociatedObject(self, &if_attributed_key, if_attributed, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
