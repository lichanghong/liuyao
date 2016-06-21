//
//  QiGuaAlertView.h
//  LYApp
//
//  Created by lichanghong on 16/6/21.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QiGuaAlertViewDelegate <NSObject>

- (void)QiGuaAlertViewResult:(NSArray *)arr;

@end

@interface QiGuaAlertView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,weak)id<QiGuaAlertViewDelegate>delegate;

+ (QiGuaAlertView *)createView;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
