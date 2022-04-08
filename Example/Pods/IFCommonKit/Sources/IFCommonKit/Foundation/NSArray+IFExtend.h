//
//  NSArray+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (IFExtend)

/**
 当前数组是否为空

 @return 是否为空数组
 */
- (BOOL)if_isEmptyArray;

/**
 非数组类型的对象或者数组中元素个数为0，则表示为空。

 @param array 对象
 @return 数组是否为空
 */
+ (BOOL)if_isEmptyArray:(NSArray *)array;

/**
 去除重复元素
 */
- (NSArray *)if_filterDuplicates;

/**
 乱序
 */
- (NSArray *)if_shuffle;

/**
 翻转
 */
- (NSArray *)if_reverse;


/**
 返回数组中index对应的对象，如果index越界则返回nil对象。避免crash。

 @param index 待返回数据所在的索引位置
 @return 数组中的对象，如果index越界则返回nil对象。
 */
- (nullable ObjectType)if_objectOrNilAtIndex:(NSUInteger)index;

/**
 将Array对象转换成普通样式的JSON字符串
 
 @return JSON字符串，如果发生错误则返回nil。
 */
- (NSString *)if_jsonString;

/**
 将Array对象转换成格式化后的JSON字符串，便于查看和打印
 
 @return JSON字符串，如果发生错误则返回nil。
 */
- (NSString *)if_prettyJSONString;

@end

@interface NSMutableArray<ObjectType> (IFExtend)

/**
 删除数组中的第一个元素，如果数组为空，则不做任何操作。
 */
- (void)if_removeFirstObject;

/**
 删除数组中的最后一个元素，如果数组为空，则不做任何操作。
 */
- (void)if_removeLastObject;

@end

NS_ASSUME_NONNULL_END
