//
//  UIImage+IFCorner.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <UIKit/UIKit.h>
#import "IFCorner.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (IFCorner)

/**
 给一个UIImage对象添加圆角
 @param radius 4个圆角的半径
 */
- (UIImage *)if_imageByAddingCornerRadius:(IFRadius)radius;

/**
 通过颜色创建图片，大小为 1 x 1
 */
+ (UIImage *)if_imageWithColor:(UIColor *)color;

/**
 通过颜色创建带圆角的图片
 @param color 图片的颜色
 @param size 图片的尺寸
 @param radius 4个圆角的半径
 */
+ (UIImage *)if_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(IFRadius)radius;

/**
 将layer的内容渲染为图片
 @param layer 将要被渲染到图片的layer
 @param radius 4个圆角的半径，如果传入TMORadiusZero，最终的图片将不添加圆角
 */
+ (UIImage *)if_imageWithLayer:(CALayer *)layer cornerRadius:(IFRadius)radius;

/**
 创建一个渐变色的图片
 @param handler 渐变色的属性
 @param size 图片的尺寸
 @param radius 4个圆角的半径，如果传入TMORadiusZero，最终的图片将不添加圆角
 */
+ (UIImage *)if_imageWithGradualChangingColor:(void(^)(IFGradualChangingColor *graColor))handler size:(CGSize)size cornerRadius:(IFRadius)radius;

/**
 创建一个边框图片，可以带圆角。通常在UIButton使用
 @param handler corner的属性，看TMOCorner的介绍
 @param size 图片的尺寸
 */
+ (UIImage *)if_imageWithTMOCorner:(void(^)(IFCorner *corner))handler size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
