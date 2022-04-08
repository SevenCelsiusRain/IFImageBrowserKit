//
//  NSObject+YBImageBrowser.m
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/9/26.
//  Copyright © 2022 杨波. All rights reserved.
//

#import "NSObject+IFImageBrowser.h"
#import <objc/runtime.h>

@implementation NSObject (IFImageBrowser)

static void *YBIBOriginAlphaKey = &YBIBOriginAlphaKey;
- (void)setYbib_originAlpha:(CGFloat)ybib_originAlpha {
    objc_setAssociatedObject(self, YBIBOriginAlphaKey, @(ybib_originAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)ybib_originAlpha {
    NSNumber *alpha = objc_getAssociatedObject(self, YBIBOriginAlphaKey);
    return alpha ? alpha.floatValue : 1;
}

@end
