//
//  BaGuaView.h
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYView.h"


@interface BaGuaView : UIView

@property (nonatomic,strong)NSDictionary *guaItem;

@property (nonatomic,strong)NSArray *liushenArr;//六神


@property (nonatomic,strong) YYView *view1;
@property (nonatomic,strong) YYView *view2;
@property (nonatomic,strong) YYView *view3;
@property (nonatomic,strong) YYView *view4;
@property (nonatomic,strong) YYView *view5;
@property (nonatomic,strong) YYView *view6;
 

@property (strong, nonatomic)  UILabel *liushou1;
@property (strong, nonatomic)  UILabel *liushou2;
@property (strong, nonatomic)  UILabel *liushou3;
@property (strong, nonatomic)  UILabel *liushou4;
@property (strong, nonatomic)  UILabel *liushou5;
@property (strong, nonatomic)  UILabel *liushou6;



@property (strong, nonatomic)  UILabel *wuxing1;
@property (strong, nonatomic)  UILabel *wuxing2;
@property (strong, nonatomic)  UILabel *wuxing3;
@property (strong, nonatomic)  UILabel *wuxing4;
@property (strong, nonatomic)  UILabel *wuxing5;
@property (strong, nonatomic)  UILabel *wuxing6;


@property (strong, nonatomic)  UILabel *shiying1;
@property (strong, nonatomic)  UILabel *shiying2;
@property (strong, nonatomic)  UILabel *shiying3;
@property (strong, nonatomic)  UILabel *shiying4;
@property (strong, nonatomic)  UILabel *shiying5;
@property (strong, nonatomic)  UILabel *shiying6;

@property (strong, nonatomic)  UILabel *bianWuxing;
@property (strong, nonatomic)  UILabel *bianWuxing1;
@property (strong, nonatomic)  UILabel *bianWuxing2;
@property (strong, nonatomic)  UILabel *bianWuxing3;
@property (strong, nonatomic)  UILabel *bianWuxing4;
@property (strong, nonatomic)  UILabel *bianWuxing5;

@end
