//
//  Delegate.h
//  CustomDataSourceAndDelegate
//  该类作为tabview和collectionview的delegate，初始化之后，赋值给tableview和collectionview的delegate即可，具体使用方式可以参考example
//  如果涉及到该类未实现的delegate的协议中的方法时，可以自己新建一个delegate的类，然后继承该类，在新建的类中实现自己的方法，即可使用
//  Created by zjl on 2017/8/11.
//  Copyright © 2017年 zjlzjl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Delegate : NSObject<UICollectionViewDelegate,UITableViewDelegate>
//tableview点击事件的block
typedef void(^SelectedBlock)(NSIndexPath *indexPath);
//返回tableviewcell高度的block
typedef CGFloat(^TableviewCellHeightBlock)(NSIndexPath *indexPath);
//tableviewsectionheader的高度
typedef CGFloat(^TableviewSectionHeaderHeightBlock)(NSInteger section);
//tableviewsectionfooter的高度
typedef CGFloat(^TableviewSectionFooterHeightBlock)(NSInteger section);
//配置tableviewSectionHeaderview的block
typedef UIView*(^TableviewSectionHeaderViewBlock)(NSInteger section);
//配置tableviewSectionFooterview的block
typedef UIView*(^TableviewSectionFooterViewBlock)(NSInteger section);


- (instancetype)initWithSelectedBlock:(SelectedBlock)selectedBlock;

//delegate初始化方法
- (instancetype)initWithSelectedBlock:(SelectedBlock)selectedBlock//点击cell后返回的block
			 TableviewCellHeightBlock:(TableviewCellHeightBlock)cellHeightBlock//tableviewcell的行高
	TableviewSectionHeaderHeightBlock:(TableviewSectionHeaderHeightBlock)sectionHeaderHeightBlock//tableviewsectionheader的高度
	TableviewSectionFooterHeightBlock:(TableviewSectionFooterHeightBlock)sectionFooterHeightBlock;//talbeviewsectionfooter的高度

- (instancetype)initWithSelectedBlock:(SelectedBlock)selectedBlock//点击cell后返回的block
			 TableviewCellHeightBlock:(TableviewCellHeightBlock)cellHeightBlock//tableviewcell的行高
	TableviewSectionHeaderHeightBlock:(TableviewSectionHeaderHeightBlock)sectionHeaderHeightBlock//tableviewsectionheader的高度
	TableviewSectionFooterHeightBlock:(TableviewSectionFooterHeightBlock)sectionFooterHeightBlock
	  TableviewSectionHeaderViewBlock:(TableviewSectionHeaderViewBlock)sectionHeaderViewBlock//配置sectionHeaderView的block
	  TableviewSectionFooterViewBlock:(TableviewSectionFooterViewBlock)sectionFooterViewBlock;//配置sectionFooterview的block
@end
