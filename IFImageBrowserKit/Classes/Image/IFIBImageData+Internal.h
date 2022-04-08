//
//  YBIBImageData+Internal.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/12.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBImageData.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YBIBImageLoadingStatus) {
    YBIBImageLoadingStatusNone,
    YBIBImageLoadingStatusCompressing,
    YBIBImageLoadingStatusDecoding,
    YBIBImageLoadingStatusQuerying,
    YBIBImageLoadingStatusProcessing,
    YBIBImageLoadingStatusDownloading,
    YBIBImageLoadingStatusReadingPHAsset,
};

@class IFIBImageData;

@protocol YBIBImageDataDelegate <NSObject>
@required

- (void)yb_imageData:(IFIBImageData *)data startLoadingWithStatus:(YBIBImageLoadingStatus)status;

- (void)yb_imageIsInvalidForData:(IFIBImageData *)data;

- (void)yb_imageData:(IFIBImageData *)data readyForImage:(__kindof UIImage *)image;

- (void)yb_imageData:(IFIBImageData *)data readyForThumbImage:(__kindof UIImage *)image;

- (void)yb_imageData:(IFIBImageData *)data readyForCompressedImage:(__kindof UIImage *)image;

- (void)yb_imageData:(IFIBImageData *)data downloadProgress:(CGFloat)progress;

- (void)yb_imageDownloadFailedForData:(IFIBImageData *)data;

@end

@interface IFIBImageData ()

@property (nonatomic, weak) id<YBIBImageDataDelegate> delegate;

/// The status of asynchronous tasks.
@property (nonatomic, assign) YBIBImageLoadingStatus loadingStatus;

/// The origin image.
@property (nonatomic, strong) UIImage *originImage;

/// The image compressed by 'originImage' if need.
@property (nonatomic, strong) UIImage *compressedImage;

- (BOOL)shouldCompress;

- (void)cuttingImageToRect:(CGRect)rect complete:(void(^)(UIImage * _Nullable image))complete;

@end

NS_ASSUME_NONNULL_END
