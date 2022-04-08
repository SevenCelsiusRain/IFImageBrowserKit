//
//  NSObject+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (IFExtend)

/**
@return 返回当前类的类名
 */
- (NSString *)if_className;

/**
 @return 返回当前类的类名
 */
+ (NSString *)if_className;

#pragma mark - Method Swizzling

/**
 交换一个类的实例方法的实现，该操作比较危险，谨慎操作。

 @param originSelector 原方法的selector
 @param swizzledSelector 交换后的方法selector
 @return 是否成功
 */
+ (BOOL)if_swizzleInstanceMethod:(SEL)originSelector
                swizzledSelector:(SEL)swizzledSelector;

/**
 交换一个类的类方法的实现，该操作比较危险，谨慎操作。
 
 @param originSelector 原方法的selector
 @param swizzledSelector 交换后的方法selector
 @return 是否成功
 */
+ (BOOL)if_swizzleClassMethod:(SEL)originSelector
             swizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
