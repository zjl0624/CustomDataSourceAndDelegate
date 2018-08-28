//
//  DataSource.m
//  CustomDataSourceAndDelegate
//
//  Created by zjl on 2017/8/9.
//  Copyright © 2017年 zjlzjl. All rights reserved.
//

#import "DataSource.h"
@interface DataSource(){
	CellIDConfigureBlock _cellIDConfigureBlock;
	CellConfigureBlock _cellConfigureBlock;
	ReusableViewIDConfigureBlock _reusableViewIDConfigureBlock;
	ReusableViewConfigureBlock _reusableViewConfigureBlock;
}

@end
@implementation DataSource
- (instancetype)initWithDataArray:(NSArray *)dataArray
			 cellIDConfigureBlock:(CellIDConfigureBlock)cellIDConfigureBlock
					cellConfigure:(CellConfigureBlock)cellConfigureBlock {

	return [self initWithDataArray:dataArray numberOfSection:1 cellIDConfigureBlock:cellIDConfigureBlock cellConfigure:cellConfigureBlock];
}

- (instancetype)initWithDataArray:(NSArray *)dataArray
				  numberOfSection:(NSInteger)numberOfSection
			 cellIDConfigureBlock:(CellIDConfigureBlock)cellIDConfigureBlock
					cellConfigure:(CellConfigureBlock)cellConfigureBlock {
	return [self initWithDataArray:dataArray numberOfSection:numberOfSection cellIDConfigureBlock:cellIDConfigureBlock cellConfigure:cellConfigureBlock ReusableViewIDConfigureBlock:nil ReusableViewConfigureBlock:nil];
}

- (instancetype)initWithDataArray:(NSArray *)dataArray
				  numberOfSection:(NSInteger)numberOfSection
			 cellIDConfigureBlock:(CellIDConfigureBlock)cellIDConfigureBlock
					cellConfigure:(CellConfigureBlock)cellConfigureBlock
	 ReusableViewIDConfigureBlock:(ReusableViewIDConfigureBlock)reusableViewIDConfigureBlock
	   ReusableViewConfigureBlock:(ReusableViewConfigureBlock)reusableViewConfigureBlock {
	self = [super init];
	if (self) {
		_dataArray = dataArray;
		_cellIDConfigureBlock = cellIDConfigureBlock;
		_cellConfigureBlock = cellConfigureBlock;
		_numberOfSection = numberOfSection;
		_reusableViewIDConfigureBlock = reusableViewIDConfigureBlock;
		_reusableViewConfigureBlock = reusableViewConfigureBlock;
	}
	return self;
}

- (void)setDataArray:(NSArray *)dataArray {
	_dataArray = dataArray;
	
}

- (id)modelByIndex:(NSIndexPath *)indexPath {
	if (_numberOfSection == 1 && ![_dataArray[indexPath.section] isKindOfClass:[NSArray class]]) {
		return _dataArray[indexPath.row];
	}else {
//        NSLog(@"section=%ld",(long)indexPath.section);
//        NSLog(@"row=%ld",(long)indexPath.row);
		return _dataArray[indexPath.section][indexPath.row];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _numberOfSection;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (_numberOfSection == 1 && ![_dataArray[section] isKindOfClass:[NSArray class]]) {
		return [self.dataArray count];
	}else {
		return [_dataArray[section] count];
	}
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	id model = [self modelByIndex:indexPath];
	NSString *cellIdentifier = _cellIDConfigureBlock(indexPath,model);
	id cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if ([cell conformsToProtocol:@protocol(ConfigureCellDelegate)]) {
		[cell configureCellWithModel:model];
	}
	_cellConfigureBlock(indexPath,model,cell);
	return cell;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return _numberOfSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	if (_numberOfSection == 1 && ![_dataArray[section] isKindOfClass:[NSArray class]]) {
		return [self.dataArray count];
	}else {
		return [_dataArray[section] count];
	}
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	id model = [self modelByIndex:indexPath];
	NSString *cellIdentifier = _cellIDConfigureBlock(indexPath,model);
	id cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    _cellConfigureBlock(indexPath,model,cell);
	if ([cell conformsToProtocol:@protocol(ConfigureCellDelegate)]) {
		[cell configureCellWithModel:model];
	}

	return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	UICollectionReusableView *view = nil;
	if (_reusableViewIDConfigureBlock) {
		NSDictionary *reusableViewIDDict = _reusableViewIDConfigureBlock(indexPath);
		NSString *reusableViewID = [reusableViewIDDict objectForKey:kind];

//        UIView *customView = reusableViewDict[kind];

		if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
			view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableViewID forIndexPath:indexPath];
		}else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
			view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reusableViewID forIndexPath:indexPath];
		}
        _reusableViewConfigureBlock(indexPath,view,kind);
//        [view addSubview:customView];
	}
	return view;
}
@end
