//
//  YBImageBrowserDataSource.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2018/8/25.
//  Copyright © 2018年 MrGLZh. All rights reserved.
//

#import "IFIBDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class IFImageBrowser;

@protocol IFImageBrowserDataSource <NSObject>

@required

/**
 返回数据源数量

 @param imageBrowser 图片浏览器
 @return 数量
 */
- (NSInteger)yb_numberOfCellsInImageBrowser:(IFImageBrowser *)imageBrowser;

/**
 返回当前下标对应的数据

 @param imageBrowser 图片浏览器
 @param index 当前下标
 @return 数据
 */
- (id<IFIBDataProtocol>)yb_imageBrowser:(IFImageBrowser *)imageBrowser dataForCellAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
