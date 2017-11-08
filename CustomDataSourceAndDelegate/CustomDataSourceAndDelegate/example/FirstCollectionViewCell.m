//
//  FirstCollectionViewCell.m
//  CustomDataSourceAndDelegate
//
//  Created by zjl on 2017/8/10.
//  Copyright © 2017年 zjlzjl. All rights reserved.
//

#import "FirstCollectionViewCell.h"
#import "CollectionModel.h"

@interface FirstCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation FirstCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - ConfigureCellDelegate
- (void)configureCellWithModel:(id)model {
	CollectionModel *sm = (CollectionModel *)model;
	_nameLabel.text = sm.name;
}
@end
