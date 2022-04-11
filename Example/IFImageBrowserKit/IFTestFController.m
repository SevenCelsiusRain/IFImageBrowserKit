//
//  IFTestFController.m
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import "IFTestFController.h"
#import "IFIBPhotoAlbumManager.h"
#import "IFImageBrowser.h"

@interface IFTestFController ()<IFImageBrowserDataSource>

@end

@implementation IFTestFController

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [IFIBPhotoAlbumManager getPhotoAlbumAuthorizationSuccess:^{
            self.dataArray = [IFBaseFileManager imagePHAssets];
        } failed:^{}];
    }
    return self;
}

+ (NSString *)yb_title {
    return @"用代理配置数据源（以相册为例）";
}

#pragma mark - override

- (void)selectedIndex:(NSInteger)index {
    IFImageBrowser *browser = [IFImageBrowser new];
    browser.dataSource = self;
    browser.currentPage = index;
    [browser show];
}

#pragma mark - <YBImageBrowserDataSource>

- (NSInteger)yb_numberOfCellsInImageBrowser:(IFImageBrowser *)imageBrowser {
    return self.dataArray.count;
}

- (id<IFIBDataProtocol>)yb_imageBrowser:(IFImageBrowser *)imageBrowser dataForCellAtIndex:(NSInteger)index {
    
    PHAsset *asset = (PHAsset *)self.dataArray[index];
    if (asset.mediaType == PHAssetMediaTypeImage) {
        // 系统相册的图片
        IFIBImageData *data = [IFIBImageData new];
        data.imagePHAsset = asset;
        data.projectiveView = [self viewAtIndex:index];
        return data;
    }
    
    return nil;
}


@end
