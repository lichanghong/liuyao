//
//  BaGuaView.m
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "BaGuaView.h"
#import "GuaManager.h"

@implementation BaGuaView{
    NSArray *shiyingArr;
    NSArray *yaoArr;
}

- (void)setGuaItem:(NSDictionary *)guaItem
{
    _guaItem = guaItem;
    NSDictionary *dic = _guaItem;
    NSArray *guaa = [dic[@"g_gua"]componentsSeparatedByString:@":"];
    int guaindex = [[guaa firstObject]intValue];
    int bianguaindex = [guaa[1] intValue];
    
    NSArray *wuxingArr =[[GuaManager shareManager]wuxingAtIndex:guaindex];
    _wuxing1.text = wuxingArr[0];
    _wuxing2.text = wuxingArr[1];
    _wuxing3.text = wuxingArr[2];
    _wuxing4.text = wuxingArr[3];
    _wuxing5.text = wuxingArr[4];
    _wuxing6.text = wuxingArr[5];
    
//    卦
    for (int i=2; i<yaoArr.count+2; i++) {
        if ([guaa[i] intValue]==0) {
            YYView *yao = yaoArr[i-2];
            yao.state = YYView_Yin;
        }
        else if([guaa[i] intValue]==1){
            YYView *yao = yaoArr[i-2];
            yao.state = YYView_Yang;
        }
        else if([guaa[i] intValue]==2){
            YYView *yao = yaoArr[i-2];
            yao.state = YYView_Laoyin;
        }
        else if([guaa[i] intValue]==3){
            YYView *yao = yaoArr[i-2];
            yao.state = YYView_Laoyang;
        }
    }
 
    
    shiyingArr = [NSArray arrayWithObjects:_shiying6,_shiying5, _shiying4,_shiying3,_shiying2, _shiying1,nil];
    
    //世应
    int shiindex = [wuxingArr[6]intValue]-1;
    int yingindex = [wuxingArr[7]intValue]-1;
    for (int i=0;i<6; i++) {
        UILabel *shilabel = shiyingArr[i];
        
        if (i!=shiindex && i!=yingindex) {
            [shilabel setHidden:YES];
        }
        else
        {
            [shilabel setHidden:NO];
            
            if (i==shiindex) {
                shilabel.text = @"世";
            }
            else
                shilabel.text = @"应";
        }
    }
    //变卦五行
    NSArray *bwuxingArr =[[GuaManager shareManager]wuxingAtIndex:bianguaindex];
    _bianWuxing.text  = [bwuxingArr[0] substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing1.text = [bwuxingArr[1] substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing2.text = [bwuxingArr[2]substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing3.text = [bwuxingArr[3]substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing4.text = [bwuxingArr[4]substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing5.text = [bwuxingArr[5]substringWithRange:NSMakeRange(1, 2)];

}



- (void)setLiushenArr:(NSArray *)liushenArr
{
    _liushenArr = liushenArr;
    if (liushenArr.count>0) {
        _liushou1.text = liushenArr[0];
        _liushou2.text = liushenArr[1];
        _liushou3.text = liushenArr[2];
        _liushou4.text = liushenArr[3];
        _liushou5.text = liushenArr[4];
        _liushou6.text = liushenArr[5];
    }
}

//------------base ui creeate ------------

- (UILabel *)createShiYingBaseLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    label.text = @"世";
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (UILabel *)createLiushouBaseLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor orangeColor];
    label.text = @"虎";
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (UILabel *)createWuxingBaseLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor blackColor];
    label.text = @"父戌土";
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (YYView *)createView
{
    YYView *view = [[YYView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
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
        yaoArr = [NSArray arrayWithObjects:_view1,_view2,_view3,_view4,_view5,_view6,nil];
        
        _liushou1 = [self createLiushouBaseLabel];
        _liushou2 = [self createLiushouBaseLabel];
        _liushou3 = [self createLiushouBaseLabel];
        _liushou4 = [self createLiushouBaseLabel];
        _liushou5 = [self createLiushouBaseLabel];
        _liushou6 = [self createLiushouBaseLabel];
        [self addSubview:_liushou1];
        [self addSubview:_liushou2];
        [self addSubview:_liushou3];
        [self addSubview:_liushou4];
        [self addSubview:_liushou5];
        [self addSubview:_liushou6];
        
        _wuxing1 = [self createWuxingBaseLabel];
        _wuxing2 = [self createWuxingBaseLabel];
        _wuxing3 = [self createWuxingBaseLabel];
        _wuxing4 = [self createWuxingBaseLabel];
        _wuxing5 = [self createWuxingBaseLabel];
        _wuxing6 = [self createWuxingBaseLabel];
        [self addSubview:_wuxing1];
        [self addSubview:_wuxing2];
        [self addSubview:_wuxing3];
        [self addSubview:_wuxing4];
        [self addSubview:_wuxing5];
        [self addSubview:_wuxing6];
        
        _shiying1 = [self createShiYingBaseLabel];
        _shiying2 = [self createShiYingBaseLabel];
        _shiying3 = [self createShiYingBaseLabel];
        _shiying4 = [self createShiYingBaseLabel];
        _shiying5 = [self createShiYingBaseLabel];
        _shiying6 = [self createShiYingBaseLabel];
        [self addSubview:_shiying1];
        [self addSubview:_shiying2];
        [self addSubview:_shiying3];
        [self addSubview:_shiying4];
        [self addSubview:_shiying5];
        [self addSubview:_shiying6];
        
        _bianWuxing = [self createWuxingBaseLabel];
        _bianWuxing1 = [self createWuxingBaseLabel];
        _bianWuxing2 = [self createWuxingBaseLabel];
        _bianWuxing3 = [self createWuxingBaseLabel];
        _bianWuxing4 = [self createWuxingBaseLabel];
        _bianWuxing5 = [self createWuxingBaseLabel];
        [self addSubview:_bianWuxing];
        [self addSubview:_bianWuxing1];
        [self addSubview:_bianWuxing2];
        [self addSubview:_bianWuxing3];
        [self addSubview:_bianWuxing4];
        [self addSubview:_bianWuxing5];
        
        CGFloat blackH = 13;
        CGFloat height = (self.frame.size.height-6*blackH)/5.0;
        
        CGFloat liushowW = 18;
        CGFloat liushowH = 20;
        CGFloat liushowY = height+ liushowH-8;
        _liushou1.frame = CGRectMake(0, 0, liushowW, liushowH);
        _liushou2.frame = CGRectMake(0, liushowY, liushowW, liushowH);
        _liushou3.frame = CGRectMake(0, (liushowY)*2, liushowW, liushowH);
        _liushou4.frame = CGRectMake(0,  (liushowY)*3, liushowW, liushowH);
        _liushou5.frame = CGRectMake(0,  (liushowY)*4, liushowW, liushowH);
        _liushou6.frame = CGRectMake(0,  (liushowY)*5, liushowW, liushowH);
        
        CGFloat wuxingX = MaxX(_liushou1);
        CGFloat wuxingW = 40;
        _wuxing1.frame = CGRectMake(wuxingX, 0, wuxingW, liushowH);
        _wuxing2.frame = CGRectMake(wuxingX, liushowY, wuxingW, liushowH);
        _wuxing3.frame = CGRectMake(wuxingX, (liushowY)*2, wuxingW, liushowH);
        _wuxing4.frame = CGRectMake(wuxingX,  (liushowY)*3, wuxingW, liushowH);
        _wuxing5.frame = CGRectMake(wuxingX,  (liushowY)*4, wuxingW, liushowH);
        _wuxing6.frame = CGRectMake(wuxingX,  (liushowY)*5, wuxingW, liushowH);
        
        CGFloat viewW = 12;
        CGFloat viewX = MaxX(_wuxing1);
        _view1.frame = CGRectMake(viewX, 5, viewW, blackH);
        _view2.frame = CGRectMake(viewX, height+blackH, viewW, blackH);
        _view3.frame = CGRectMake(viewX, (height+blackH)*2, viewW, blackH);
        _view4.frame = CGRectMake(viewX,  (height+blackH)*3, viewW, blackH);
        _view5.frame = CGRectMake(viewX,  (height+blackH)*4, viewW, blackH);
        _view6.frame = CGRectMake(viewX,  (height+blackH)*5, viewW, blackH);
        
        
        CGFloat shiyingX = MaxX(_view1)+5;
        CGFloat shiyingW = 18;
        _shiying1.frame = CGRectMake(shiyingX, 0, shiyingW, liushowH);
        _shiying2.frame = CGRectMake(shiyingX, liushowY, shiyingW, liushowH);
        _shiying3.frame = CGRectMake(shiyingX, (liushowY)*2, shiyingW, liushowH);
        _shiying4.frame = CGRectMake(shiyingX,  (liushowY)*3, shiyingW, liushowH);
        _shiying5.frame = CGRectMake(shiyingX,  (liushowY)*4, shiyingW, liushowH);
        _shiying6.frame = CGRectMake(shiyingX,  (liushowY)*5, shiyingW, liushowH);
        
        CGFloat bianwuxingX = MaxX(_shiying1)+25;
        CGFloat bianW = 50;
        _bianWuxing.frame = CGRectMake(bianwuxingX, 0, bianW, liushowH);
        _bianWuxing1.frame = CGRectMake(bianwuxingX, liushowY, bianW, liushowH);
        _bianWuxing2.frame = CGRectMake(bianwuxingX, (liushowY)*2, bianW, liushowH);
        _bianWuxing3.frame = CGRectMake(bianwuxingX,  (liushowY)*3, bianW, liushowH);
        _bianWuxing4.frame = CGRectMake(bianwuxingX,  (liushowY)*4, bianW, liushowH);
        _bianWuxing5.frame = CGRectMake(bianwuxingX,  (liushowY)*5, bianW, liushowH);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
