//
//  TableViewController.m
//  CustomDataSourceAndDelegate
//
//  Created by zjl on 2017/8/9.
//  Copyright © 2017年 zjlzjl. All rights reserved.
//
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#import "TableViewController.h"
#import "DataSource.h"
#import "FirstModel.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "SecondModel.h"
#import "FirstCollectionViewCell.h"
#import "CollectionModel.h"
#import "Delegate.h"

@interface TableViewController ()<UITableViewDelegate> {
	UITableView *tableview;
	UICollectionView *collectonview;
	NSMutableArray *dataArray;
	NSMutableArray *collectionDataArray;
	DataSource *dataSource;
	DataSource *collectionDataSource;
	Delegate *tableDelegate;
	Delegate *collectDelegate;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initUI];
	[self initTableView];
	[self initCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - private method

- (void)initUI {
	self.automaticallyAdjustsScrollViewInsets = NO;
	UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(swichCollection:)];
	self.navigationItem.rightBarButtonItem = rightBarButton;
}
//切换tableview和collectionview
- (void)swichCollection:(UIBarButtonItem *)item {
	tableview.hidden = !tableview.hidden;
	collectonview.hidden = !collectonview.hidden;
	[collectonview reloadData];
}
#pragma mark - TableView
- (void)initTableView {
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
	[self.view addSubview:tableview];
	dataArray = [[NSMutableArray alloc] init];
	FirstModel *fm1 = [[FirstModel alloc] init];
	fm1.isRed = YES;
	FirstModel *fm2 = [[FirstModel alloc] init];
	[dataArray addObject:@[fm1]];
	[dataArray addObject:@[fm2]];
	SecondModel *sm1 = [[SecondModel alloc] init];
	sm1.name = @"哈哈";
	SecondModel *sm2 = [[SecondModel alloc] init];
	sm2.name = @"呵呵";
	[dataArray addObject:@[sm1,sm2]];
	[tableview registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"firstcell"];
	[tableview registerClass:[SecondTableViewCell class] forCellReuseIdentifier:@"secondcell"];
	dataSource = [[DataSource alloc] initWithDataArray:dataArray numberOfSection:[dataArray count] cellIDConfigureBlock:^NSString *(NSIndexPath *indexPath, id model) {
		if (indexPath.section == 0 || indexPath.section == 1) {
			return @"firstcell";
		}else {
			return @"secondcell";
		}
		
	} cellConfigure:^(NSIndexPath *indexPath, id model, id cell) {
		if ([cell isKindOfClass:[FirstTableViewCell class]]) {
			FirstTableViewCell *fcell = (FirstTableViewCell *)cell;
			fcell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		
	}];
	tableview.dataSource = dataSource;
	tableDelegate = [[Delegate alloc] initWithSelectedBlock:^(NSIndexPath *indexPath) {
		NSLog(@"点了一发");
	} TableviewCellHeightBlock:nil TableviewSectionHeaderHeightBlock:^CGFloat(NSInteger section) {
		return 10;
	} TableviewSectionFooterHeightBlock:^CGFloat(NSInteger section) {
		return 20;
	} TableviewSectionHeaderViewBlock:^UIView *(NSInteger section) {
		return [self createTableviewSectionHeaderView];
	} TableviewSectionFooterViewBlock:^UIView *(NSInteger section) {
		return [self createTableviewSectionFooterView];
	}];
	tableview.delegate = tableDelegate;
}
//自定义tableview的SectionHeaderView
- (UIView *)createTableviewSectionHeaderView {
	UIView *view = [[UIView alloc] init];
	view.backgroundColor = [UIColor blackColor];
	return view;
}
//自定义tableview的SectionFooterView
- (UIView *)createTableviewSectionFooterView {
	UIView *view = [[UIView alloc] init];
	view.backgroundColor = [UIColor greenColor];
	return view;
}
#pragma mark - CollectionView
- (void)initCollectionView {
	collectionDataArray = [[NSMutableArray alloc] init];
	CollectionModel *cm1 = [[CollectionModel alloc] init];
	cm1.name = @"哈哈";
	[collectionDataArray addObject:cm1];
	
	
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.itemSize = CGSizeMake(60, 120);
	layout.headerReferenceSize = CGSizeMake(60, 30);
	layout.footerReferenceSize = CGSizeMake(60, 40);
	collectonview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) collectionViewLayout:layout];
	[self.view addSubview:collectonview];
	[collectonview registerNib:[UINib nibWithNibName:@"FirstCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
	[collectonview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
	[collectonview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
	collectonview.hidden = YES;
	collectonview.backgroundColor = [UIColor whiteColor];
	__weak TableViewController *weakself = self;
	collectionDataSource = [[DataSource alloc] initWithDataArray:collectionDataArray numberOfSection:1 cellIDConfigureBlock:^NSString *(NSIndexPath *indexPath, id model) {
		return @"cell";
	} cellConfigure:^(NSIndexPath *indexPath, id model, id cell) {
		
	} ReusableViewIDConfigureBlock:^NSDictionary *(NSIndexPath *indexPath) {
		return @{UICollectionElementKindSectionHeader:@"header",UICollectionElementKindSectionFooter:@"footer"};
	} ReusableViewConfigureBlock:^NSDictionary *(NSIndexPath *indexPath) {
		return @{UICollectionElementKindSectionHeader:[weakself createCollectionHeaderView],UICollectionElementKindSectionFooter:[weakself createCollectionFooterView]};
	}];
	collectonview.dataSource = collectionDataSource;
	collectDelegate = [[Delegate alloc] initWithSelectedBlock:^(NSIndexPath *indexPath) {
		NSLog(@"点了collectview");
	}];
	collectonview.delegate = collectDelegate;
}

//自定义collectionviewSectionHeaderView
- (UIView *)createCollectionHeaderView {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
	view.backgroundColor = [UIColor redColor];
	return view;
}
//自定义collectionviewSectionFooterView
- (UIView *)createCollectionFooterView {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
	view.backgroundColor = [UIColor blackColor];
	return view;
}

- (void)dealloc {
	NSLog(@"TableviewController释放");
}
@end
