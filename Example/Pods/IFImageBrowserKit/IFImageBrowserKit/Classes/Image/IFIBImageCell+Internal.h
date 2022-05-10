//
//  YBIBImageCell+Internal.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/12/23.
//  Copyright © 2022 杨波. All rights reserved.
//

#import "IFIBImageCell.h"
#import "IFIBImageScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface IFIBImageCell ()

@property (nonatomic, strong) IFIBImageScrollView *imageScrollView;

@property (nonatomic, strong) UIImageView *tailoringImageView;

@end

NS_ASSUME_NONNULL_END
