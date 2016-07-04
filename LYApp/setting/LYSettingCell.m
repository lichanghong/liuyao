//
//  LYSettingCell.m
//  LYApp
//
//  Created by lichanghong on 16/7/4.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYSettingCell.h"

@implementation LYSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:self.nameLabel];
    }
    return self;
}

- (UILabel*)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, KScreenWidth-30, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.backgroundColor = [UIColor clearColor];
    }
    return _nameLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
