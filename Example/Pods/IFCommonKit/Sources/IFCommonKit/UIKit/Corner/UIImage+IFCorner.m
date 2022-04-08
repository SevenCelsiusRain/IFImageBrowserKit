//
//  UIImage+IFCorner.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "UIImage+IFCorner.h"

@implementation UIImage (IFCorner)

static UIBezierPath * if_pathWithCornerRadius(IFRadius radius, CGSize size) {
    CGFloat imgW = size.width;
    CGFloat imgH = size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    //左下
    [path addArcWithCenter:CGPointMake(radius.downLeft, imgH - radius.downLeft) radius:radius.downLeft startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    //左上
    [path addArcWithCenter:CGPointMake(radius.upLeft, radius.upLeft) radius:radius.upLeft startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    //右上
    [path addArcWithCenter:CGPointMake(imgW - radius.upRight, radius.upRight) radius:radius.upRight startAngle:M_PI_2 * 3 endAngle:0 clockwise:YES];
    //右下
    [path addArcWithCenter:CGPointMake(imgW - radius.downRight, imgH - radius.downRight) radius:radius.downRight startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path closePath];
    return path;
}

+ (UIImage *)if_imageWithGradualChangingColor:(void (^)(IFGradualChangingColor *))handler size:(CGSize)size cornerRadius:(IFRadius)radius {
    IFGradualChangingColor *graColor = [[IFGradualChangingColor alloc] init];
    if (handler) {
        handler(graColor);
    }
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = (CGRect){CGPointZero, size};
    CGFloat startX = 0, startY = 0, endX = 0, endY = 0;
    switch (graColor.type) {
        case IFGradualChangeTypeUpLeftToDownRight: {
            startX = 0;
            startY = 0;
            endX = 1;
            endY = 1;
        }
            break;
        case IFGradualChangeTypeUpToDown: {
            startX = 0;
            startY = 0;
            endX = 0;
            endY = 1;
        }
            break;
        case IFGradualChangeTypeLeftToRight: {
            startX = 0;
            startY = 0;
            endX = 1;
            endY = 0;
        }
            break;
        case IFGradualChangeTypeUpRightToDownLeft: {
            startX = 0;
            startY = 1;
            endX = 1;
            endY = 0;
        }
            break;
    }
    graLayer.startPoint = CGPointMake(startX, startY);
    graLayer.endPoint = CGPointMake(endX, endY);
    graLayer.colors = @[(__bridge id)graColor.fromColor.CGColor, (__bridge id)graColor.toColor.CGColor];
    graLayer.locations = @[@0.0, @1.0];
    return [self if_imageWithLayer:graLayer cornerRadius:radius];
}

+ (UIImage *)if_imageWithTMOCorner:(void (^)(IFCorner *))handler size:(CGSize)size {
    IFCorner *corner = [[IFCorner alloc] init];
    if (handler) {
        handler(corner);
    }
    if (!corner.fillColor) {
        corner.fillColor = [UIColor clearColor];
    }
    UIBezierPath *path = if_pathWithCornerRadius(corner.radius, size);
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            CGContextSetStrokeColorWithColor(rendererContext.CGContext, corner.borderColor.CGColor);
            CGContextSetFillColorWithColor(rendererContext.CGContext, corner.fillColor.CGColor);
            CGContextSetLineWidth(rendererContext.CGContext, corner.borderWidth);
            [path addClip];
            CGContextAddPath(rendererContext.CGContext, path.CGPath);
            CGContextDrawPath(rendererContext.CGContext, kCGPathFillStroke);
        }];
    } else {
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, corner.borderColor.CGColor);
        CGContextSetFillColorWithColor(context, corner.fillColor.CGColor);
        CGContextSetLineWidth(context, corner.borderWidth);
        CGContextAddPath(context, path.CGPath);
        [path addClip];
        CGContextDrawPath(context, kCGPathFillStroke);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

- (UIImage *)if_imageByAddingCornerRadius:(IFRadius)radius {
    UIBezierPath *path = if_pathWithCornerRadius(radius, self.size);
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:self.size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            [path addClip];
            CGContextAddPath(rendererContext.CGContext, path.CGPath);
            [self drawInRect:(CGRect){CGPointZero, self.size}];
        }];
    } else {
        UIGraphicsBeginImageContext(self.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [path addClip];
        CGContextAddPath(context, path.CGPath);
        [self drawInRect:(CGRect){CGPointZero, self.size}];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}



+ (UIImage *)if_imageWithColor:(UIColor *)color {
    return [self if_imageWithColor:color size:CGSizeMake(1, 1) cornerRadius:IFRadiusZero];
}

+ (UIImage *)if_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(IFRadius)radius {
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            if (!IFRadiusIsEqual(radius, IFRadiusZero)) {
                UIBezierPath *path = if_pathWithCornerRadius(radius, size);
                [path addClip];
                CGContextAddPath(rendererContext.CGContext, path.CGPath);
            }
            CGContextSetFillColorWithColor(rendererContext.CGContext, color.CGColor);
            CGContextFillRect(rendererContext.CGContext, (CGRect){CGPointZero, size});
        }];
    } else {
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (!IFRadiusIsEqual(radius, IFRadiusZero)) {
            UIBezierPath *path = if_pathWithCornerRadius(radius, size);
            [path addClip];
            CGContextAddPath(context, path.CGPath);
        }
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, (CGRect){CGPointZero, size});
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

+ (UIImage *)if_imageWithLayer:(CALayer *)layer cornerRadius:(IFRadius)radius {
    if (@available(iOS 10.0, *)) {
        UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:layer.bounds.size];
        return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            if (!IFRadiusIsEqual(radius, IFRadiusZero)) {
                UIBezierPath *path = if_pathWithCornerRadius(radius, layer.bounds.size);
                [path addClip];
                CGContextAddPath(rendererContext.CGContext, path.CGPath);
            }
            [layer renderInContext:rendererContext.CGContext];
        }];
    } else {
        UIGraphicsBeginImageContext(layer.bounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (!IFRadiusIsEqual(radius, IFRadiusZero)) {
            UIBezierPath *path = if_pathWithCornerRadius(radius, layer.bounds.size);
            [path addClip];
            CGContextAddPath(context, path.CGPath);
        }
        [layer renderInContext:context];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}


@end
