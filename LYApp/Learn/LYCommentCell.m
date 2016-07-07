//
//  LYCommentCell.m
//  LYApp
//
//  Created by lichanghong on 16/7/7.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYCommentCell.h"

@implementation LYCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _textView.layer.cornerRadius = 5;
    // Initialization code
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (indexPath.section==0) {
        _textView.text = @"我对此卦的分析是：";
    }
    else
    {
        _textView.text = @"经过分析，结果应该是：";
    }
    _textView.tag = indexPath.section;

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
