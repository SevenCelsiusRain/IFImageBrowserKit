//
//  YBIBOrientationReceiveProtocol.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/7/8.
//  Copyright © 2022 杨波. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IFIBOrientationReceiveProtocol <NSObject>

@optional

/**
 图片浏览器的方向将要变化

 @param orientation 期望的方向
 */
- (void)yb_orientationWillChangeWithExpectOrientation:(UIDeviceOrientation)orientation;

/**
 图片浏览器的方向变化动效调用，实现的变化会自动转换为动画

 @param orientation 期望的方向
 */
- (void)yb_orientationChangeAnimationWithExpectOrientation:(UIDeviceOrientation)orientation;

/**
 图片浏览器的方向已经变化

 @param orientation 当前的方向
 */
- (void)yb_orientationDidChangedWithOrientation:(UIDeviceOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
