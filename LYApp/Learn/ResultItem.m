//
//  ResultItem.m
//  LYApp
//
//  Created by lichanghong on 16/7/8.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "ResultItem.h"

@implementation ResultItem

+ (ResultItem *)responseWith:(id)json
{
    if (json && [json isKindOfClass:[NSDictionary class]]) {
        ResultItem *item = [[ResultItem alloc]init];
        item.commit_time=json[@"commit_time"]?json[@"commit_time"]:@"";
        item.g_id=json[@"g_id"]?json[@"g_id"]:@"";
        item.is_teacher=json[@"is_teacher"]?json[@"is_teacher"]:@"";
        item.kid=json[@"kid"]?json[@"kid"]:@"";
        item.nickname=json[@"nickname"]?json[@"nickname"]:@"";
        item.uid=json[@"uid"]?json[@"uid"]:@"";
        item.verify_state=json[@"verify_state"]?json[@"verify_state"]:@"";
        item.question_analysis=json[@"question_analysis"]?json[@"question_analysis"]:@"";
        return item;
    }
    return nil;
}

@end
