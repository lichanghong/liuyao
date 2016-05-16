//
//  BaGuaView.h
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    selectOne,
    selectTwo,
    selectThree,
    selectFore,
    selectFive,
    selectSix,
} SelectType;

@protocol BaGuaViewDelegate <NSObject>

- (void)BaGuaView:(id)sender ActionType:(SelectType)type;

@end



@interface BaGuaView : UIView

@property(assign)BOOL isbianyao;
@property(nonatomic,weak)id<BaGuaViewDelegate>delegate;


- (void)changeAtIndex:(int)index;
- (void)clearBianAtIndex:(int)index;

@end
