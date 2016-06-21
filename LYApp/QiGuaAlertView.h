//
//  QiGuaAlertView.h
//  LYApp
//
//  Created by lichanghong on 16/6/21.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QiGuaAlertView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>


+ (QiGuaAlertView *)createView;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
