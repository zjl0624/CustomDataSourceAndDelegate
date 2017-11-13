//
//  CustomTableViewDelegate.m
//  CustomDataSourceAndDelegate
//
//  Created by zjl on 2017/11/13.
//  Copyright © 2017年 zjl. All rights reserved.
//

#import "CustomTableViewDelegate.h"

@implementation CustomTableViewDelegate
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleDelete;
}
@end
