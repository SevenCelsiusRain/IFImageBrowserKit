//
//  NSData+IFExtend.m
//  IFBaseKit
//
//  Created by MrGLZh on 2021/12/29.
//

#import "NSData+IFExtend.h"
#include <CommonCrypto/CommonCrypto.h>

@implementation NSData (IFExtend)

#pragma mark - Private

- (NSString *)if_hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(alg, cKey, strlen(cKey), self.bytes, self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

#pragma mark - Public

- (NSString *)if_UTF8String {
    if (self.length > 0) {
        return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    }
    return @"";
}

- (id)if_jsonObject {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:0 error:&error];
    if (error) {
        NSLog(@"JSONData to Object error: %@", error);
    }
    return value;
}

#pragma mark - Encode & Decode

- (NSString *)if_md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)if_hmacSHA256StringWithKey:(NSString *)key {
    return [self if_hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

- (NSString *)if_hmacSHA512StringWithKey:(NSString *)key {
    return [self if_hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

- (NSData *)if_aesEncryptWithKey:(NSData *)key iv:(NSData *)ivalue {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    if (ivalue.length != 16 && ivalue.length != 0) {
        return nil;
    }
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          ivalue.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        return result;
    }
    free(buffer);
    return nil;
}

- (NSData *)if_aesDecryptWithKey:(NSData *)key iv:(NSData *)ivalue {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    if (ivalue.length != 16 && ivalue.length != 0) {
        return nil;
    }
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          ivalue.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc] initWithBytes:buffer length:encryptedSize];
        free(buffer);
        return result;
    }
    free(buffer);
    return nil;
}

- (NSString *)if_hexString {
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02X", *byte];
    }
    return result;
}

@end
