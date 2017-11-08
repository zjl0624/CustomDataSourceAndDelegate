//
//  FirstTableViewCell.m
//  CustomDataSourceAndDelegate
//
//  Created by zjl on 2017/8/9.
//  Copyright © 2017年 zjlzjl. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "FirstModel.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - ConfigureCellDelegate
- (void)configureCellWithModel:(id)model {
	FirstModel *fm = (FirstModel *)model;
	
	if (fm.isRed) {
		self.backgroundColor = [UIColor redColor];
	}else {
		self.backgroundColor = [UIColor yellowColor];
	}
}
@end
