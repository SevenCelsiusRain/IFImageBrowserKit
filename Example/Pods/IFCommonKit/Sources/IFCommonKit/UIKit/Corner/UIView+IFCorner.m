//
//  UIView+IFCorner.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "UIView+IFCorner.h"
#import "IFCorner.h"
#import "CALayer+IFCorner.h"

@implementation UIView (IFCorner)
- (void)if_updateCornerRadius:(void (^)(IFCorner *))handler {
    if (handler) {
        handler(self.layer.if_corner);
    }
    if (!self.layer.if_corner.fillColor || CGColorEqualToColor(self.layer.if_corner.fillColor.CGColor, [UIColor clearColor].CGColor)) {
        if (CGColorEqualToColor(self.backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
            if (!self.layer.if_corner.borderColor || CGColorEqualToColor(self.layer.if_corner.borderColor.CGColor, [UIColor clearColor].CGColor)) {
                return;
            }
        }
        self.layer.if_corner.fillColor = self.backgroundColor;
        self.backgroundColor = [UIColor clearColor];
    }
    [self.layer if_updateCornerRadius:handler];
}

@end
