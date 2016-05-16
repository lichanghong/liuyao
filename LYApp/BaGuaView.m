//
//  BaGuaView.m
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "BaGuaView.h"
#import "YYView.h"

@implementation BaGuaView
{
    YYView *_view1;
    YYView *_view2;
    YYView *_view3;
    YYView *_view4;
    YYView *_view5;
    YYView *_view6;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    
    NSMutableArray *viewArr;
    NSMutableArray *btnArr;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _view1 = [self createView];
        _view2 = [self createView];
        _view3 = [self createView];
        _view4 = [self createView];
        _view5 = [self createView];
        _view6 = [self createView];
        [self addSubview:_view1];
        [self addSubview:_view2];
        [self addSubview:_view3];
        [self addSubview:_view4];
        [self addSubview:_view5];
        [self addSubview:_view6];
        
        btn1= [self createButton];
        btn2= [self createButton];
        btn3= [self createButton];
        btn4= [self createButton];
        btn5= [self createButton];
        btn6= [self createButton];
        [self addSubview:btn6];
        [self addSubview:btn5];
        [self addSubview:btn4];
        [self addSubview:btn3];
        [self addSubview:btn2];
        [self addSubview:btn1];
        
        viewArr = [NSMutableArray arrayWithObjects:_view1,_view2,_view3,_view4,_view5,_view6, nil];
        btnArr  = [NSMutableArray arrayWithObjects:btn1,btn2,btn3,btn4,btn5,btn6, nil];
    }
    return self;
}

- (UIButton *)createButton
{
    UIButton *button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (YYView *)createView
{
    YYView *view = [[YYView alloc]init];
    return view;
}

- (void)handleAction:(id)sender
{
    for (int i=0;i<btnArr.count;i++) {
        UIButton *btn = btnArr[i];
        YYView   *view= viewArr[i];
        
        if (sender == btn) {
            if (_isbianyao) {
                [view changeToBianYao:YES];
            }
            else
            {
                [view changeToBianYao:NO];
                [view  changeState];
            }
            [self.delegate BaGuaView:self ActionType:i];
        }
    }
    
}
- (void)clearBianAtIndex:(int)index
{
    YYView   *view= viewArr[index];
    [view changeToBianYao:NO];
}
- (void)changeAtIndex:(int)index
{
    YYView   *view= viewArr[index];
    [view  changeState];
}

- (void)layoutSubviews
{
    CGFloat blackH = 13;
    CGFloat height = (self.frame.size.height-6*blackH)/5.0;
    CGFloat width = self.frame.size.width;
    
    _view1.frame = CGRectMake(0, 0, width, blackH);
    _view2.frame = CGRectMake(0, height+blackH, width, blackH);
    _view3.frame = CGRectMake(0, (height+blackH)*2, width, blackH);
    _view4.frame = CGRectMake(0,  (height+blackH)*3, width, blackH);
    _view5.frame = CGRectMake(0,  (height+blackH)*4, width, blackH);
    _view6.frame = CGRectMake(0,  (height+blackH)*5, width, blackH);
    
    CGFloat buttonH = self.frame.size.height/6.0;
    width-=5;
    btn1.frame = CGRectMake(0, 0, width, buttonH);
    btn2.frame = CGRectMake(0, buttonH*1, width, buttonH);
    btn3.frame = CGRectMake(0, buttonH*2, width, buttonH);
    btn4.frame = CGRectMake(0, buttonH*3, width, buttonH);
    btn5.frame = CGRectMake(0, buttonH*4, width, buttonH);
    btn6.frame = CGRectMake(0, buttonH*5, width, buttonH);
    btn1.center = _view1.center;
    btn2.center = _view2.center;
    btn3.center = _view3.center;
    btn4.center = _view4.center;
    btn5.center = _view5.center;
    btn6.center = _view6.center;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
