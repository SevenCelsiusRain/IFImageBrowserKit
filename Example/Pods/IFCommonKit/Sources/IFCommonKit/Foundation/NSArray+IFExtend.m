//
//  NSArray+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "NSArray+IFExtend.h"
#import <objc/runtime.h>
#import "NSObject+IFExtend.h"
#import "IFLogMacros.h"

@implementation NSArray (IFExtend)

#pragma mark - private method

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class__NSArrayI = NSClassFromString(@"__NSArrayI");
        [class__NSArrayI if_swizzleInstanceMethod:@selector(objectAtIndex:) swizzledSelector:@selector(if_ObjectAtIndex:)];
        [class__NSArrayI if_swizzleInstanceMethod:@selector(subarrayWithRange:) swizzledSelector:@selector(if_subarrayWithRange:)];

        Class class__NSArray0 = NSClassFromString(@"__NSArray0");
        [class__NSArray0 if_swizzleInstanceMethod:@selector(objectAtIndex:) swizzledSelector:@selector(if_ObjectAtIndex:)];
    
        Class class__NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        [class__NSSingleObjectArrayI if_swizzleInstanceMethod:@selector(objectAtIndex:) swizzledSelector:@selector(if_ObjectAtIndex:)];
        
        Class class__NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");
        [class__NSPlaceholderArray if_swizzleInstanceMethod:@selector(initWithObjects:count:) swizzledSelector:@selector(if_initWithObjects:count:)];
    });
}

- (NSArray *)if_subarrayWithRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        return @[];
    }
    return [self if_subarrayWithRange:range];
}

/** 语法糖初始化数组（@[xxx, ooo] 形式初始化数组）替换方法 */
- (instancetype)if_initWithObjects:(const id [])objects count:(NSUInteger)count {
    id safeObjects[count];
    BOOL isHasNilObj = false;
    for (NSUInteger i = 0; i < count; i++)
    {
        id obj = objects[i];
        if (obj == 0x00)
        {
            isHasNilObj = true;
            obj = [NSNull null];
        }
        safeObjects[i] = obj;
    }
    id result = [self if_initWithObjects:safeObjects count:count];
    if (!isHasNilObj)
    {
        return result;
    }
#ifdef DEBUG
    NSLogError(@"-------- %s 注意！数组以空值初始化 %s -------\n%@", class_getName(self.class), __func__, [NSString stringWithFormat:@"%@", result]);
#else
//    [NSArray sendException:nil forKey:nil reason:[NSString stringWithFormat:@"空值初始化数组->%@", result]];
#endif
    return result;
}

- (instancetype)if_ObjectAtIndex:(NSUInteger)index {
    if (self.count < index + 1 || index == NSUIntegerMax) {
#ifdef DEBUG
        @try {
            NSLogError(@"❌出❌现❌错❌误❌检❌查❌是❌否❌崩❌溃❌");
            return [self if_ObjectAtIndex:index];
        } @catch (NSException *exception) {
            [self checkLog:NSStringFromSelector(@selector(if_ObjectAtIndex:)) index:index];
            NSLogError(@"%@", [exception callStackSymbols]);
            @throw exception;
        }
#else
        [self checkLog:NSStringFromSelector(@selector(if_ObjectAtIndex:)) index:index];
//        [NSArray sendException:nil forKey:nil reason:@"数组越界"];
        return nil;
#endif
    } else {
        return [self if_ObjectAtIndex:index];
    }
}

- (void)checkLog:(NSString *)func index:(NSUInteger)index {
    if (self.count > 0) {
        NSLogError(@"-------- %@ Crash Because Method %@ index %lu beyond bounds [0..%lu]-------\n", NSStringFromClass([self class]), func, (unsigned long)index, (unsigned long)self.count - 1);
    } else {
        NSLogError(@"-------- %@ Crash Because Method %@ index %lu beyond bounds for empty array-------\n", NSStringFromClass([self class]), func, (unsigned long)index);
    }
}


#pragma mark - public method
- (BOOL)if_isEmptyArray {
    return [self count] == 0;
}

+ (BOOL)if_isEmptyArray:(NSArray *)array {
    return ![array isKindOfClass:[NSArray class]] || [array count] == 0;
}

- (NSArray *)if_shuffle {
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self];
    for (NSUInteger i = self.count; i > 1; i--) {
        [tempArr exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
    return tempArr.copy;
}

- (NSArray *)if_reverse {
    NSUInteger count = self.count;
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self];
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [tempArr exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
    return tempArr.copy;
}

- (NSArray *)if_filterDuplicates {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
    for (NSObject *obj in self) {
        if (![result containsObject:obj]) {
            [result addObject:obj];
        }
    }
    return result.copy;
}

- (id)if_objectOrNilAtIndex:(NSUInteger)index {
    if (self.count > index) {
        return self[index];
    }
    return nil;
}

- (NSString *)if_jsonString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        if (!error) {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    return nil;
}

- (NSString *)if_prettyJSONString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (!error) {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    return nil;
}

@end

@implementation NSMutableArray (IFExtend)

#pragma mark - private mthod
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSArrayM");
        [class if_swizzleInstanceMethod:@selector(subarrayWithRange:) swizzledSelector:@selector(if_subarrayWithRange:)];
        [class if_swizzleInstanceMethod:@selector(removeObjectAtIndex:) swizzledSelector:@selector(if_RemoveObjectAtIndex:)];
        [class if_swizzleInstanceMethod:@selector(objectAtIndex:) swizzledSelector:@selector(if_ObjectAtIndex:)];
        [class if_swizzleInstanceMethod:@selector(addObject:) swizzledSelector:@selector(if_addObject:)];
        [class if_swizzleInstanceMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(if_ObjectAtIndexedSubscript:)];
    });
}

