//
//  ResultDetailView.m
//  LYApp
//
//  Created by lichanghong on 16/7/8.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "ResultDetailView.h"

@implementation ResultDetailView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView *view = touch.view;
    for (UIView *sub in _detailScrollView.subviews) {
        if (view==sub) {
            return NO;
            break;
        }
    }
    if (view == _detailScrollView) {
        return NO;
    }
    return YES;
}
- (instancetype)initWithTableHeadView:(UIView *)tableHeadView
{
    self = [super init];
    if (self) {
        self.frame = KScreenRect;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        [tap setNumberOfTapsRequired:1];
        [tap setNumberOfTouchesRequired:1];
        [self addGestureRecognizer:tap];
        if (!_detailScrollView) {
            _detailScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10,ViewH(tableHeadView)+30, KScreenWidth-20, KScreenHeight-ViewH(tableHeadView)-35)];
        }
        [_detailScrollView setScrollEnabled:YES];
        _detailScrollView.layer.cornerRadius = 5;
        [_detailScrollView setBackgroundColor: [UIColor whiteColor]];
        [self addSubview:_detailScrollView];
        CGFloat w = ViewW(_detailScrollView)-20;
        
        //scroll view subview
        _namelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, w ,20)];
        _namelabel.font = [UIFont systemFontOfSize:13];
        _namelabel.textColor = [UIColor grayColor];
        [_detailScrollView addSubview:_namelabel];
        
        _timelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, MaxY(_namelabel)+2, w, 20)];
        _timelabel.font = [UIFont systemFontOfSize:13];
        _timelabel.textColor = [UIColor grayColor];
        [_detailScrollView addSubview:_timelabel];
        
        
        _textv1 = [[UITextView alloc]initWithFrame:CGRectMake(10, MaxY(_timelabel)+2, w, 0)];
        _textv1.font = [UIFont systemFontOfSize:13];
        _textv1.textColor = [UIColor grayColor];
        _textv1.scrollEnabled = NO;
        [_textv1 setEditable:NO];
        _textv2 = [[UITextView alloc]initWithFrame:CGRectMake(10, MaxY(_textv1)+2, w, 0)];
        _textv2.font = [UIFont systemFontOfSize:13];
        _textv2.textColor = [UIColor grayColor];
        _textv2.scrollEnabled = NO;
        [_textv2 setEditable:NO];
        [_detailScrollView addSubview:_textv1];
        [_detailScrollView addSubview:_textv2];
    }
    return self;
}


- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
//        self.detailScrollView.frame = CGRectMake(0, KScreenHeight, KScreenWidth,  ABS(ViewHeight(_detailScrollView)));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//        _detailScrollView.frame = CGRectMake(0, KScreenHeight, KScreenWidth, ViewHeight(_reportContent));
    }];
}

- (void)dealloc
{
    _detailScrollView = nil;
}


- (void)showInView:(UIView *)view WithResultItem:(ResultItem *)item
{
    [view addSubview:self];
    [view bringSubviewToFront:self];
    _detailScrollView.frame = CGRectMake(0, KScreenHeight , KScreenWidth, ViewH(_detailScrollView));
    [UIView animateWithDuration:0.3 animations:^{
        _detailScrollView.frame = CGRectMake(0, KScreenHeight - ViewH(_detailScrollView), KScreenWidth, ViewH(_detailScrollView));
    }];

    NSArray *question_analysisArr = [item.question_analysis componentsSeparatedByString:@"{[]}"];
    CGFloat w = ViewW(_detailScrollView)-20;
    
    _namelabel.text = [NSString stringWithFormat:@"卦师称号: %@",item.nickname];
    _timelabel.text = [NSString stringWithFormat:@"解卦时间: %@",item.commit_time];
    if (question_analysisArr && question_analysisArr.count==2) {
        _textv1.text = [NSString stringWithFormat:@"看卦结果:\n%@",question_analysisArr[0]];
        _textv2.text = [NSString stringWithFormat:@"具体分析:\n%@",question_analysisArr[1]];
        CGSize constraintSize = CGSizeMake(ViewW(_textv1), MAXFLOAT);
        CGSize size = [_textv1 sizeThatFits:constraintSize];
        CGSize size2 = [_textv2 sizeThatFits:constraintSize];
        setH(_textv1,size.height);
        _textv2.frame = CGRectMake(CGRectGetMinX(_textv1.frame), MaxY(_textv1)+3, w, size2.height);
    }
    _detailScrollView.contentSize = CGSizeMake(ViewW(_detailScrollView), MaxY(_textv2));
}




@end
