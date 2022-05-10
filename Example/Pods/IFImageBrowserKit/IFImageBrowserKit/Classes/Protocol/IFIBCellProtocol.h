//
//  YBIBCellProtocol.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/5.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBGetBaseInfoProtocol.h"
#import "IFIBOrientationReceiveProtocol.h"
#import "IFIBOperateBrowserProtocol.h"

@protocol IFIBDataProtocol;

NS_ASSUME_NONNULL_BEGIN

@protocol IFIBCellProtocol <IFIBGetBaseInfoProtocol, IFIBOperateBrowserProtocol, IFIBOrientationReceiveProtocol>

@required

/// Cell 对应的 Data
@property (nonatomic, strong) id<IFIBDataProtocol> yb_cellData;

@optional

/**
 获取前景视图，出入场时需要用这个返回值做动效

 @return 前景视图
 */
- (__kindof UIView *)yb_foregroundView;

/**
 页码变化了
 */
- (void)yb_pageChanged;

/// 当前 Cell 的页码
@property (nonatomic, copy) NSInteger(^yb_selfPage)(void);

@end

NS_ASSUME_NONNULL_END
