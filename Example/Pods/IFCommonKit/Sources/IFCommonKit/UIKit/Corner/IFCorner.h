//
//  IFCornerModel.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

struct IFRadius {
    CGFloat upLeft; // 左上
    CGFloat upRight; // 右上
    CGFloat downLeft; // 左下
    CGFloat downRight; // 右下
};

typedef struct IFRadius IFRadius;
static IFRadius const IFRadiusZero = (IFRadius){0, 0, 0, 0};

NS_INLINE bool IFRadiusIsEqual(IFRadius radius1, IFRadius radius2) {
    return radius1.upLeft == radius2.upLeft && radius1.upRight == radius2.upRight && radius1.downLeft == radius2.downLeft && radius1.downRight == radius2.downRight;
}

NS_INLINE IFRadius IFRadiusMake(CGFloat upLeft, CGFloat upRight, CGFloat downLeft, CGFloat downRight) {
    IFRadius radius;
    radius.upLeft = upLeft;
    radius.upRight = upRight;
    radius.downLeft = downLeft;
    radius.downRight = downRight;
    return radius;
}

NS_INLINE IFRadius IFRadiusMakeSame(CGFloat radius) {
    IFRadius result;
    result.upLeft = radius;
    result.upRight = radius;
    result.downLeft = radius;
    result.downRight = radius;
    return result;
}

typedef NS_ENUM(NSUInteger, IFGradualChangeType) {
    IFGradualChangeTypeUpLeftToDownRight = 0,
    IFGradualChangeTypeUpToDown,
    IFGradualChangeTypeLeftToRight,
    IFGradualChangeTypeUpRightToDownLeft
};

@interface IFGradualChangingColor : NSObject

@property (nonatomic, strong) UIColor *fromColor;
@property (nonatomic, strong) UIColor *toColor;
@property (nonatomic, assign) IFGradualChangeType type;

@end

@interface IFCorner : NSObject
/** 4个圆角的半径*/
@property (nonatomic, assign) IFRadius radius;
/** 将要填充layer/view的颜色*/
@property (nonatomic, strong) UIColor *fillColor;
/** 边框颜色*/
@property (nonatomic, strong) UIColor *borderColor;
/** 边框宽度*/
@property (nonatomic, assign) CGFloat borderWidth;

@end
