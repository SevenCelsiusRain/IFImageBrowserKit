//
//  YBImageBrowserDelegate.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/9.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class IFImageBrowser;

@protocol IFImageBrowserDelegate <NSObject>

@optional

/**
 页码变化

 @param imageBrowser 图片浏览器
 @param page 当前页码
 @param data 数据
 */
- (void)yb_imageBrowser:(IFImageBrowser *)imageBrowser pageChanged:(NSInteger)page data:(id<IFIBDataProtocol>)data;

/**
 响应长按手势（若实现该方法将阻止其它地方捕获到长按事件）

 @param imageBrowser 图片浏览器
 @param data 数据
 */
- (void)yb_imageBrowser:(IFImageBrowser *)imageBrowser respondsToLongPressWithData:(id<IFIBDataProtocol>)data;

/**
 开始转场

 @param imageBrowser 图片浏览器
 @param isShow YES 表示入场，NO 表示出场
 */
- (void)yb_imageBrowser:(IFImageBrowser *)imageBrowser beginTransitioningWithIsShow:(BOOL)isShow;

/**
 结束转场

 @param imageBrowser 图片浏览器
 @param isShow YES 表示入场，NO 表示出场
 */
- (void)yb_imageBrowser:(IFImageBrowser *)imageBrowser endTransitioningWithIsShow:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
