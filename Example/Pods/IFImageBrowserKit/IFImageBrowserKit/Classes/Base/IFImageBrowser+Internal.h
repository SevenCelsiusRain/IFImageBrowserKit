//
//  YBImageBrowser+Internal.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/7/1.
//  Copyright © 2022 杨波. All rights reserved.
//

#import "IFImageBrowser.h"
#import "IFIBContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface IFImageBrowser ()

@property (nonatomic, strong) IFIBContainerView *containerView;

- (void)implementGetBaseInfoProtocol:(id<IFIBGetBaseInfoProtocol>)obj;

@property (nonatomic, weak, nullable) NSObject *hiddenProjectiveView;

@end

NS_ASSUME_NONNULL_END
