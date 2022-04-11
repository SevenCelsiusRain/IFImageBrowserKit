//
//  IFTestDController.m
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import "IFTestDController.h"
#import "IFImageBrowser.h"
#import "IFIBUtilities.h"

@interface IFTestDController ()

@end

@implementation IFTestDController

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataArray = [IFBaseFileManager imageURLs];
    }
    return self;
}


#pragma mark - override

- (void)selectedIndex:(NSInteger)index {
    
    NSMutableArray *datas = [NSMutableArray array];
    [self.dataArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 网络图片
        IFIBImageData *data = [IFIBImageData new];
        data.imageURL = [NSURL URLWithString:obj];
        data.projectiveView = [self viewAtIndex:idx];
        data.originImageModifier = ^(IFIBImageData *imageData, UIImage * _Nonnull image, void (^ _Nonnull completion)(UIImage * _Nonnull)) {
            if ([imageData shouldCompressWithImage:image]) {
                completion(image);
                NSLog(@"尺寸过大，不处理");
                return;
            }
            YBIB_DISPATCH_ASYNC(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                // 添加一个水印
                UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
                [image drawAtPoint:CGPointZero];
                NSString *logo = @"LOGO";
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
                dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:40];
                [logo drawAtPoint:CGPointMake(10, 10) withAttributes:dict];
                UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                YBIB_DISPATCH_ASYNC_MAIN(^{
                    completion(img);
                })
            })
        };
        [datas addObject:data];
        
    }];
    
    IFImageBrowser *browser = [IFImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = index;
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    [browser show];
}

@end
