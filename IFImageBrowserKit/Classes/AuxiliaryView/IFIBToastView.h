//
//  IFIBToastView.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/20.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YBIBToast)

- (void)ybib_showHookToast:(NSString *)text;

- (void)ybib_showForkToast:(NSString *)text;

- (void)ybib_hideToast;

@end


typedef NS_ENUM(NSInteger, YBIBToastType) {
    YBIBToastTypeNone,
    YBIBToastTypeHook,
    YBIBToastTypeFork
};

@interface IFIBToastView : UIView

- (void)showWithText:(NSString *)text type:(YBIBToastType)type;

@end

NS_ASSUME_NONNULL_END
