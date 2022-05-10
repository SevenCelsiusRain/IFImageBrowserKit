//
//  YBIBAnimatedTransition.m
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/6.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBAnimatedTransition.h"

extern CGFloat YBIBRotationAngle(UIDeviceOrientation startOrientation, UIDeviceOrientation endOrientation);

@implementation IFIBAnimatedTransition

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _showType = _hideType = YBIBTransitionTypeCoherent;
        _showDuration = _hideDuration = 0.0;
    }
    return self;
}

#pragma mark - <YBIBAnimationHandler>

- (void)yb_showTransitioningWithContainer:(UIView *)container startView:(__kindof UIView *)startView startImage:(UIImage *)startImage endFrame:(CGRect)endFrame orientation:(UIDeviceOrientation)orientation completion:(void (^)(void))completion {
    YBIBTransitionType type = self.showType;
    if (type == YBIBTransitionTypeCoherent) {
        if (CGRectIsEmpty(endFrame) || !startView || orientation != (UIDeviceOrientation)UIApplication.sharedApplication.statusBarOrientation) {
            type = YBIBTransitionTypeFade;
        }
    }
    
    switch (type) {
        case YBIBTransitionTypeNone: {
            completion();
        }
            break;
        case YBIBTransitionTypeFade: {
            
            BOOL animateValid = !CGRectIsEmpty(endFrame) && startView;
            
            UIImageView *animateImageView;
            if (animateValid) {
                animateImageView = [self imageViewAssimilateToView:startView];
                animateImageView.frame = endFrame;
                animateImageView.image = startImage;
                [container addSubview:animateImageView];
            }
            
            CGFloat rawAlpha = container.alpha;
            container.alpha = 0;
            
            if (!animateValid) completion();
                
            [UIView animateWithDuration:self.showDuration animations:^{
                container.alpha = rawAlpha;
            } completion:^(BOOL finished) {
                if (animateValid) {
                    [animateImageView removeFromSuperview];
                    completion();
                }
            }];
            
        }
            break;
        case YBIBTransitionTypeCoherent: {
            
            UIImageView *animateImageView = [self imageViewAssimilateToView:startView];
            animateImageView.frame = [startView convertRect:startView.bounds toView:container];
            animateImageView.image = startImage;
            
            [container addSubview:animateImageView];
            
            UIColor *rawBackgroundColor = container.backgroundColor;
            container.backgroundColor = [rawBackgroundColor colorWithAlphaComponent:0];
            
            [UIView animateWithDuration:self.showDuration animations:^{
                animateImageView.frame = endFrame;
                container.backgroundColor = rawBackgroundColor;
            } completion:^(BOOL finished) {
                completion();
                // Disappear smoothly.
                [UIView animateWithDuration:0.2 animations:^{
                    animateImageView.alpha = 0;
                } completion:^(BOOL finished) {
                    [animateImageView removeFromSuperview];
                }];
            }];
            
        }
            break;
    }
}

- (void)yb_hideTransitioningWithContainer:(UIView *)container startView:(__kindof UIView *)startView endView:(UIView *)endView orientation:(UIDeviceOrientation)orientation completion:(void (^)(void))completion {
    YBIBTransitionType type = self.hideType;
    if (type == YBIBTransitionTypeCoherent && (!startView || !endView)) {
        type = YBIBTransitionTypeFade;
    }
    
    switch (type) {
        case YBIBTransitionTypeNone: {
            completion();
        }
            break;
        case YBIBTransitionTypeFade: {
            
            CGFloat rawAlpha = container.alpha;
            
            [UIView animateWithDuration:self.hideDuration animations:^{
                container.alpha = 0;
            } completion:^(BOOL finished) {
                completion();
                container.alpha = rawAlpha;
            }];
            
        }
            break;
        case YBIBTransitionTypeCoherent: {
            
            CGRect startFrame = startView.frame;
            CGRect endFrame = [endView convertRect:endView.bounds toView:startView.superview];
            
            UIColor *rawBackgroundColor = container.backgroundColor;
            
            [UIView animateWithDuration:self.hideDuration animations:^{
                
                container.backgroundColor = [rawBackgroundColor colorWithAlphaComponent:0];
                
                startView.contentMode = endView.contentMode;
                
                CGAffineTransform transform = startView.transform;
                UIDeviceOrientation statusBarOrientation = (UIDeviceOrientation)UIApplication.sharedApplication.statusBarOrientation;
                if (orientation != statusBarOrientation) {
                    transform = CGAffineTransformRotate(transform, YBIBRotationAngle(orientation, statusBarOrientation));
                }
                
                if ([startView isKindOfClass:UIImageView.self]) {
                    startView.frame = endFrame;
                    startView.transform = transform;
                } else {
                    CGFloat scale = MAX(endFrame.size.width / startFrame.size.width, endFrame.size.height / startFrame.size.height);
                    startView.center = CGPointMake(endFrame.size.width * startView.layer.anchorPoint.x + endFrame.origin.x, endFrame.size.height * startView.layer.anchorPoint.y + endFrame.origin.y);
                    startView.transform = CGAffineTransformScale(transform, scale, scale);
                }
                
            } completion:^(BOOL finished) {
                completion();
                container.backgroundColor = rawBackgroundColor;
            }];
            
        }
            break;
    }
}

#pragma mark - private

- (UIImageView *)imageViewAssimilateToView:(nullable __kindof UIView *)view {
    UIImageView *animateImageView = [UIImageView new];
    if ([view isKindOfClass:UIImageView.self]) {
        animateImageView.contentMode = view.contentMode;
    } else {
        animateImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    animateImageView.layer.masksToBounds = view.layer.masksToBounds;
    animateImageView.layer.cornerRadius = view.layer.cornerRadius;
    animateImageView.layer.backgroundColor = view.layer.backgroundColor;
    return animateImageView;
}

@end
