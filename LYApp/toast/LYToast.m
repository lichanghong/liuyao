//
//  LYToast.m
//  LYApp
//
//  Created by lichanghong on 16/6/29.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYToast.h"
#import "Toast+UIView.h"

static UIWindow *_toastWindow = nil;

@implementation LYToast
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _toastWindow = [[UIWindow alloc] initWithFrame:KScreenRect];
        _toastWindow.backgroundColor = [UIColor clearColor];
        _toastWindow.userInteractionEnabled = NO;
        _toastWindow.hidden = NO;
    });
}


+ (void)showToast:(id)obj view:(UIView *) view duration:(NSTimeInterval) duration
{
    dispatch_block_t block = ^{
        NSString *text = [NSString stringWithFormat:@"%@",obj];
        [[[UIApplication sharedApplication] keyWindow]  makeToast:text duration:duration position:@"center"];
    };
    dispatch_main_sync_safe(block);
}

+ (void)showToast:(id)obj
{
    dispatch_block_t block = ^{
        NSString *text = [NSString stringWithFormat:@"%@",obj];
        [[[UIApplication sharedApplication] keyWindow]  makeToast:text duration:1.5 position:@"center"];
    };
    dispatch_main_sync_safe(block);
}
 

+ (void)showLchToast:(id)obj InView:(UIView *)view
{
    dispatch_block_t block = ^{
        NSString *text = [NSString stringWithFormat:@"%@",obj];
        [view makeToast:text duration:1.5 position:@"center"];
    };
    dispatch_main_sync_safe(block);
}

@end
