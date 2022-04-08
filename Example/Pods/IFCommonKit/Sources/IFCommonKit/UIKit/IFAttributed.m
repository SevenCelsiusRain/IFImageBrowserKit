//
//  IFAttributed.m
//  IFCommonKit
//
//  Created by MrGLZh on 2022/3/3.
//

#import "IFAttributed.h"

@implementation IFAttributed
+ (instancetype)attributed {
    IFAttributed *attri = [[IFAttributed alloc] init];
    return attri;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _normalFont = [UIFont systemFontOfSize:17];
        _normalColor = UIColor.blackColor;
    }
    return self;
}

@end
