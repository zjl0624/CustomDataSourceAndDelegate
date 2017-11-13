//
//  CustomTableViewDataSource.m
//  CustomDataSourceAndDelegate
//
//  Created by zjl on 2017/11/13.
//  Copyright © 2017年 zjl. All rights reserved.
//

#import "CustomTableViewDataSource.h"

@implementation CustomTableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	NSMutableArray *arr = [self.dataArray mutableCopy];
	id temp = arr[sourceIndexPath.row];
	arr[sourceIndexPath.row] = arr[destinationIndexPath.row];
	arr[destinationIndexPath.row] = temp;
	self.dataArray = arr;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSLog(@"删除");
	}
}
@end
