//
//  LYCommentCell.h
//  LYApp
//
//  Created by lichanghong on 16/7/7.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCommentCell : UITableViewCell 

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong)NSIndexPath *indexPath;
@end
