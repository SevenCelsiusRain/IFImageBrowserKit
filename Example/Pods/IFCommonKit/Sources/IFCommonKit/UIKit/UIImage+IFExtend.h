//
//  UIImage+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (IFExtend)

/// 渐变图片 上下渐变
/// @param startColor 开始颜色
/// @param endColor 结束颜色
/// @param size 大小
+ (UIImage *)if_gradualImageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size;

/// 根据 View 生成图片
+ (UIImage *)if_imageWithView:(UIView *)view;

/**
 根据颜色值生成1x1大小的图片

 @param color 颜色值
 @return 图片对象
 */
+ (UIImage *)if_imageWithColor:(UIColor *)color;

/**
 根据颜色值生成特定大小的图片

 @param color 颜色值
 @param size 图片大小
 @return 图片对象
 */
+ (UIImage *)if_imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 将原图片生成目标大小的图片

 @param size 图片大小
 @return 图片对象
 */
- (UIImage *)if_imageByResizeToSize:(CGSize)size;


/**
 裁剪特定区域的图片

 @param rect 裁剪区域
 @return 裁剪后的图片对象
 */
- (UIImage *)if_imageByCropToRect:(CGRect)rect;

/**
 图片旋转
 */
- (UIImage *)if_imageRotation:(UIImageOrientation)orientation;


@end

NS_ASSUME_NONNULL_END
