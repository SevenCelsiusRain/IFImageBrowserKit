//
//  IFBaseFileManager.h
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface IFBaseFileManager : NSObject

+ (NSArray *)imageURLs;

+ (NSArray *)imageNames;

+ (NSArray<PHAsset *> *)imagePHAssets;

@end

NS_ASSUME_NONNULL_END
