//
//  NSString+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "NSString+IFExtend.h"
#import "NSData+IFExtend.h"

@implementation NSString (IFExtend)

#pragma mark - Public Methods

- (BOOL)if_isEmpty {
    return self.length <= 0;
}

+ (BOOL)if_isEmpty:(NSString *)string {
    if (![string isKindOfClass:NSString.class]) {
        return YES;
    }
    return string.length <= 0;
}


- (NSString *)if_capitalizedString {
    NSString *result = @"";
    if (self.length > 0) {
        NSString *firstCharacter = [self substringToIndex:1];
        NSString *lastStr = [self substringFromIndex:1];
        result = [NSString stringWithFormat:@"%@%@", [firstCharacter uppercaseString], lastStr];
    }
    return result;
}

- (NSData *)if_UTF8Data {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)if_jsonObject {
    return [[self if_UTF8Data] if_jsonObject];
}

+ (NSString *)if_nonNilString:(NSString *)originStr {
    if ([originStr isKindOfClass:[NSString class]]) {
        return originStr;
    }
    return @"";
}

+ (NSString *)if_UUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

#pragma mark - 文本内容大小计算

- (CGSize)if_sizeWithAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes
                 constraintSize:(CGSize)constraintSize {
    if (self.length > 0) {
        CGRect bounds = [self boundingRectWithSize:constraintSize
                                           options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];
        return bounds.size;
    }
    
    return CGSizeZero;
}

- (CGSize)if_sizeWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize {
    NSDictionary *attribute = nil;
    if (font) {
        attribute = @{NSFontAttributeName: font};
    }
    return [self if_sizeWithAttributes:attribute constraintSize:constraintSize];
}

- (CGSize)if_sizeWithFontSize:(CGFloat)fontSize constraintSize:(CGSize)constraintSize {
    return [self if_sizeWithFont:[UIFont systemFontOfSize:fontSize] constraintSize:constraintSize];
}

#pragma mark - URL
/**
 Returns a percent-escaped string following RFC 3986 for a query string key or value.
 RFC 3986 states that the following characters are "reserved" characters.
 - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
 - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
 
 In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
 query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
 should be percent-escaped in the query string.
 
 @return The percent-escaped string.
 */
- (NSString *)if_urlEncode {
    
    // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kMAGeneralDelimitersToEncode = @":#[]@?/";
    static NSString * const kMASubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet *allowedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet].mutableCopy;
    NSString *removedChars = [kMAGeneralDelimitersToEncode stringByAppendingString:kMASubDelimitersToEncode];
    [allowedCharacterSet removeCharactersInString:removedChars];
    
    //    return [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharset];
    
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    NSString *string = self;
    
    while (index < string.length) {
        
        NSUInteger subLength = string.length - index;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
        NSUInteger length = MIN(subLength, batchSize);
#pragma clang diagnostic pop
        NSRange range = NSMakeRange(index, length);
        
        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [string rangeOfComposedCharacterSequencesForRange:range];
        
        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    
    return escaped;
}

- (NSString *)if_chineseUrlEncode {
    CFStringRef unescapeStr = (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]";
    NSString *encodedString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                        (CFStringRef)self,
                                                                                        unescapeStr,
                                                                                        NULL,
                                                                                        kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString *)if_urlDecode {
    return [self stringByRemovingPercentEncoding];
}

- (NSDictionary *)if_urlQueryParameters:(BOOL)shouldDecode {
    if (self.length <= 0) {
        return nil;
    }
    
    static NSString * const kMAURLParserParamSeparator    = @"&";
    static NSString * const kMAURLParserKeyValueSeparator = @"=";
    
    NSArray *urlParams = [self componentsSeparatedByString:kMAURLParserParamSeparator];
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionary];
    
    for (NSString *paramStr in urlParams) {
        
        NSRange range = [paramStr rangeOfString:kMAURLParserKeyValueSeparator];
        if (range.location != NSNotFound && range.location > 0) {
            NSString *paramName  = [[paramStr substringToIndex:range.location] if_urlDecodeDynamic:shouldDecode];
            NSString *paramValue = [[paramStr substringFromIndex:range.location+1] if_urlDecodeDynamic:shouldDecode];
            [self if_setValue:paramValue forKey:paramName dictionary:requestParams];
        }
    }
    
    if ([requestParams count] > 0) {
        return requestParams;
    }
    
    return nil;
}

#pragma mark - Encode & Decode

- (NSString *)if_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] if_md5String];
}

- (NSString *)if_base64EncodeString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}

+ (NSString *)if_stringWithBase64EncodedString:(NSString *)base64EncodedString {
    if (!base64EncodedString) {
        return nil;
    }
    
    NSData *base64EncodedData = [[NSData alloc] initWithBase64EncodedString:base64EncodedString options:0];
    return [[NSString alloc] initWithData:base64EncodedData encoding:NSUTF8StringEncoding];
}

- (NSString *)if_hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] if_hmacSHA256StringWithKey:key];
}

- (NSString *)if_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] if_hmacSHA512StringWithKey:key];
}

