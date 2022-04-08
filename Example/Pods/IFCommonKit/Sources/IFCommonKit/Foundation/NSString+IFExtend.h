//
//  NSString+IFExtend.h
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (IFExtend)

#pragma mark - Basic

/**
 判断字符串是否为空字符串
 仅根据 length 进行判断
 @return 是否为空字符串
 */
- (BOOL)if_isEmpty;

+ (BOOL)if_isEmpty:(NSString *)string;

/**
 对字符串的首字母进行大写，其他位置保持不变

 @return 首字符大写的字符串
 */
- (NSString *)if_capitalizedString;

/**

 @return UTF8格式的Data
 */
- (NSData *)if_UTF8Data;


/**

 @return 转换成的JSON对象
 */
- (id)if_jsonObject;

/**
 检测源字符串是否为字符串对象，如果不是返回空字符串(@"")。
 检测源字符串如果为nil，则返回空字符串。

 @param originStr 源字符串
 @return 非空字符串
 */
+ (NSString *)if_nonNilString:(NSString *)originStr;

/**
 返回一个新的UUID字符串。
 e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"

 @return UUID字符串
 */
+ (NSString *)if_UUID;

#pragma mark - 文本内容大小计算

/**
 计算文本内容的大小

 @param attributes 文本属性集合
 @param constraintSize 约束大小
 @return 文本实际占用的大小
 */
- (CGSize)if_sizeWithAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes
                 constraintSize:(CGSize)constraintSize;

/**
 计算文本内容的大小

 @param font 字体
 @param constraintSize 约束大小
 @return 文本实际占用的大小
 */
- (CGSize)if_sizeWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize;

/**
 计算文本内容的大小，使用系统默认字体进行计算

 @param fontSize 字号大小，使用系统默认字体进行计算
 @param constraintSize 约束大小
 @return 文本实际占用的大小
 */
- (CGSize)if_sizeWithFontSize:(CGFloat)fontSize constraintSize:(CGSize)constraintSize;

#pragma mark - URL Parser

/**
 对当前的字符串进行URLEncode操作
 
 @return URLEncode操作后的结果值
 */
- (NSString *)if_urlEncode;

/**
 对URL中的中文进行编码
 
 @return 对中文进行编码后台的结果值
 */
- (NSString *)if_chineseUrlEncode;

/**
 对当前的字符串进行URLDecode操作
 
 @return URLDecode操作后的结果值
 */
- (NSString *)if_urlDecode;

/**
 将字符串内容按照URL的Query规则进行解析。
 解析规则如下：
 1. 先以&进行分隔产生数组。
 2. 再对数组中的内容按照=进行分隔产生参数名和参数值。
 3. 如果需要做URLDecode则对参数名和参数值进行URLDeoode操作。
 4. 最后将参数名和参数值以键值对的形式放到字典中。
 
 @param shouldDecode 是否需要进行URLDecode操作
 @return 以参数名和参数值为键值对的字典
 */
- (NSDictionary *)if_urlQueryParameters:(BOOL)shouldDecode;

#pragma mark - Encode & Decode
/**
 @return md5加密后的全小写的字符串
 */
- (NSString *)if_md5String;

/**
 @return Base64编码后的字符串
 */
- (NSString *)if_base64EncodeString;

/**
 @param base64EncodedString Base64编码后的字符串
 @return Base64解码后的字符串
 */
+ (nullable NSString *)if_stringWithBase64EncodedString:(nullable NSString *)base64EncodedString;

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
 返回使用AES加密后的字符串, 填充模式 kCCOptionPKCS7Padding
 
 @param key 长度为16、24、32（128、192或256bits）的密钥
 @param iv 长度为16的初始化向量值
 @return 加密后的字符串，或者nil（error产生时）
 */
- (nullable NSString *)if_aesEncryptWithKey:(NSString * _Nonnull)key iv:(nullable NSString *)iv;

/**
 返回AES解密后的字符串, 填充模式 kCCOptionPKCS7Padding
 
 @param key 长度为16、24、32（128、192或256bits）的密钥
 @param iv 长度为16的初始化向量值（128bit）
 @return 解密后的字符串，或者nil（error产生时）
 */
- (nullable NSString *)if_aesDecryptWithKey:(NSString * _Nonnull)key iv:(nullable NSString *)iv;

/**
 @return 返回全部大写的十六进制字符串
 */
- (nullable NSString *)if_hexString;


#pragma mark - 规则判断

/**
 是否为中文(包含)
 */
- (BOOL)if_isChinese;

+ (BOOL)if_isChinese:(NSString *)str;

/**
 是否全部为中文
 */
- (BOOL)if_isAllChinese;

/**
 删除所有的标点、特殊字符
 */
- (NSString *)deleteSpecialCharacters;

/**
 判断手机号码
 */
+ (BOOL)if_isMobileNumber:(NSString *)mobileNum;

/**
 判断身份证
 */
+ (BOOL)if_checkUserID:(NSString *)userID;

/**
 车牌号码格式验证
 */
+ (BOOL)if_checkCarID:(NSString *)carID;

/**
 6~16位数字/字母/下划线组成的密码格式校验
 */
+(BOOL)if_checkPsw:(NSString *)pswStr;

/**
 判断字符串是否全为[(数字)OR(数字|字母)OR(字母)OR(汉字)]
 */
+(BOOL)if_isAllNumber:(NSString *)string;

/**
 银行卡格式验证
 */
+(BOOL)if_isBankCard:(NSString *)bankCard;

/**
 邮箱格式验证
 */
+(BOOL)if_isEmail:(NSString *)email;

#pragma mark - 字符串处理
/**
 去除空格和换行符
 */
- (NSString *)if_removeSpaceAndLineBreak;

/**
 去除两端空格
 */
- (NSString *)if_removeSpaceAtBothEnds;


@property (nonatomic, readonly, assign) NSUInteger lengthDistinguishChineseAndEnglish;

@end

NS_ASSUME_NONNULL_END
