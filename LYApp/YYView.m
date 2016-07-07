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
    UIImageView *yao;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        yao = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        yao.backgroundColor = [UIColor clearColor];
        [self addSubview:yao];
        self.state = YYView_Laoyang;
    }
    return self;
}

- (void)setState:(YYViewState)state
{
    switch (state) {
        case YYView_Yin:
            yao.image = [UIImage imageNamed:@"yin"];
            break;
        case YYView_Yang:
            yao.image = [UIImage imageNamed:@"yang"];

            break;
        case YYView_Laoyin:
            yao.image = [UIImage imageNamed:@"laoyin"];

            break;
        case YYView_Laoyang:
            yao.image = [UIImage imageNamed:@"laoyang"];

            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
