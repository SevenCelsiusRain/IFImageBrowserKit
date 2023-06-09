//
//  IFBaseListController.m
//  IFImageBrowserKit_Example
//
//  Created by MrGLZh on 2022/4/8.
//  Copyright © 2022 张高磊. All rights reserved.
//

#import "IFBaseListController.h"
#import "IFBaseListCell.h"
#import "IFIBUtilities.h"
#import <SDWebImage/SDImageCache.h>
#import "IFIBToastView.h"

@interface IFBaseListController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *clearButton;

@end

@implementation IFBaseListController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.clearButton];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - public

- (id)viewAtIndex:(NSInteger)index {
    IFBaseListCell *cell = (IFBaseListCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell ? cell.contentImgView : nil;
}

#pragma mark - private

- (NSArray *)defaultDataArray {
    return nil;
}

- (void)selectedIndex:(NSInteger)index {}

+ (NSString *)yb_title {
    return nil;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IFBaseListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(IFBaseListCell.self) forIndexPath:indexPath];
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self selectedIndex:indexPath.row];
}

#pragma mark - event

- (void)clickClearButton:(UIButton *)sender {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self.view ybib_showHookToast:@"清理完成"];
    }];
}

#pragma mark - getter

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat padding = 5, cellLength = ([UIScreen mainScreen].bounds.size.width - padding * 2) / 3;
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(cellLength, cellLength);
        layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - YBIBStatusbarHeight() - 40 - YBIBSafeAreaBottomHeight() - 44) collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(IFBaseListCell.self) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(IFBaseListCell.self)];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UIButton *)clearButton {
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearButton.frame = CGRectMake(15, CGRectGetMaxY(self.collectionView.frame) + 7.5, 80, 25);
        [_clearButton setTitle:@"清理缓存" forState:UIControlStateNormal];
        _clearButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _clearButton.backgroundColor = [UIColor orangeColor];
        _clearButton.layer.cornerRadius = 4;
        _clearButton.layer.masksToBounds = YES;
        [_clearButton addTarget:self action:@selector(clickClearButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}



@end
