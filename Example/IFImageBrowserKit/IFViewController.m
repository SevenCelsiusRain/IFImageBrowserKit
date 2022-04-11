//
//  IFViewController.m
//  IFImageBrowserKit
//
//  Created by 张高磊 on 04/07/2022.
//  Copyright (c) 2022 张高磊. All rights reserved.
//

#import "IFViewController.h"
#import "IFTestAController.h"
#import "IFTestBController.h"
#import "IFTestCController.h"
#import "IFTestDController.h"
#import "IFTestEController.h"
#import "IFTestFController.h"

@interface IFViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) NSArray<Class> *classSource;

@end

static NSString *const identifier = @"MyCell";
@implementation IFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [self.classSource[indexPath.row] new];
    vc.title = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:identifier];
        _tableView.frame = UIScreen.mainScreen.bounds;
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"展示图片", @"自定义工具视图", @"自定义cell", @"图片显示处理（加水印）", @"用代理添加数据源", @"添加到控制器使用"];
    }
    return _dataSource;
}

- (NSArray *)classSource {
    if (!_classSource) {
        _classSource = @[IFTestAController.class, IFTestBController.class, IFTestCController.class, IFTestDController.class, IFTestEController.class, IFTestFController.class];
    }
    return _classSource;
}

@end
