//
//  YBIBOperateBrowserProtocol.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/7/8.
//  Copyright © 2022 杨波. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IFIBOperateBrowserProtocol <NSObject>

@optional

/// 隐藏图片浏览器
@property (nonatomic, copy) void(^yb_hideBrowser)(void);

/// 是否隐藏状态栏
@property (nonatomic, copy) void(^yb_hideStatusBar)(BOOL);

/// 是否隐藏工具视图
@property (nonatomic, copy) void(^yb_hideToolViews)(BOOL);

@property (nonatomic, copy) void(^yb_tapHideBrowser)(BOOL);

@end

NS_ASSUME_NONNULL_END
