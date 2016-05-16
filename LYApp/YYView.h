//
//  YYView.h
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
//阴阳视图
@interface YYView : UIView
@property (nonatomic,assign)BOOL isYang;

- (void)changeState;

- (void)changeToBianYao:(BOOL)isbian;

@end
