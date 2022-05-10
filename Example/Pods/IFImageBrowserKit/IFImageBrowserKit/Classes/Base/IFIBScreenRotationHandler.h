//
//  YBIBScreenRotationHandler.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/8.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFImageBrowser.h"

NS_ASSUME_NONNULL_BEGIN

@interface IFIBScreenRotationHandler : NSObject

- (instancetype)initWithBrowser:(IFImageBrowser *)browser;

- (void)startObserveStatusBarOrientation;

- (void)startObserveDeviceOrientation;

- (void)clear;

- (void)configContainerSize:(CGSize)size;

- (CGSize)containerSizeWithOrientation:(UIDeviceOrientation)orientation;

@property (nonatomic, assign, readonly, getter=isRotating) BOOL rotating;

@property (nonatomic, assign, readonly) UIDeviceOrientation currentOrientation;

@property (nonatomic, assign) UIInterfaceOrientationMask supportedOrientations;

@property (nonatomic, assign) NSTimeInterval rotationDuration;

@end

NS_ASSUME_NONNULL_END
