//
//  UIWindow+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "UIWindow+IFExtend.h"
#import "UIViewController+IFExtend.h"

@implementation UIWindow (IFExtend)

- (UIViewController *)if_topVisibleViewController {
    return [self.rootViewController if_TopVisibleViewController];
}
@end
