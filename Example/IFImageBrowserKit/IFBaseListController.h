//
//  IFBaseListController.h
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFBaseFileManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface IFBaseListController : UIViewController
@property (nonatomic, copy) NSArray *dataArray;

- (id)viewAtIndex:(NSInteger)index;

#pragma - override

- (void)selectedIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
