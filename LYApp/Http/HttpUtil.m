//
//  HttpUtil.m
//  LYApp
//
//  Created by lichanghong on 16/6/30.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "HttpUtil.h"
#import "AFNetworking.h"
#import "FetchBaseTask.h"

@implementation HttpUtil

static bool isloading1=false;
+ (void)doLoadGuaItemsSuccess:(void (^)(id))success
                      failure:(void (^)(NSString* errmsg))failure
{
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/getguaitem",
                    kHostName];
    if (!isloading1) {
        isloading1=true;
        [FetchBaseTask POST:api parameters:nil success:^(id obj) {
            isloading1=false;
            success(obj);
            
        } failure:^(NSString *errmsg) {
            isloading1=false;
            failure(errmsg);
        }];
    }
    else
    {
        DDLogError(@"loading... skip..");
    }
    
}

static bool isloading2=false;
+ (void)doUploadGuaWithQuestion:(NSString *)question
                     gua_gender:(NSString *)gender
                       gua_date:(NSString *)date
                        gua_gua:(NSString *)gua
                        success:(void (^)(id))success
                        failure:(void (^)(NSString* errmsg))failure
{
    UserManager *user= [UserManager defaultManager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:user.userid?user.userid:@""  forKey:@"uid"];
    [dic setObject:gender?gender:@""            forKey:@"g_gender"];
    [dic setObject:question?question:@""        forKey:@"g_question"];
    [dic setObject:date?date:@""                forKey:@"g_date"];
    [dic setObject:gua?gua:@""                  forKey:@"g_gua"];
    
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/guaupload",
                    kHostName];
    if (!isloading2) {
        isloading2=true;
        [FetchBaseTask POST:api parameters:dic success:^(id obj) {
            isloading2=false;
            success(obj);
            
        } failure:^(NSString *errmsg) {
            isloading2=false;
            failure(errmsg);
        }];
    }
    else
    {
        DDLogError(@"loading... skip..");
    }
}

static bool isloading3=false;
+ (void)doRegistNewUserWithUsername:(NSString *)username PW:(NSString *)pw success:(void (^)(id))success failure:(void (^)(NSString* errmsg))failure
{
    if( username==nil || pw==nil)
        return;

    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/regist",
                    kHostName];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:username forKey:@"username"];
    [dic setObject:pw forKey:@"password"];
    
    if (!isloading3) {
        isloading3=true;
        [FetchBaseTask POST:api parameters:dic success:^(id obj) {
            isloading3=false;
            success(obj);
            
        } failure:^(NSString *errmsg) {
            isloading3=false;
            failure(errmsg);
        }];
    }
    else
    {
        DDLogError(@"loading... skip..");
    }
}

static bool isloading4=false;
+ (void)doLoginWithUsername:(NSString *)username PW:(NSString *)pw success:(void (^)(id))success failure:(void (^)( NSString* errmsg))failure
{
    if( username==nil || pw==nil)
    return;
    
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/login",
                    kHostName];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:username forKey:@"username"];
    [dic setObject:pw forKey:@"password"];
    
    if (!isloading4) {
        isloading4=true;
        [FetchBaseTask POST:api parameters:dic success:^(id obj) {
            isloading4=false;
            success(obj);
            
        } failure:^(NSString *errmsg) {
            isloading4=false;
            failure(errmsg);
        }];
    }
    else
    {
        DDLogError(@"loading... skip..");
    }
    
}

static bool isloading5=false;
+ (void)deleteGuaItemsWithId:(NSString *)gid success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if( gid==nil)
        return;
    
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/deleteguaitem",
                    kHostName];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:gid forKey:@"g_id"];
    
    if (!isloading5) {
        isloading5=true;
        [FetchBaseTask POST:api parameters:dic success:^(id obj) {
            isloading5=false;
            success(obj);
            
        } failure:^(NSString *errmsg) {
            isloading5=false;
            failure(errmsg);
        }];
    }
    else
    {
        DDLogError(@"loading... skip..");
    }

}

+ (void)doUploadErrorLogs:(NSString *)content
                  success:(void (^)(id))success
                  failure:(void (^)(NSString* errmsg))failure
{
    if( content==nil)
        return;
    
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/upload_client_errorlog",
                    kHostName];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:content forKey:@"content"];
    
    [FetchBaseTask POST:api parameters:dic success:^(id obj) {
        success(obj);
    } failure:^(NSString *errmsg) {
        failure(errmsg);
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
