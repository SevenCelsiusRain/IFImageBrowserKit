//
//  YBIBToolViewHandler.m
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/7/7.
//  Copyright © 2022 杨波. All rights reserved.
//

#import "IFIBToolViewHandler.h"
#import "IFIBCopywriter.h"
#import "IFIBUtilities.h"

@interface IFIBToolViewHandler ()
@property (nonatomic, strong) IFIBSheetView *sheetView;
@property (nonatomic, strong) IFIBSheetAction *saveAction;
@property (nonatomic, strong) IFIBTopView *topView;
@end

@implementation IFIBToolViewHandler

#pragma mark - <YBIBToolViewHandler>

@synthesize yb_containerView = _yb_containerView;
@synthesize yb_containerSize = _yb_containerSize;
@synthesize yb_currentPage = _yb_currentPage;
@synthesize yb_totalPage = _yb_totalPage;
@synthesize yb_currentOrientation = _yb_currentOrientation;
@synthesize yb_currentData = _yb_currentData;

- (void)yb_containerViewIsReadied {
    [self.yb_containerView addSubview:self.topView];
    [self layoutWithExpectOrientation:self.yb_currentOrientation()];
}

- (void)yb_pageChanged {
    if (self.topView.operationType == YBIBTopViewOperationTypeSave) {
        self.topView.operationButton.hidden = [self currentDataShouldHideSaveButton];
    }
    [self.topView setPage:self.yb_currentPage() totalPage:self.yb_totalPage()];
}

- (void)yb_respondsToLongPress {
    [self showSheetView];
}

- (void)yb_hide:(BOOL)hide {
    self.topView.hidden = hide;
    [self.sheetView hideWithAnimation:NO];
}

- (void)yb_orientationWillChangeWithExpectOrientation:(UIDeviceOrientation)orientation {
    [self.sheetView hideWithAnimation:NO];
}

- (void)yb_orientationChangeAnimationWithExpectOrientation:(UIDeviceOrientation)orientation {
    [self layoutWithExpectOrientation:orientation];
}

#pragma mark - private

- (BOOL)currentDataShouldHideSaveButton {
    id<IFIBDataProtocol> data = self.yb_currentData();
    BOOL allow = [data respondsToSelector:@selector(yb_allowSaveToPhotoAlbum)] && [data yb_allowSaveToPhotoAlbum];
    BOOL can = [data respondsToSelector:@selector(yb_saveToPhotoAlbum)];
    return !(allow && can);
}

- (void)layoutWithExpectOrientation:(UIDeviceOrientation)orientation {
    CGSize containerSize = self.yb_containerSize(orientation);
    UIEdgeInsets padding = YBIBPaddingByBrowserOrientation(orientation);
    
    self.topView.frame = CGRectMake(padding.left, padding.top, containerSize.width - padding.left - padding.right, [IFIBTopView defaultHeight]);
}

- (void)showSheetView {
    if ([self currentDataShouldHideSaveButton]) {
        [self.sheetView.actions removeObject:self.saveAction];
    } else {
        if (![self.sheetView.actions containsObject:self.saveAction]) {
            [self.sheetView.actions addObject:self.saveAction];
        }
    }
    [self.sheetView showToView:self.yb_containerView orientation:self.yb_currentOrientation()];
}

#pragma mark - getters

- (IFIBSheetView *)sheetView {
    if (!_sheetView) {
        _sheetView = [IFIBSheetView new];
        __weak typeof(self) wSelf = self;
        [_sheetView setCurrentdata:^id<IFIBDataProtocol>{
            __strong typeof(wSelf) self = wSelf;
            if (!self) return nil;
            return self.yb_currentData();
        }];
    }
    return _sheetView;
}

- (IFIBSheetAction *)saveAction {
    if (!_saveAction) {
        __weak typeof(self) wSelf = self;
        _saveAction = [IFIBSheetAction actionWithName:[IFIBCopywriter sharedCopywriter].saveToPhotoAlbum action:^(id<IFIBDataProtocol> data) {
            __strong typeof(wSelf) self = wSelf;
            if (!self) return;
            if ([data respondsToSelector:@selector(yb_saveToPhotoAlbum)]) {
                [data yb_saveToPhotoAlbum];
            }
            [self.sheetView hideWithAnimation:YES];
        }];
    }
    return _saveAction;
}

- (IFIBTopView *)topView {
    if (!_topView) {
        _topView = [IFIBTopView new];
        _topView.operationType = YBIBTopViewOperationTypeMore;
        __weak typeof(self) wSelf = self;
        [_topView setClickOperation:^(YBIBTopViewOperationType type) {
            __strong typeof(wSelf) self = wSelf;
            if (!self) return;
            switch (type) {
                case YBIBTopViewOperationTypeSave: {
                    id<IFIBDataProtocol> data = self.yb_currentData();
                    if ([data respondsToSelector:@selector(yb_saveToPhotoAlbum)]) {
                        [data yb_saveToPhotoAlbum];
                    }
                }
                    break;
                case YBIBTopViewOperationTypeMore: {
                    [self showSheetView];
                }
                    break;
                default:
                    break;
            }
        }];
    }
    return _topView;
}

@end
