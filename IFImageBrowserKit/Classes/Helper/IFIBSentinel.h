//
//  YBIBSentinel.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/18.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Thread safe.
 */
@interface IFIBSentinel : NSObject

/// Returns the current value of the counter.
@property (readonly) int32_t value;

/**
 Increase the value atomically.
 @return The new value.
 */
- (int32_t)increase;

@end

NS_ASSUME_NONNULL_END
