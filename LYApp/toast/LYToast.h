//
//  LYToast.h
//  LYApp
//
//  Created by lichanghong on 16/6/29.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LYToast : NSObject
+ (void)showToast:(id)obj;
+ (void)showToast:(id)obj view:(UIView *) view duration:(NSTimeInterval) duration;

+ (void)showLchToast:(id)obj InView:(UIView *)view;

@end
