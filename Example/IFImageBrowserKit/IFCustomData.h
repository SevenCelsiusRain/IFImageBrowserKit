//
//  IFCustomData.h
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFIBDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface IFCustomData : NSObject<IFIBDataProtocol>
@property (nonatomic, copy) NSString *text;

@end

NS_ASSUME_NONNULL_END