- (NSString *)if_aesEncryptWithKey:(NSString *)key iv:(NSString *)ivalue {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData  = [ivalue dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data    = [[self dataUsingEncoding:NSUTF8StringEncoding] if_aesEncryptWithKey:keyData iv:ivData];
    if (data) {
        return [data base64EncodedStringWithOptions:0];
    }
    return nil;
}

- (NSString *)if_aesDecryptWithKey:(NSString *)key iv:(NSString *)ivalue {
    NSData *encryptData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    if (!encryptData) {
        return nil;
    }
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData  = [ivalue dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data    = [encryptData if_aesDecryptWithKey:keyData iv:ivData];
    
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)if_hexString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] if_hexString];
}


#pragma mark - Private Methods

- (NSString *)if_urlDecodeDynamic:(BOOL)shouldDecode {
    if (shouldDecode) {
        return [self if_urlDecode];
    }
    return self;
}

- (void)if_setValue:(NSString *)value forKey:(NSString *)key dictionary:(NSMutableDictionary *)dict {
    if (!key || !value) {
        return;
    }
    id oldValue = dict[key];
    if (oldValue) {
        if ([oldValue isKindOfClass:[NSMutableArray class]]) {
            [oldValue addObject:value];
        } else {
            dict[key] = [NSMutableArray arrayWithObjects:oldValue, value, nil];
        }
    } else {
        dict[key] = value;
    }
}


#pragma mark - 规则判断

- (BOOL)if_isChinese {
    return [NSString if_isChinese:self];
}
/**
 为否为中文
 */
+ (BOOL)if_isChinese:(NSString *)str {
    for(int i = 0; i < str.length; i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a <0x9fff) {
            return YES;
        }
    }
    return NO;
}

// MARK: 是否全部为中文
- (BOOL)if_isAllChinese {
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if(![pred evaluateWithObject:self]){
        return NO;
    }
    return YES;
}

- (NSString *)deleteSpecialCharacters {
    if (self.length <= 0) {
        return @"";
    }
    NSError *error = nil;
    NSString *pattern = @"[^a-zA-Z0-9\u4e00-\u9fa5]";//正则取反
    NSRegularExpression *regularExpress = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];//这个正则可以去掉所有特殊字符和标点
    NSString *string = [regularExpress stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
    
    return string;
}



+ (BOOL)if_isMobileNumber:(NSString *)mobileNum{

    NSString *pattern = @"^1[35678]\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)if_checkUserID:(NSString *)userID {
    //长度不为18的都排除掉
    if (userID.length != 18) {
        return NO;
    }
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";

    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    if (!flag) {
        return flag;//格式错误
    }else{
        //格式正确在判断是否合法
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++){
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
        }
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]){
                return YES;
            }else{
                return NO;
            }
        }
    }
}

+ (BOOL)if_checkCarID:(NSString *)carID {
    if (carID.length != 7) {
        return NO;
    }
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-zA-HJ-Z]{1}[a-hj-zA-HJ-Z_0-9]{4}[a-hj-zA-HJ-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carID];
}

+ (BOOL)if_checkPsw:(NSString *)pswStr {
    NSString * pattern = @"^[A-Za-z0-9_]{6,16}$";
    //    NSString *condition =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:pswStr];
}


+(BOOL)if_isAllNumber:(NSString *)string{
    NSString *condition = @"^[0-9]*$";//是否都是数字
//    NSString *condition = @"^[A-Za-z]+$";//是否都是字母
//    NSString *condition = @"^[A-Za-z0-9]+$";//是否都是字母和数字{6,16}
//    NSString *condition = @"^[A-Za-z0-9]{6,16}$";//是否都是字母和数字且长度在[6,16]
//    NSString *condition = @"^[\u4e00-\u9fa5]{0,}$";//只能输入汉字
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",condition];
    return [predicate evaluateWithObject:string];
}

+(BOOL)if_isBankCard:(NSString *)bankCard{
    if (bankCard.length < 16) {
        return NO;
    }
    NSInteger oddsum = 0;//奇数求和
    NSInteger evensum = 0;//偶数求和
    NSInteger allsum = 0;

    NSInteger cardNoLength = (NSInteger)[bankCard length];
    // 取了最后一位数
    NSInteger lastNum = [[bankCard substringFromIndex:cardNoLength-1] intValue];
    //测试的是除了最后一位数外的其他数字
    bankCard = [bankCard substringToIndex:cardNoLength - 1];
    for (NSInteger i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankCard substringWithRange:NSMakeRange(i-1, 1)];
        NSInteger tmpVal = [tmpString integerValue];
        if (cardNoLength % 2 ==1 ) {//卡号位数为奇数
            if((i % 2) == 0){//偶数位置
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{//奇数位置
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else{
        return NO;
    }
}

+(BOOL)if_isEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark - 字符串处理

- (NSString *)if_removeSpaceAndLineBreak {
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

- (NSString *)if_removeSpaceAtBothEnds {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)lengthDistinguishChineseAndEnglish {
    NSUInteger length = 0;
    for (NSUInteger i = 0, l = self.length; i < l; i++) {
        unichar character = [self characterAtIndex:i];
        if (isascii(character)) {
            length += 1;
        } else {
            length += 2;
        }
    }
    return length;
}


@end
