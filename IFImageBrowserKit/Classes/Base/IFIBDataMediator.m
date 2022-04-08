//
//  YBIBDataMediator.m
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/6.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBDataMediator.h"
#import "IFImageBrowser+Internal.h"

@implementation IFIBDataMediator {
    __weak IFImageBrowser *_browser;
    NSCache<NSNumber *, id<IFIBDataProtocol>> *_dataCache;
}

#pragma mark - life cycle

- (instancetype)initWithBrowser:(IFImageBrowser *)browser {
    if (self = [super init]) {
        _browser = browser;
        _dataCache = [NSCache new];
    }
    return self;
}

#pragma mark - public

- (NSInteger)numberOfCells {
    return _browser.dataSource ? [_browser.dataSource yb_numberOfCellsInImageBrowser:_browser] : _browser.dataSourceArray.count;
}

- (id<IFIBDataProtocol>)dataForCellAtIndex:(NSInteger)index {
    if (index < 0 || index > self.numberOfCells - 1) return nil;
    
    id<IFIBDataProtocol> data = [_dataCache objectForKey:@(index)];
    if (!data) {
        data = _browser.dataSource ? [_browser.dataSource yb_imageBrowser:_browser dataForCellAtIndex:index] : _browser.dataSourceArray[index];
        [_dataCache setObject:data forKey:@(index)];
        [_browser implementGetBaseInfoProtocol:data];
    }
    return data;
}

- (void)clear {
    [_dataCache removeAllObjects];
}

- (void)preloadWithPage:(NSInteger)page {
    if (_preloadCount == 0) return;
    
    NSInteger left = -(_preloadCount / 2), right = _preloadCount - ABS(left);
    for (NSInteger i = left; i <= right; ++i) {
        if (i == 0) continue;
        id<IFIBDataProtocol> targetData = [self dataForCellAtIndex:page + i];
        if ([targetData respondsToSelector:@selector(yb_preload)]) {
            [targetData yb_preload];
        }
    }
}

#pragma mark - getters & setters

- (void)setDataCacheCountLimit:(NSUInteger)dataCacheCountLimit {
    _dataCacheCountLimit = dataCacheCountLimit;
    _dataCache.countLimit = dataCacheCountLimit;
}

@end
