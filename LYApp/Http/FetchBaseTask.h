//
//  FetchBaseTask.h
//  LYApp
//
//  Created by lichanghong on 16/6/30.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchBaseTask : NSObject


+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id  obj))success
     failure:(void (^)(NSString*errmsg))failure;


@end
