//
//  IFBaseListCell.h
//  IFImageBrowserKit
//
//  Created by 张高磊 on 04/07/2022.
//  Copyright (c) 2022 张高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IFBaseListCell : UICollectionViewCell

@property (nonatomic, strong) id data;

@property (weak, nonatomic) IBOutlet UIImageView *contentImgView;

@end

NS_ASSUME_NONNULL_END
