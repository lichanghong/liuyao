//
//  FetchBaseTask.m
//  LYApp
//
//  Created by lichanghong on 16/6/30.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "FetchBaseTask.h"
#import "AFNetworking.h"
#import "UserManager.h"

@implementation FetchBaseTask

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    u_int32_t value = (arc4random() % 9999999) + 1001010;
    time_t t =time(NULL);
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    [parameters setObject:@(value) forKey:@"random"];
    [parameters setObject:@(t) forKey:@"timestamp"];
    [parameters setObject:[UserManager token:t random:value] forKey:@"token"];
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress){
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLogError(@"error=%@",error);
        if (error.code==3840) {
            failure(@"服务器错误,请联系管理员！");
        }
        else if (error.code==-1001) {
            failure(@"请求超时,请过会重试");
        }
        else if (error.code==-1009) {
            failure(@"您未连接网络");
        }
        else
            failure(error.localizedDescription);
    }];
}
 




@end
