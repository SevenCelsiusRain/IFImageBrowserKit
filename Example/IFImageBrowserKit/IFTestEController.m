//
//  IFTestEController.m
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import "IFTestEController.h"
#import "IFBrowserController.h"
#import "IFIBPhotoAlbumManager.h"

@interface IFTestEController ()

@end

@implementation IFTestEController

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
    return @"添加到控制器使用（以相册为例）";
}

#pragma mark - override

- (void)selectedIndex:(NSInteger)index {
    //使用控制器保证的图片浏览器
    IFBrowserController *browser = [IFBrowserController new];
    browser.imagePHAssets = self.dataArray;
    browser.selectIndex = index;
    [self.navigationController pushViewController:browser animated:YES];
}


@end
