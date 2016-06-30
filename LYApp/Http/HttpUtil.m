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

+ (void)doUploadGuaWithQuestion:(NSString *)question
                     gua_gender:(NSString *)gender
                       gua_date:(NSString *)date
                        gua_gua:(NSString *)gua
                        success:(void (^)(id))success
                        failure:(void (^)(NSError *))failure
{
    UserManager *user= [UserManager defaultManager];

    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/guaupload",
                    kHostName];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:user.userid forKey:@"uid"];
    [dic setObject:gender   forKey:@"g_gender"];
    [dic setObject:question forKey:@"g_question"];
    [dic setObject:date forKey:@"g_date"];
    [dic setObject:gua forKey:@"g_gua"];
    
    [manager POST:api parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


+ (void)doRegistNewUserWithUsername:(NSString *)username PW:(NSString *)pw success:(void (^)(id))success failure:(void (^)(NSError *error))failure
{
    if( username==nil || pw==nil)
        return;

    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/regist",
                    kHostName];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:username forKey:@"username"];
    [dic setObject:pw forKey:@"password"];
    
    [manager POST:api parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)doLoginWithUsername:(NSString *)username PW:(NSString *)pw success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if( username==nil || pw==nil)
    return;
    
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/login",
                    kHostName];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:username forKey:@"username"];
    [dic setObject:pw forKey:@"password"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:api parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
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
