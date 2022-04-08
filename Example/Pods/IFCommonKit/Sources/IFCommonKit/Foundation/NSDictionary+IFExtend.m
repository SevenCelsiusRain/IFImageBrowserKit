//
//  NSDictionary+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "NSDictionary+IFExtend.h"
#import <objc/runtime.h>
#import "NSObject+IFExtend.h"
#import "IFLogMacros.h"

@implementation NSDictionary (IFExtend)

#pragma mark - private method

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self if_swizzleInstanceMethod:@selector(initWithObjects:forKeys:count:) swizzledSelector:@selector(if_initWithObjects:forKeys:count:)];
        [self if_swizzleInstanceMethod:@selector(dictionaryWithObjects:forKeys:count:) swizzledSelector:@selector(if_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)if_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            NSLog(@"-------- %s 注意！字典以空值初始化 %s -------\n", class_getName(self.class), __func__);
            //[NSDictionary sendException:nil forKey:nil reason:@"字典以空值初始化"];
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self if_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)if_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            NSLogError(@"-------- %s 注意！字典以空值初始化 %s -------\n", class_getName(self.class), __func__);
            //[NSDictionary sendException:nil forKey:nil reason:@"字典以空值初始化"];
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self if_initWithObjects:safeObjects forKeys:safeKeys count:j];
}


#pragma mark - public method
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


@implementation NSMutableDictionary (IFExtend)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class if_swizzleInstanceMethod:@selector(setObject:forKey:) swizzledSelector:@selector(if_setObject:forKey:)];
    });
}

- (void)if_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey) {
        return;
    }
    if (!anObject) {
        NSLogError(@"-------- %s 注意！字典赋空值 %s -------\n", class_getName(self.class), __func__);
        //[NSMutableDictionary sendException:nil forKey:nil reason:@"字典赋空值"];
        anObject = [NSNull null];
    }
    [self if_setObject:anObject forKey:aKey];
}

@end
