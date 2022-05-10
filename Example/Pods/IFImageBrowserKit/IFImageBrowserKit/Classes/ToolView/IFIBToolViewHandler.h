//
//  YBIBToolViewHandler.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/7/7.
//  Copyright © 2022 杨波. All rights reserved.
//

#import "IFIBSheetView.h"
#import "IFIBTopView.h"
#import "IFIBDataProtocol.h"
#import "IFIBOrientationReceiveProtocol.h"
#import "IFIBOperateBrowserProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IFIBToolViewHandler <IFIBGetBaseInfoProtocol, IFIBOperateBrowserProtocol, IFIBOrientationReceiveProtocol>

@required

/**
 容器视图准备好了，可进行子视图的添加和布局
 */
- (void)yb_containerViewIsReadied;

/**
 隐藏视图
 
 @param hide 是否隐藏
 */
- (void)yb_hide:(BOOL)hide;

@optional

/// 当前数据
@property (nonatomic, copy) id<IFIBDataProtocol>(^yb_currentData)(void);

/**
 页码变化了
 */
- (void)yb_pageChanged;

/**
 偏移量变化了

 @param offsetX 当前偏移量
 */
- (void)yb_offsetXChanged:(CGFloat)offsetX;

/**
 响应长按手势
 */
- (void)yb_respondsToLongPress;

@end

@interface IFIBToolViewHandler : NSObject <IFIBToolViewHandler>

/// 弹出表单视图
@property (nonatomic, strong, readonly) IFIBSheetView *sheetView;

/// 顶部显示页码视图
@property (nonatomic, strong, readonly) IFIBTopView *topView;

@end

NS_ASSUME_NONNULL_END
