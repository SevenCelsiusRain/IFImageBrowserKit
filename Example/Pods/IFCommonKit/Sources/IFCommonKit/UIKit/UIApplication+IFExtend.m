//
//  UIApplication+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "UIApplication+IFExtend.h"
#import "UIWindow+IFExtend.h"

@implementation UIApplication (IFExtend)

- (UIViewController *)if_topViewController {
    
    return [self.keyWindow if_topVisibleViewController];
}

- (void)if_showViewController:(UIViewController *)viewController
                    presented:(BOOL)presented {
    [self if_showViewController:viewController presented:presented completion:NULL];
}

- (void)if_showViewController:(UIViewController *)viewController
                    presented:(BOOL)presented
                   completion:(void (^ __nullable)(void))completion {
    UIViewController *topController = [self if_topViewController];
    if (presented) {
        [topController presentViewController:viewController animated:YES completion:completion];
    } else {
        [topController.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)if_showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL]];
    [self if_showViewController:alertController presented:YES];
}

@end
