//
//  LYTitleCell.m
//  LYApp
//
//  Created by 李长鸿 on 7/2/16.
//  Copyright © 2016 lichanghong. All rights reserved.
//

#import "LYTitleCell.h"

@implementation LYTitleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVerifyState:(LYTitleCell_verifystate)verifyState
{
    _verifyState = verifyState;
    switch (_verifyState) {
        case LYTitleCell_verifing:
            _verifyImage.image = [UIImage imageNamed:@"verify_ing"];
            break;
        case  LYTitleCell_verified:
            _verifyImage.image = [UIImage imageNamed:@"verify_ok"];
            break;
        case  LYTitleCell_failed:
            _verifyImage.image = [UIImage imageNamed:@"verify_fail"];
            break;
        case  LYTitleCell_solved:
            _verifyImage.image = [UIImage imageNamed:@"null"];
            break;

            
        default:
            break;
    }
}
@end
