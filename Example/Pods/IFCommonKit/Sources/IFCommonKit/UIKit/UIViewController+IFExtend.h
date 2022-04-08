//
//  UIViewController+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (IFExtend)

#pragma mark - Top Controller

- (UIViewController *)if_TopVisibleViewController;


#pragma mark - Rotation

- (void)if_makeFakeRotation:(UIInterfaceOrientationMask)targetOrientationMask
                 completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
