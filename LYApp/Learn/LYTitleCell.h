//
//  LYTitleCell.h
//  LYApp
//
//  Created by 李长鸿 on 7/2/16.
//  Copyright © 2016 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

//审核中，审核成功，审核失败，已解卦
typedef enum : NSUInteger {
    LYTitleCell_verifing,
    LYTitleCell_verified,
    LYTitleCell_failed,
    LYTitleCell_solved
} LYTitleCell_verifystate;

@interface LYTitleCell : UITableViewCell

@property (nonatomic,assign)LYTitleCell_verifystate verifyState;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *verifyImage;



@end
