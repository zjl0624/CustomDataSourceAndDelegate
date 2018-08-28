//
//  DataSource.h
//  CustomDataSourceAndDelegate
//  该类是一个tableview和collectionview都能使用的datasource
//  只需要初始化该类，然后把该类赋值给tableview或者collectionview，就能实现功能，具体的使用方法可以参考example
//  如果涉及到该类未实现的datasource的协议中的方法时，可以自己新建一个datasource的类，然后继承该类，在新建的类中实现自己的方法，即可使用
//  Created by zjl on 2017/8/9.
//  Copyright © 2017年 zjlzjl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ConfigureCellDelegate
- (void)configureCellWithModel:(id)model;
@end

@interface DataSource : NSObject<UITableViewDataSource,UICollectionViewDataSource>
//数据源数组
@property (nonatomic,strong) NSArray *dataArray;
//section的数量
@property (nonatomic,assign) NSInteger numberOfSection;
//配置cellIdentifer的block
typedef NSString *(^CellIDConfigureBlock)(NSIndexPath *indexPath,id model);
//cell个性化配置的block
typedef void(^CellConfigureBlock)(NSIndexPath *indexPath,id model,id cell);
//配置collection header和footer的id，返回的字典格式类似于@{UICollectionElementKindSectionHeader:@"header",UICollectionElementKindSectionFooter:@"footer"}，key必须为UICollectionElementKindSectionHeader，UICollectionElementKindSectionFooter
typedef NSDictionary *(^ReusableViewIDConfigureBlock)(NSIndexPath *indexPath);
//配置collectionview的header和footerview，返回的字典格式类似于@{UICollectionElementKindSectionHeader:[weakself createCollectionHeaderView],UICollectionElementKindSectionFooter:[weakself createCollectionFooterView]}，key必须为UICollectionElementKindSectionHeader，UICollectionElementKindSectionFooter
typedef void (^ReusableViewConfigureBlock)(NSIndexPath *indexPath,UICollectionReusableView *reusableView,NSString *kind);

- (instancetype)initWithDataArray:(NSArray *)dataArray
			 cellIDConfigureBlock:(CellIDConfigureBlock)cellIDConfigureBlock
					cellConfigure:(CellConfigureBlock)cellConfigureBlock;

- (instancetype)initWithDataArray:(NSArray *)dataArray
				  numberOfSection:(NSInteger)numberOfSection
			 cellIDConfigureBlock:(CellIDConfigureBlock)cellIDConfigureBlock
					cellConfigure:(CellConfigureBlock)cellConfigureBlock;

//datasource的初始化方法
- (instancetype)initWithDataArray:(NSArray *)dataArray//datasource的数据源数组
				  numberOfSection:(NSInteger)numberOfSection//section数量
			 cellIDConfigureBlock:(CellIDConfigureBlock)cellIDConfigureBlock//cell重用的identifer
					cellConfigure:(CellConfigureBlock)cellConfigureBlock//配置cell样式的block
	 ReusableViewIDConfigureBlock:(ReusableViewIDConfigureBlock)reusableViewIDConfigureBlock//collectionviewsectionview的identifier，这个地方需要配置一个字典来返回
	   ReusableViewConfigureBlock:(ReusableViewConfigureBlock)reusableViewConfigureBlock;//配置collectionviewsectionview的block
@end
