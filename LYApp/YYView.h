//
//  YYView.h
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    YYView_Yin,
    YYView_Yang,
    YYView_Laoyin,
    YYView_Laoyang
} YYViewState;
//阴阳视图
@interface YYView : UIView
@property (nonatomic,assign)YYViewState state;

@property (nonatomic,assign)BOOL isYang;

@end
