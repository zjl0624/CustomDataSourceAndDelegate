//
//  SecondTableViewCell.m
//  CustomDataSourceAndDelegate
//
//  Created by zjl on 2017/8/9.
//  Copyright © 2017年 zjlzjl. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "SecondModel.h"
@interface SecondTableViewCell () {
	UILabel *nameLabel;
}

@end
@implementation SecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
		[self addSubview:nameLabel];
	}
	return self;
}

#pragma mark - ConfigureCellDelegate
- (void)configureCellWithModel:(id)model {
	SecondModel *sm = (SecondModel *)model;
	nameLabel.text = sm.name;
}
@end