- (NSArray *)if_subarrayWithRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        return @[];
    }
    return [self if_subarrayWithRange:range];
}

- (void)if_addObject:(id)aObject {
#ifndef __OPTIMIZE__
    if (!aObject)
    {
        NSString *str = [NSString stringWithFormat:@"%@:%d❌%s: attempt to insert nil object to NSMutableArray", [NSString stringWithUTF8String:__FILE__].lastPathComponent, __LINE__, __PRETTY_FUNCTION__];
        NSLog(@"%@", str);
    }
    [self if_addObject:aObject];
#else
    if (!aObject)
    {
//        NSString *str = [NSString stringWithFormat:@"%@:%d❌%s: attempt to insert nil object to NSMutableArray", [NSString stringWithUTF8String:__FILE__].lastPathComponent, __LINE__, __PRETTY_FUNCTION__];
//        [NSMutableArray sendException:nil forKey:nil reason:str];
    }
    else
    {
        [self if_addObject:aObject];
    }
#endif
}

- (instancetype)if_ObjectAtIndex:(NSUInteger)index {
    if (self.count < index + 1 || index == NSUIntegerMax) {
#ifdef DEBUG
        @try {
            NSLog(@"❌出❌现❌错❌误❌检❌查❌是❌否❌崩❌溃❌");
            return [self if_ObjectAtIndex:index];
        } @catch (NSException *exception) {
            [self checkLog:NSStringFromSelector(@selector(if_ObjectAtIndex:)) index:index];
            NSLogError(@"%@", [exception callStackSymbols]);
            @throw exception;
        }
#else
        [self checkLog:NSStringFromSelector(@selector(if_ObjectAtIndex:)) index:index];
//        [NSMutableArray sendException:nil forKey:nil reason:@"数组越界"];
        return nil;
#endif
    } else {
        return [self if_ObjectAtIndex:index];
    }
}

- (id)if_ObjectAtIndexedSubscript:(NSUInteger)index {
    if (self.count < index + 1 || index == NSUIntegerMax) {
#ifdef DEBUG
        @try {
            NSLog(@"❌出❌现❌错❌误❌检❌查❌是❌否❌崩❌溃❌");
            return [self if_ObjectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            [self checkLog:NSStringFromSelector(@selector(if_ObjectAtIndexedSubscript:)) index:index];
            NSLogError(@"%@", [exception callStackSymbols]);
            @throw exception;
        }
#else
        [self checkLog:NSStringFromSelector(@selector(if_ObjectAtIndexedSubscript:)) index:index];
//        [NSMutableArray sendException:nil forKey:nil reason:@"数组越界"];
        return nil;
#endif
    } else {
        return [self if_ObjectAtIndexedSubscript:index];
    }
}

- (void)if_RemoveObjectAtIndex:(NSUInteger)index {
    if (self.count < index + 1 || index == NSUIntegerMax) {
#ifdef DEBUG
        @try {
            NSLog(@"❌出❌现❌错❌误❌检❌查❌是❌否❌崩❌溃❌");
            [self if_RemoveObjectAtIndex:index];
        } @catch (NSException *exception) {
            [self checkLog:NSStringFromSelector(@selector(if_RemoveObjectAtIndex:)) index:index];
            NSLogError(@"%@", [exception callStackSymbols]);
            @throw exception;
        }
#else
        [self checkLog:NSStringFromSelector(@selector(if_RemoveObjectAtIndex:)) index:index];
//        [NSMutableArray sendException:nil forKey:nil reason:@"数组越界"];
#endif
    } else {
        [self if_RemoveObjectAtIndex:index];
    }
}


#pragma mark - public method
- (void)if_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (void)if_removeLastObject {
    if (self.count) {
        [self removeLastObject];
    }
}

//- (NSMutableArray *)if_filterDuplicates {
//    NSMutableArray *result = [NSMutableArray arrayWithCapacity:0];
//    for (NSObject *obj in self) {
//        if (![result containsObject:obj]) {
//            [result addObject:obj];
//        }
//    }
//    return result;
//}

//- (void)if_reverse {
//    NSUInteger count = self.count;
//    int mid = floor(count / 2.0);
//    for (NSUInteger i = 0; i < mid; i++) {
//        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
//    }
//}

//- (void)if_shuffle {
//    for (NSUInteger i = self.count; i > 1; i--) {
//        [self exchangeObjectAtIndex:(i - 1)
//                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
//    }
//}


@end
