//
//  NSObject+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "NSObject+IFExtend.h"
#import <objc/runtime.h>

@implementation NSObject (IFExtend)

- (NSString *)if_className {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

+ (NSString *)if_className {
    return NSStringFromClass(self);
}

#pragma mark - Method Swizzling

+ (BOOL)if_swizzleInstanceMethod:(SEL)originSelector
                swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(self, originSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    if (!originalMethod || !swizzledMethod) {
        return NO;
    }
    
    class_addMethod(self,
                    originSelector,
                    method_getImplementation(originalMethod),
                    method_getTypeEncoding(originalMethod));
    
    class_addMethod(self,
                    swizzledSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originSelector),
                                   class_getInstanceMethod(self, swizzledSelector));
    
    return YES;
}

+ (BOOL)if_swizzleClassMethod:(SEL)originSelector
             swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getClassMethod(self, originSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
    if (!originalMethod || !swizzledMethod) {
        return NO;
    }
    method_exchangeImplementations(originalMethod, swizzledMethod);
    return YES;
}

@end
