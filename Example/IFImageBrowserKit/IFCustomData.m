//
//  IFCustomData.m
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import "IFCustomData.h"
#import "IFCustomCell.h"

@implementation IFCustomData

- (Class)yb_classOfCell {
    return IFCustomCell.self;
}

@end
