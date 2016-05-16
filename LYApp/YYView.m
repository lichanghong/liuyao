//
//  YYView.m
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "YYView.h"

@implementation YYView
{
    UIView *yangV;
    UIView *yinV1;
    UIView *yinV2;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        yangV = [self createV];
        yinV1 = [self createV];
        yinV2 = [self createV];
        [self addSubview:yangV];
        [self addSubview:yinV1];
        [self addSubview:yinV2];
        self.isYang = true;
       
    }
    return self;
}


- (UIView *)createV
{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor blackColor];
    return v;
}

- (void)changeState
{
    if (self.isYang) {
        self.isYang = NO;
    }
    else self.isYang = YES;
}

- (void)setIsYang:(BOOL)isYang
{
    _isYang = isYang;
    if (isYang) {
        [yinV1 setHidden:YES];
        [yinV2 setHidden:YES];
        [yangV setHidden:NO];
    }
    else
    {
        [yinV1 setHidden:NO];
        [yinV2 setHidden:NO];
        [yangV setHidden:YES];
    }
}

- (void)changeToBianYao:(BOOL)isbian
{
    if (isbian) {
        yinV1.backgroundColor = [UIColor blueColor];
        yinV2.backgroundColor = [UIColor blueColor];
        yangV.backgroundColor = [UIColor blueColor];
    }
    else
    {
        yinV1.backgroundColor = [UIColor blackColor];
        yinV2.backgroundColor = [UIColor blackColor];
        yangV.backgroundColor = [UIColor blackColor];

    }
}


- (void)layoutSubviews
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    yangV.frame = CGRectMake(0, 0, width, height);
    yinV1.frame = CGRectMake(0, 0, (width-10)/2.0, height);
    yinV2.frame = CGRectMake((width-10)/2.0+10, 0, (width-10)/2.0, height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
