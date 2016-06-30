//
//  HttpUtil.m
//  LYApp
//
//  Created by lichanghong on 16/6/30.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "HttpUtil.h"
#import "AFNetworking.h"

@implementation HttpUtil




+ (void)doRegistNewUserWithUsername:(NSString *)username PW:(NSString *)pw success:(void (^)(id))success failure:(void (^)(NSError *error))failure
{
    if( username==nil || pw==nil)
        return;

    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/regist?username=%@&password=%@",
                    kHostName,username,pw];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:api parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
    
}







+ (instancetype)shareInstance
{
    static HttpUtil *_httputil = nil;
    @synchronized (self) {
        if (_httputil) {
            return _httputil;
        }
        _httputil =[[HttpUtil alloc]init];
    }
    return _httputil;
}














@end
