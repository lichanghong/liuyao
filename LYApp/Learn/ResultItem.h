//
//  ResultItem.h
//  LYApp
//
//  Created by lichanghong on 16/7/8.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultItem : NSObject
@property (nonatomic,strong)NSString *commit_time;
@property (nonatomic,strong)NSString *g_id;
@property (nonatomic,strong)NSString *is_teacher;
@property (nonatomic,strong)NSString *kid;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *uid;
@property (nonatomic,strong)NSString *verify_state;
@property (nonatomic,strong)NSString *question_analysis;

+ (ResultItem *)responseWith:(id)json;

@end
