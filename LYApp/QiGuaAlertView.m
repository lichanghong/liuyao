//
//  QiGuaAlertView.m
//  LYApp
//
//  Created by lichanghong on 16/6/21.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "QiGuaAlertView.h"

@implementation QiGuaAlertView
{
    UIView *_contentView;
    UIPickerView *_pickerView;
    NSArray *_pickerArray;
    NSMutableArray *_pickerViewArray;
    
    NSArray *_titles ;
    UIButton *_confirmButton;
}

+ (QiGuaAlertView *)createView
{
    QiGuaAlertView *alertview = [[QiGuaAlertView alloc]initWithFrame:KScreenRect];
    alertview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    return alertview;
}

- (void)showInView:(UIView *)view
{
    if (![self isDescendantOfView:view]) {
        [view addSubview:self];
        _contentView.center = self.center;
    }
    [view bringSubviewToFront:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        }
    return self;
}

- (void)initUI
{
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, KScreenWidth-2*12, 280)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [_contentView setClipsToBounds:YES];
    _contentView.layer.cornerRadius = 6;
    
    [self addSubview:_contentView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired =1;
    [self addGestureRecognizer: tap];
    
    _pickerArray = [NSArray arrayWithObjects:@"两反一正",@"两正一反",@"三个反",@"三个正", nil];
    _titles = [NSArray arrayWithObjects:@"第一爻",@"第二爻",@"第三爻",@"第四爻",@"第五爻",@"第六爻", nil];
    _pickerViewArray = [NSMutableArray array];
    CGFloat w=(ViewW(_contentView)-20*2)/3.0;

    for (int i=0; i<6; i++) { //间隔20，左右12
        CGFloat pickerviewX = i*(20+w);
        CGFloat pickerviewY = 20;
        if (i>2) {
            pickerviewY=pickerviewY + 100+10;
            pickerviewX=(i-3)*(20+w);
        }
        UIPickerView *pickerview = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerviewX, pickerviewY, w, 100)];
        pickerview.delegate = self;
        pickerview.dataSource = self;
        pickerview.tag = i+5;
        
        UILabel *label = [self createLabel];
        label.frame = CGRectMake(pickerviewX,pickerviewY-10, w, 40);
        label.text = _titles[i];
        [_pickerViewArray addObject:pickerview];
        [_contentView addSubview:label];
        [_contentView addSubview:pickerview];
    }
    
    _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(5, ViewH(_contentView)-50, ViewW(_contentView)-10, 40)];
    [_confirmButton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    _confirmButton.backgroundColor = [UIColor colorForHex:@"009900"];
    [_contentView addSubview:_confirmButton];
}

- (void)handleAction:(id)sender
{
    
}
- (UILabel *)createLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [[UIColor blueColor]colorWithAlphaComponent:0.8];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerArray objectAtIndex:row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    if (component == 0) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_pickerArray objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        myView.backgroundColor = [UIColor clearColor];
    }
    return myView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
