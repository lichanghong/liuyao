//
//  ResultDetailView.h
//  LYApp
//
//  Created by lichanghong on 16/7/8.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultItem.h"

@interface ResultDetailView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic,strong)UILabel *namelabel;
@property (nonatomic,strong)UILabel *timelabel;
@property (nonatomic,strong)UITextView *textv1;
@property (nonatomic,strong)UITextView *textv2;
@property (nonatomic,strong)UIScrollView *detailScrollView;

- (void)showInView:(UIView *)view WithResultItem:(ResultItem *)item;
- (void)dismiss;
- (instancetype)initWithTableHeadView:(UIView *)tableHeadView;
 
@end
