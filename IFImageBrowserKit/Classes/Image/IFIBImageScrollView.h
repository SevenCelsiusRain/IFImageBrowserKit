//
//  YBIBImageScrollView.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/10.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFImage.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YBIBScrollImageType) {
    YBIBScrollImageTypeNone,
    YBIBScrollImageTypeOriginal,
    YBIBScrollImageTypeCompressed,
    YBIBScrollImageTypeThumb
};

@interface IFIBImageScrollView : UIScrollView

- (void)setImage:(__kindof UIImage *)image type:(YBIBScrollImageType)type;

@property (nonatomic, strong, readonly) YYAnimatedImageView *imageView;

@property (nonatomic, assign) YBIBScrollImageType imageType;

- (void)reset;

@end

NS_ASSUME_NONNULL_END
