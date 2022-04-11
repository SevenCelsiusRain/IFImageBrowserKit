//
//  IFTestAController.m
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import "IFTestAController.h"
#import "IFImageBrowser.h"

@interface IFTestAController ()

@end

@implementation IFTestAController

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:[IFBaseFileManager imageURLs]];
        [array addObjectsFromArray:[IFBaseFileManager imageNames]];
        self.dataArray = array;
    }
    return self;
}


#pragma mark - override

- (void)selectedIndex:(NSInteger)index {
    NSMutableArray *datas = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj hasPrefix:@"http"]) {
            // 网络图片
            IFIBImageData *data = [IFIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
        } else {
            // 本地图片
            IFIBImageData *data = [IFIBImageData new];
            data.imageName = obj;
            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
        }
    }];
    
    IFImageBrowser *browser = [IFImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    [browser show];
}

@end
