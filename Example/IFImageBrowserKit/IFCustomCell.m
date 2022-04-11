//
//  IFCustomCell.h
//  IFImageBrowserKit
//
//  Created by 张高磊 on 04/07/2022.
//  Copyright (c) 2022 张高磊. All rights reserved.
//

#import "IFCustomCell.h"
#import "IFCustomData.h"

@interface IFCustomCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation IFCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = UIColor.whiteColor;
}

#pragma mark - <YBIBCellProtocol>

@synthesize yb_cellData = _yb_cellData;
@synthesize yb_hideBrowser = _yb_hideBrowser;

- (void)setYb_cellData:(id<IFIBDataProtocol>)yb_cellData {
    _yb_cellData = yb_cellData;
    
    IFCustomData *data = (IFCustomData *)yb_cellData;
    self.contentLabel.text = data.text;
}

#pragma mark - touch

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.yb_hideBrowser();
}

@end
