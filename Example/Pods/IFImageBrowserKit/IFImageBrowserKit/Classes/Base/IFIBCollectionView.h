//
//  YBIBCollectionView.h
//  IFImageBrowserKit
//
//  Created by MrGLZh on 2022/3/6.
//  Copyright © 2022 MrGLZh. All rights reserved.
//

#import "IFIBCollectionViewLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface IFIBCollectionView : UICollectionView

@property (nonatomic, strong, readonly) IFIBCollectionViewLayout *layout;

- (NSString *)reuseIdentifierForCellClass:(Class)cellClass;

- (nullable UICollectionViewCell *)centerCell;

- (void)scrollToPage:(NSInteger)page;

@end

NS_ASSUME_NONNULL_END
