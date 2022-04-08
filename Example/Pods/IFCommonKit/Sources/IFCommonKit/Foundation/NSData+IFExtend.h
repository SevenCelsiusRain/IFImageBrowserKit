//
//  NSData+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (IFExtend)

/**
 Data -> UT8字符串

 @return UTF8字符串
 */
- (NSString * _Nonnull)if_UTF8String;

/**
 Data -> JSON对象

 @return JSON对象
 */
- (nullable id)if_jsonObject;

#pragma mark - Encode & Decode

/**
 @return md5加密后的全小写的字符串
 */
- (nullable NSString *)if_md5String;

/**
 
 @param key hmac的key
 @return 使用sha256算法加密的字符串
 */
- (nullable NSString *)if_hmacSHA256StringWithKey:(NSString * _Nonnull)key;

/**
 
 @param key hmac的key
 @return 使用sha512算法加密的字符串
 */
- (nullable NSString *)if_hmacSHA512StringWithKey:(NSString * _Nonnull)key;

/**
 返回使用AES加密后的NSData, 填充模式 kCCOptionPKCS7Padding

 @param key 长度为16、24、32（128、192或256bits）的密钥
 @param iv 长度为16的初始化向量值（128bit）
 @return 加密后的NSData，或者nil（error产生时）
 */
- (nullable NSData *)if_aesEncryptWithKey:(NSData * _Nonnull)key iv:(nullable NSData *)iv;

/**
 返回AES解密后的NSData, 填充模式 kCCOptionPKCS7Padding

 @param key 长度为16、24、32（128、192或256bits）的密钥
 @param iv 长度为16的初始化向量值（128bit）
 @return 解密后的NSData，或者nil（error产生时）
 */
- (nullable NSData *)if_aesDecryptWithKey:(NSData * _Nonnull)key iv:(nullable NSData *)iv;

/**
 @return 返回全部大写的十六进制字符串
 */
- (nullable NSString *)if_hexString;

@end

NS_ASSUME_NONNULL_END
