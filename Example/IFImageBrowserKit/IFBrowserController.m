//
//  IFBrowserController.m
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import "IFBrowserController.h"
#import "IFImageBrowser.h"
#import "IFIBUtilities.h"

@interface IFBrowserController ()<IFImageBrowserDataSource>

@end

@implementation IFBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    /*
     用控制器包装处理起来有些麻烦，需要关闭很多效果
     */
    
    IFImageBrowser *browser = [IFImageBrowser new];
    // 禁止旋转（但是若当前控制器能旋转，图片浏览器也会跟随，布局可能会错位，这种情况还待处理）
    browser.supportedOrientations = UIInterfaceOrientationMaskPortrait;
    // 这里演示使用代理来处理数据源（当然用数组也可以）
    browser.dataSource = self;
    browser.currentPage = self.selectIndex;
    // 关闭入场和出场动效
    browser.defaultAnimatedTransition.showType = YBIBTransitionTypeNone;
    browser.defaultAnimatedTransition.hideType = YBIBTransitionTypeNone;
    // 删除工具视图（你可能需要自定义的工具视图，那请自己实现吧）
    browser.toolViewHandlers = @[];
    // 由于 self.view 的大小可能会变化，所以需要显式的赋值容器大小
    CGSize size = CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - YBIBStatusbarHeight() - 44);
    [browser showToView:self.view containerSize:size];
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - <YBImageBrowserDataSource>

- (NSInteger)yb_numberOfCellsInImageBrowser:(IFImageBrowser *)imageBrowser {
    return self.imagePHAssets.count;
}

- (id<IFIBDataProtocol>)yb_imageBrowser:(IFImageBrowser *)imageBrowser dataForCellAtIndex:(NSInteger)index {
    
    PHAsset *asset = (PHAsset *)self.imagePHAssets[index];
    if (asset.mediaType == PHAssetMediaTypeImage) {
        
        // 系统相册的图片
        IFIBImageData *data = [IFIBImageData new];
        data.imagePHAsset = asset;
        data.interactionProfile.disable = YES;  //关闭手势交互
        data.singleTouchBlock = ^(IFIBImageData * _Nonnull imageData) {};   //拦截单击事件
        return data;
        
    }
    return nil;
}


@end
