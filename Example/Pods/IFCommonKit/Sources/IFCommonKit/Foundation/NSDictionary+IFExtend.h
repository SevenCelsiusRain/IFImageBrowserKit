//
//  NSDictionary+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (IFExtend)

/**
 将Dictionary对象转换成普通样式的JSON字符串

 @return JSON字符串，如果发生错误则返回nil。
 */
- (NSString *)if_jsonString;

/**
 将Dictionary对象转换成格式化后的JSON字符串，便于查看和打印
 
 @return JSON字符串，如果发生错误则返回nil。
 */
- (NSString *)if_prettyJSONString;

@end

@interface NSMutableDictionary (IFExtend)

@end

NS_ASSUME_NONNULL_END
