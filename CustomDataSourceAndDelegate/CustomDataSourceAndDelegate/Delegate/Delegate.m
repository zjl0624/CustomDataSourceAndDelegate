//
//  Delegate.m
//  CustomDataSourceAndDelegate
//
//  Created by zjl on 2017/8/11.
//  Copyright © 2017年 zjlzjl. All rights reserved.
//

#import "Delegate.h"
@interface Delegate () {
	SelectedBlock _selectedBlock;
	TableviewCellHeightBlock _cellHeightBlock;
	TableviewSectionHeaderHeightBlock _tableviewSectionHeaderHeightBlock;
	TableviewSectionFooterHeightBlock _tableviewSectionFooterHeightBlock;
	TableviewSectionHeaderViewBlock _tableviewSectionHeaderViewBlock;
	TableviewSectionFooterViewBlock _tableviewSectionFooterViewBlock;
}

@end
@implementation Delegate

- (instancetype)initWithSelectedBlock:(SelectedBlock)selectedBlock {
	return [self initWithSelectedBlock:selectedBlock TableviewCellHeightBlock:nil TableviewSectionHeaderHeightBlock:nil TableviewSectionFooterHeightBlock:nil];
}
- (instancetype)initWithSelectedBlock:(SelectedBlock)selectedBlock
			 TableviewCellHeightBlock:(TableviewCellHeightBlock)cellHeightBlock
	TableviewSectionHeaderHeightBlock:(TableviewSectionHeaderHeightBlock)sectionHeaderHeightBlock
	TableviewSectionFooterHeightBlock:(TableviewSectionFooterHeightBlock)sectionFooterHeightBlock {
	return [self initWithSelectedBlock:selectedBlock TableviewCellHeightBlock:cellHeightBlock TableviewSectionHeaderHeightBlock:sectionHeaderHeightBlock TableviewSectionFooterHeightBlock:sectionFooterHeightBlock TableviewSectionHeaderViewBlock:nil TableviewSectionFooterViewBlock:nil];
}

- (instancetype)initWithSelectedBlock:(SelectedBlock)selectedBlock TableviewCellHeightBlock:(TableviewCellHeightBlock)cellHeightBlock TableviewSectionHeaderHeightBlock:(TableviewSectionHeaderHeightBlock)sectionHeaderHeightBlock TableviewSectionFooterHeightBlock:(TableviewSectionFooterHeightBlock)sectionFooterHeightBlock TableviewSectionHeaderViewBlock:(TableviewSectionHeaderViewBlock)sectionHeaderViewBlock TableviewSectionFooterViewBlock:(TableviewSectionFooterViewBlock)sectionFooterViewBlock{
	self = [super init];
	if (self) {
		_selectedBlock = selectedBlock;
		_cellHeightBlock = cellHeightBlock;
		_tableviewSectionHeaderHeightBlock = sectionHeaderHeightBlock;
		_tableviewSectionFooterHeightBlock = sectionFooterHeightBlock;
		_tableviewSectionHeaderViewBlock = sectionHeaderViewBlock;
		_tableviewSectionFooterViewBlock = sectionFooterViewBlock;
	}
	return self;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (_selectedBlock) {
		_selectedBlock(indexPath);
	}

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (_cellHeightBlock) {
		return _cellHeightBlock(indexPath);
	}else {
		return 44;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (_tableviewSectionHeaderHeightBlock) {
		return _tableviewSectionHeaderHeightBlock(section);
	}else {
		return 0;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	if (_tableviewSectionFooterHeightBlock) {
		return _tableviewSectionFooterHeightBlock(section);
	}else {
		return 0;
	}
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if(_tableviewSectionHeaderViewBlock){
		return _tableviewSectionHeaderViewBlock(section);
	}else{
		return [[UIView alloc] init];
	}
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	if(_tableviewSectionFooterViewBlock){
		return _tableviewSectionFooterViewBlock(section);
	}else{
		return [[UIView alloc] init];
	}
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (_selectedBlock) {
		_selectedBlock(indexPath);
	}
}
@end
