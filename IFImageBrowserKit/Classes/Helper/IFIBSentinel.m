//
//  YBIBSentinel.m
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/18.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBSentinel.h"
#import <libkern/OSAtomic.h>

@implementation IFIBSentinel {
    int32_t _value;
}

- (int32_t)value {
    return _value;
}

- (int32_t)increase {
    return OSAtomicIncrement32(&_value);
}

@end
