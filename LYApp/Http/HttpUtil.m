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
#import "EncryptUtils.h"

@implementation HttpUtil


+ (void)doGetGuaResultWithGid:(NSString *)gid success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/guaresult",
                    kHostName];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:gid?gid:@""            forKey:@"gid"];
    
    [FetchBaseTask POST:api parameters:dic success:^(id obj) {
        success(obj);
    } failure:^(NSString *errmsg) {
        failure(errmsg);
    }];
}

+ (void)doCommitGuaDetail:(NSString *)detail name:(NSString *)name gid:(NSString *)gid success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/commitguaresult",
                    kHostName];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:name?name:@""            forKey:@"name"];
    [dic setObject:detail?detail:@""        forKey:@"detail"];
    [dic setObject:[UserManager defaultManager].userid        forKey:@"uid"];
    [dic setObject:gid?gid:@""        forKey:@"gid"];
    [dic setObject:@(1)       forKey:@"isteacher"];
    
    [FetchBaseTask POST:api parameters:dic success:^(id obj) {
        success(obj);
    } failure:^(NSString *errmsg) {
        failure(errmsg);
    }];
}

+ (void)doLoadGuaItemsWithType:(int)type Success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/getguaitem",
                    kHostName];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(type)?@(type):@"0"  forKey:@"type"];
    if (type==1) {
        NSString *uid = [UserManager defaultManager].userid;
        [dic setObject:uid?uid:@""  forKey:@"uid"];
    }
    
    [FetchBaseTask POST:api parameters:dic success:^(id obj) {
        success(obj);
        
    } failure:^(NSString *errmsg) {
        failure(errmsg);
    }];
}

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
        [FetchBaseTask POST:api parameters:dic success:^(id obj) {
            success(obj);
            
        } failure:^(NSString *errmsg) {
            failure(errmsg);
        }];
}

+ (void)doRegistNewUserWithUsername:(NSString *)username PW:(NSString *)pw success:(void (^)(id))success failure:(void (^)(NSString* errmsg))failure
{
    if( username==nil || pw==nil)
        return;

    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/regist",
                    kHostName];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:username forKey:@"username"];
    [dic setObject:[EncryptUtils md5:pw] forKey:@"password"];

        [FetchBaseTask POST:api parameters:dic success:^(id obj) {
            success(obj);
            
        } failure:^(NSString *errmsg) {
            failure(errmsg);
        }];
}

+ (void)doLoginWithUsername:(NSString *)username PW:(NSString *)pw success:(void (^)(id))success failure:(void (^)( NSString* errmsg))failure
{
    if( username==nil || pw==nil)
    return;
    
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/login",
                    kHostName];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:username forKey:@"username"];
    [dic setObject:[EncryptUtils md5:pw] forKey:@"password"];
//    客户端根据相同规则计算，random传过去
        [FetchBaseTask POST:api parameters:dic success:^(id obj) {
            success(obj);
            
        } failure:^(NSString *errmsg) {
            failure(errmsg);
        }];
}

+ (void)deleteGuaItemsWithId:(NSString *)gid success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    if( gid==nil)
        return;
    
    NSString * api=[[NSString alloc] initWithFormat:@"%@/admin.php/user/deleteguaitem",
                    kHostName];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:gid forKey:@"g_id"];
    
        [FetchBaseTask POST:api parameters:dic success:^(id obj) {
            success(obj);
            
        } failure:^(NSString *errmsg) {
            failure(errmsg);
        }];
}

+ (void)doUploadErrorLogs:(NSString *)content
                  success:(void (^)(id))success
                  failure:(void (^)(NSString* errmsg))failure
{
    if( content==nil)
    {
        DDLogError(@"log content=nil");
        return;
    }
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
