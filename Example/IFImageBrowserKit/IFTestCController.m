//
//  IFTestCController.m
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import "IFTestCController.h"
#import "IFImageBrowser.h"
#import "IFCustomData.h"

@interface IFTestCController ()<IFImageBrowserDelegate>

@end

static NSString *kAdvertKey = @"广告位";
@implementation IFTestCController

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:[IFBaseFileManager imageURLs]];
        [array addObject:kAdvertKey];
        self.dataArray = array;
    }
    return self;
}


#pragma mark - <YBImageBrowserDelegate>

- (void)yb_imageBrowser:(IFImageBrowser *)imageBrowser pageChanged:(NSInteger)page data:(id<IFIBDataProtocol>)data {
    // 当是自定义的 Cell 时，隐藏右边的操作按钮
    // 对于工具栏的处理自定义一个 id<YBIBToolViewHandler> 是最灵活的方式，默认实现很多时候可能满足不了需求
    imageBrowser.defaultToolViewHandler.topView.operationButton.hidden = [data isKindOfClass:IFCustomData.self];
}

#pragma mark - override

- (void)selectedIndex:(NSInteger)index {
    
    NSMutableArray *datas = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:kAdvertKey]) {
            
            // 自定义的广告 Cell
            IFCustomData *data = [IFCustomData new];
            data.text = @"这是一个广告";
            [datas addObject:data];
            
        } else {
            
            // 网络图片
            IFIBImageData *data = [IFIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
            data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];
            
        }
    }];
    
    IFImageBrowser *browser = [IFImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    browser.delegate = self;
    [browser show];
}

@end
