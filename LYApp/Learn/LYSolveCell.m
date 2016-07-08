//
//  LYSolveCell.m
//  LYApp
//
//  Created by 李长鸿 on 7/3/16.
//  Copyright © 2016 lichanghong. All rights reserved.
//

#import "LYSolveCell.h"

#define Identifier @"LYSolveCell"
#define NidName @"LYSolveCell"

@implementation LYSolveCell

+(void)registerCellWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:NidName bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:Identifier];
}

+(NSString *)identifier
{
    return Identifier;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.layer.cornerRadius = 2.0f;
    self.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
