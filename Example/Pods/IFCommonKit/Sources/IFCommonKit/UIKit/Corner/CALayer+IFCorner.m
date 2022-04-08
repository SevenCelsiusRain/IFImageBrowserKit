//
//  CALayer+IFCorner.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "CALayer+IFCorner.h"
#import <objc/runtime.h>
#import "IFCorner.h"

@implementation CALayer (IFCorner)

@dynamic if_corner;
static const char * if_layer_key = "if_layer_key";
static const char * if_corner_key = "if_corner_key";

- (CAShapeLayer *)if_layer {
    CAShapeLayer *layer = objc_getAssociatedObject(self, &if_layer_key);
    if (!layer) {
        layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        [self insertSublayer:layer atIndex:0];
        self.if_layer = layer;
    }
    return layer;
}

- (void)setIf_layer:(CAShapeLayer *)if_layer {
    objc_setAssociatedObject(self, &if_layer_key, if_layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (IFCorner *)if_corner {
    IFCorner *corner = objc_getAssociatedObject(self, &if_corner_key);
    if (!corner) {
        corner = [[IFCorner alloc] init];
        self.if_corner = corner;
    }
    return corner;
}

- (void)setIf_corner:(IFCorner *)if_corner {
    objc_setAssociatedObject(self, &if_corner_key, if_corner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)if_updateCornerRadius:(void (^)(IFCorner *))handler {
    if (handler) {
        handler(self.if_corner);
    }
    CGColorRef fill = self.if_corner.fillColor.CGColor;
    if (!fill || CGColorEqualToColor(fill, [UIColor clearColor].CGColor)) {
        if (!self.backgroundColor || CGColorEqualToColor(self.backgroundColor, [UIColor clearColor].CGColor)) {
            if (!self.if_corner.borderColor || CGColorEqualToColor(self.if_corner.borderColor.CGColor, [UIColor clearColor].CGColor)) {
                return;
            }
        }
        fill = self.backgroundColor;
        self.backgroundColor = [UIColor clearColor].CGColor;
    }
    
    IFRadius radius = self.if_corner.radius;
    if (radius.upLeft < 0) {
        radius.upLeft = 0;
    }
    if (radius.upRight < 0) {
        radius.upRight = 0;
    }
    if (radius.downLeft < 0) {
        radius.downLeft = 0;
    }
    if (radius.downRight < 0) {
        radius.downRight = 0;
    }
    if (self.if_corner.borderWidth < 0) {
        self.if_corner.borderWidth = 0;
    }
    
    CGRect if_frame = self.bounds;
    if_frame.origin.x = self.if_corner.borderWidth * 0.5;
    if_frame.origin.y = self.if_corner.borderWidth * 0.5;
    if_frame.size.width -= self.if_corner.borderWidth;
    if_frame.size.height -= self.if_corner.borderWidth;
    self.if_layer.frame = if_frame;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = if_frame.size.height;
    CGFloat width = if_frame.size.width;
    //左下
    [path moveToPoint:CGPointMake(radius.upLeft, 0)];
    [path addQuadCurveToPoint:CGPointMake(0, radius.upLeft) controlPoint:CGPointZero];
    //左上
    [path addLineToPoint:CGPointMake(0, height - radius.downLeft)];
    [path addQuadCurveToPoint:CGPointMake(radius.downLeft, height) controlPoint:CGPointMake(0, height)];
    //右上
    [path addLineToPoint:CGPointMake(width - radius.downRight, height)];
    [path addQuadCurveToPoint:CGPointMake(width, height - radius.downRight) controlPoint:CGPointMake(width, height)];
    //右下
    [path addLineToPoint:CGPointMake(width, radius.upRight)];
    [path addQuadCurveToPoint:CGPointMake(width - radius.upRight, 0) controlPoint:CGPointMake(width, 0)];
    [path closePath];
    [path addClip];
    
    self.if_layer.fillColor = fill;
    self.if_layer.strokeColor = self.if_corner.borderColor.CGColor;
    self.if_layer.lineWidth = self.if_corner.borderWidth;
    self.if_layer.path = path.CGPath;
}


@end
