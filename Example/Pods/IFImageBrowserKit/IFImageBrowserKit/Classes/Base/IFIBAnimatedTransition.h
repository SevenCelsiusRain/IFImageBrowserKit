//
//  YBIBAnimatedTransition.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/6.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IFIBAnimatedTransition <NSObject>
@required

- (void)yb_showTransitioningWithContainer:(UIView *)container startView:(nullable __kindof UIView *)startView startImage:(nullable UIImage *)startImage endFrame:(CGRect)endFrame orientation:(UIDeviceOrientation)orientation completion:(void(^)(void))completion;

- (void)yb_hideTransitioningWithContainer:(UIView *)container startView:(nullable __kindof UIView *)startView endView:(UIView *)endView orientation:(UIDeviceOrientation)orientation completion:(void(^)(void))completion;

@end


typedef NS_ENUM(NSInteger, YBIBTransitionType) {
    /// 无动效
    YBIBTransitionTypeNone,
    /// 渐隐
    YBIBTransitionTypeFade,
    /// 连贯移动
    YBIBTransitionTypeCoherent
};

@interface IFIBAnimatedTransition : NSObject <IFIBAnimatedTransition>

/// 入场动效类型
@property (nonatomic, assign) YBIBTransitionType showType;
/// 出场动效类型
@property (nonatomic, assign) YBIBTransitionType hideType;

/// 入场动效持续时间
@property (nonatomic, assign) NSTimeInterval showDuration;
/// 出场动效持续时间
@property (nonatomic, assign) NSTimeInterval hideDuration;

@end

NS_ASSUME_NONNULL_END
