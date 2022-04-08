//
//  YBIBImageCache+Internal.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/13.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBImageCache.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YBIBImageCacheType) {
    YBIBImageCacheTypeOrigin,
    YBIBImageCacheTypeCompressed
};

/**
 Not thread safe.
 */
@interface IFIBImageCache ()

- (void)setImage:(UIImage *)image type:(YBIBImageCacheType)type forKey:(NSString *)key resident:(BOOL)resident;

- (nullable UIImage *)imageForKey:(NSString *)key type:(YBIBImageCacheType)type;

- (void)removeForKey:(NSString *)key;

- (void)removeResidentForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
