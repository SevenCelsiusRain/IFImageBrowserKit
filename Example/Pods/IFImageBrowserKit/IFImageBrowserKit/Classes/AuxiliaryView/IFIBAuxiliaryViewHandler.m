//
//  YBIBAuxiliaryViewHandler.m
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/27.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBAuxiliaryViewHandler.h"
#import "IFIBToastView.h"
#import "IFIBLoadingView.h"

@implementation IFIBAuxiliaryViewHandler

#pragma mark - <YBIBAuxiliaryViewHandler>

- (void)yb_showCorrectToastWithContainer:(UIView *)container text:(NSString *)text {
    [container ybib_showHookToast:text];
}

- (void)yb_showIncorrectToastWithContainer:(UIView *)container text:(NSString *)text {
    [container ybib_showForkToast:text];
}

- (void)yb_hideToastWithContainer:(UIView *)container {
    [container ybib_hideToast];
}

- (void)yb_showLoadingWithContainer:(UIView *)container {
    [container ybib_showLoading];
}

- (void)yb_showLoadingWithContainer:(UIView *)container progress:(CGFloat)progress {
    [container ybib_showLoadingWithProgress:progress];
}

- (void)yb_showLoadingWithContainer:(UIView *)container text:(NSString *)text {
    [container ybib_showLoadingWithText:text click:nil];
}

- (void)yb_hideLoadingWithContainer:(UIView *)container {
    [container ybib_hideLoading];
}

@end
