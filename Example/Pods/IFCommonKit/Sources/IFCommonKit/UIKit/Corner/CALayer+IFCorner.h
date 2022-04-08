//
//  CALayer+IFCorner.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@class IFCorner;
@interface CALayer (IFCorner)

@property (nonatomic, strong) IFCorner * if_corner;
/**
 给一个CALayer对象添加圆角
 @param handler corner 的属性，看TMOCorner的介绍
 @warning 如果在corner对象中，fillColor 和 borderColor 都被设置为 nil 或者 clearColor，这个方法什么都不会做。
 */
- (void)if_updateCornerRadius:(void(^)(IFCorner *corner))handler;
@end

NS_ASSUME_NONNULL_END
