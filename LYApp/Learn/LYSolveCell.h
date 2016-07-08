//
//  LYSolveCell.h
//  LYApp
//
//  Created by 李长鸿 on 7/3/16.
//  Copyright © 2016 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultItem.h"

@interface LYSolveCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *time;




+(void)registerCellWithTableView:(UITableView *)tableView;

+(NSString *)identifier;

-(void)setData:(ResultItem *)data;


@end
