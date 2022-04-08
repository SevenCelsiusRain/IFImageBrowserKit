//
//  YBIBImageCache.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/13.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class IFIBImageCache;

@interface NSObject (IFIBImageCache)

/// 图片浏览器持有的图片缓存管理类
@property (nonatomic, strong, readonly) IFIBImageCache *ybib_imageCache;

@end


@interface IFIBImageCache : NSObject

/// 缓存数量限制（一个单位表示一个 YBIBImageData 产生的所有图片数据）
@property (nonatomic, assign) NSUInteger imageCacheCountLimit;

@end

NS_ASSUME_NONNULL_END
