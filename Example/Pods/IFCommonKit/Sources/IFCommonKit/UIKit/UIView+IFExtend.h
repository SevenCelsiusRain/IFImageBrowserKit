//
//  UIView+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <UIKit/UIKit.h>

@interface UIView (IFExtend)

@property (nonatomic) CGFloat if_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat if_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat if_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat if_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat if_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat if_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat if_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat if_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint if_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  if_size;        ///< Shortcut for frame.size.

/**
 移除当前View的所有子视图
 */
- (void)if_removeAllSubviews;

/**
 对当前的视图进行截屏操作。

 @return 当前视图对应的图片对象
 */
- (UIImage *)if_snapshotImage;

@end


@interface UIView (IFScreenshot)

- (UIImage *)if_screenShot;

- (UIImage *)if_screenShotWithHeight:(CGFloat)height;

- (UIImage *)if_screentableViewShot:(UITableView *)tableView;

@end


typedef NS_OPTIONS(NSUInteger, IFShadowOptions) {
    IFShadowTop     = 1 << 0,//左上角
    IFShadowLeft    = 1 << 1,//右上角
    IFShadowBottom  = 1 << 2,//左下角
    IFShadowRight   = 1 << 3,//右下角
    IFShadowAll     = IFShadowTop | IFShadowLeft | IFShadowBottom | IFShadowRight
};

@interface UIView (IFTheme)

/**
 添加阴影
 @param color 阴影颜色
 @param offset 阴影偏移
 @param radius 阴影圆角
 @param options 阴影偏移方向
 */
- (void)if_addShodowWithColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius options:(IFShadowOptions)options;

/**
 添加虚线
 /// - Parameters:
 ///   - lineLength: 虚线实线长度
 ///   - lineSpacing: 虚线间隙长度
 ///   - lineColor: 虚线颜色
 ///   - width: 虚线宽度
 ///   - startPoint: 起始点
 ///   - endPoint: 终点
 */
- (void)if_drawDashLineWithLength:(CGFloat)length color:(UIColor *)color space:(CGFloat)space width:(CGFloat)width startPoint:(CGPoint) startPoint endPoint:(CGPoint)endPoint;

@end


@interface UIView (IFController)

- (UIViewController *)if_viewController;

@end
