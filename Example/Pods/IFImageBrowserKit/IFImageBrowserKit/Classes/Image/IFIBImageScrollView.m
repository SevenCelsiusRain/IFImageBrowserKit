//
//  YBIBImageScrollView.m
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/10.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBImageScrollView.h"
#import "YYAnimatedImageView+IFSwizzle.h"

@interface IFIBImageScrollView ()
@property (nonatomic, strong) YYAnimatedImageView *imageView;
@end

@implementation IFIBImageScrollView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.maximumZoomScale = 1;
        self.minimumZoomScale = 1;
        self.alwaysBounceHorizontal = NO;
        self.alwaysBounceVertical = NO;
        self.layer.masksToBounds = NO;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }

        [self addSubview:self.imageView];
    }
    return self;
}

#pragma mark - public

- (void)setImage:(__kindof UIImage *)image type:(YBIBScrollImageType)type {
    self.imageView.image = image;
    self.imageType = type;
}

- (void)reset {
    self.zoomScale = 1;
    self.imageView.image = nil;
    self.imageView.frame = CGRectZero;
    self.imageType = YBIBScrollImageTypeNone;
}

#pragma mark - getters

- (YYAnimatedImageView *)imageView {
    if (!_imageView) {
        _imageView = [YYAnimatedImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

@end
