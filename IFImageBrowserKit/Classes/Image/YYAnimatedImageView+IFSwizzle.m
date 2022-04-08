//
//  YYAnimatedImageView+IFSwizzle.m
//  IFTSP
//
//  Created by MrGLZh on 2022/3/23.
//

#import <objc/runtime.h>
#import "YYAnimatedImageView+IFSwizzle.h"

@implementation YYAnimatedImageView (IFSwizzle)

+ (void)load {
    Method a = class_getInstanceMethod(self, @selector(displayLayer:));
    Method b = class_getInstanceMethod(self, @selector(swizzing_displayLayer:));
        method_exchangeImplementations(a, b);
}

#pragma mark - private

- (void)swizzing_displayLayer:(CALayer *)layer {
    Ivar ivar = class_getInstanceVariable(self.class, "_curFrame");
    UIImage *_curFrame = object_getIvar(self, ivar);

    if (_curFrame) {
        layer.contents = (__bridge id)_curFrame.CGImage;
    } else {
        if (@available(iOS 14.0, *)) {
            [super displayLayer:layer];
        }
    }
}

@end
