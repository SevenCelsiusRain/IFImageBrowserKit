//
//  YBIBInteractionProfile.m
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/30.
//  Copyright © 2022 杨波. All rights reserved.
//

#import "IFIBInteractionProfile.h"

@implementation IFIBInteractionProfile

- (instancetype)init {
    self = [super init];
    if (self) {
        _disable = NO;
        _dismissScale = 0.22;
        _dismissVelocityY = 800;
        _restoreDuration = 0.15;
        _triggerDistance = 3;
    }
    return self;
}

@end
