//
//  YBIBDataMediator.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/6.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFImageBrowser.h"

NS_ASSUME_NONNULL_BEGIN

@interface IFIBDataMediator : NSObject

- (instancetype)initWithBrowser:(IFImageBrowser *)browser;

@property (nonatomic, assign) NSUInteger dataCacheCountLimit;

- (NSInteger)numberOfCells;

- (id<IFIBDataProtocol>)dataForCellAtIndex:(NSInteger)index;

- (void)clear;

@property (nonatomic, assign) NSUInteger preloadCount;

- (void)preloadWithPage:(NSInteger)page;

@end

NS_ASSUME_NONNULL_END
