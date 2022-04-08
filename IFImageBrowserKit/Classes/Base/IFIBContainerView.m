//
//  YBIBContainerView.m
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/7/11.
//  Copyright © 2022 杨波. All rights reserved.
//

#import "IFIBContainerView.h"

@implementation IFIBContainerView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *originView = [super hitTest:point withEvent:event];
    if ([originView isKindOfClass:self.class]) {
        // Continue hit-testing if the view is kind of 'self.class'.
        return nil;
    }
    return originView;
}

@end
