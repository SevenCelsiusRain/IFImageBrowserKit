//
//  UIViewController+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "UIViewController+IFExtend.h"

////// ------ 模拟旋转的控制器 ------ //////
@interface IFFakeRotationController : UIViewController

@property (nonatomic, assign) UIInterfaceOrientationMask targetOrientationMask;

@end

@implementation IFFakeRotationController

#pragma mark - Private Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return _targetOrientationMask;
}

@end

@implementation UIViewController (IFExtend)

- (UIViewController *)if_TopVisibleViewController {
    
    UIViewController *resultVC = self;
    
    while (resultVC.presentedViewController) {
        resultVC = resultVC.presentedViewController;
    }
    
    if ([resultVC isKindOfClass:[UITabBarController class]]) {
        resultVC = [[(UITabBarController *)resultVC selectedViewController] if_TopVisibleViewController];
    } else if ([resultVC isKindOfClass:[UINavigationController class]]) {
        resultVC = [[(UINavigationController *)resultVC topViewController] if_TopVisibleViewController];
    }
    
    return resultVC;
}

- (void)if_makeFakeRotation:(UIInterfaceOrientationMask)targetOrientationMask
                 completion:(void(^)(void))completion {
    IFFakeRotationController *fakeController = [[IFFakeRotationController alloc] init];
    fakeController.modalPresentationStyle = UIModalPresentationFullScreen;
    fakeController.targetOrientationMask = targetOrientationMask;
    [self presentViewController:fakeController animated:NO completion:^{
        [fakeController dismissViewControllerAnimated:NO completion:^{
            if (completion) {
                completion();
            }
        }];
    }];
}

@end
