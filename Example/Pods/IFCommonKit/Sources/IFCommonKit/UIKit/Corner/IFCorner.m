//
//  IFCornerModel.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "IFCorner.h"

@implementation IFGradualChangingColor

- (instancetype)initWithColorFrom:(UIColor *)from to:(UIColor *)to type:(IFGradualChangeType)type {
    if (self = [super init]) {
        _fromColor = from;
        _toColor = to;
        _type = type;
    }
    return self;
}

+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to {
    return [[self alloc] initWithColorFrom:from to:to type:IFGradualChangeTypeUpLeftToDownRight];
}

+ (instancetype)gradualChangingColorFrom:(UIColor *)from to:(UIColor *)to type:(IFGradualChangeType)type {
    return [[self alloc] initWithColorFrom:from to:to type:type];
}

@end

@implementation IFCorner

- (instancetype)initWithRadius:(IFRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (self = [super init]) {
        _radius = radius;
        _fillColor = fillColor;
        _borderColor = borderColor;
        _borderWidth = borderWidth;
    }
    return self;
}

+ (instancetype)cornerWithRadius:(IFRadius)radius fillColor:(UIColor *)fillColor {
    return [[self alloc] initWithRadius:radius fillColor:fillColor borderColor:nil borderWidth:0];
}

+ (instancetype)cornerWithRadius:(IFRadius)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    return [[self alloc] initWithRadius:radius fillColor:fillColor borderColor:borderColor borderWidth:borderWidth];
}

@end
