//
//  UserManager.m
//  LYApp
//
//  Created by lichanghong on 16/6/29.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager







+(instancetype)defaultManager
{
    static UserManager *s_manager = nil;
    @synchronized (self) {
        if (s_manager) {
            return s_manager;
        }
        s_manager = [[UserManager alloc]init];
    }
    return s_manager;
}

@end
