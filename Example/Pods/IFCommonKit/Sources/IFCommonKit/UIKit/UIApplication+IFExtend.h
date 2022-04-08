//
//  UIApplication+IFExtend.h
//  IFBaseKit
/**
 使用 SceneDelegate 时无效，无法有效获取keywindow
 
 */
//  Created by MrGLZh on 2021/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (IFExtend)

#pragma mark - Top Controller

- (UIViewController *)if_topViewController;

#pragma mark - Show Controller

- (void)if_showViewController:(UIViewController *)viewController presented:(BOOL)presented;

- (void)if_showViewController:(UIViewController *)viewController
                    presented:(BOOL)presented
                   completion:(void (^ __nullable)(void))completion;

- (void)if_showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
