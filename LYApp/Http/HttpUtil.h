//
//  HttpUtil.h
//  LYApp
//
//  Created by lichanghong on 16/6/30.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtil : NSObject


+ (instancetype)shareInstance;

+ ( NSURLSessionDataTask *)doGetGuaResultWithGid:(NSString *)gid success:(void (^)(id))success failure:(void (^)(NSString *))failure;

+ (NSURLSessionDataTask *)doRegistNewUserWithUsername:(NSString *)username PW:(NSString *)pw
                            success:(void (^)(id json))success
                            failure:(void (^)(NSString*errmsg))failure;

+ (NSURLSessionDataTask *)doLoginWithUsername:(NSString *)username PW:(NSString *)pw
                            success:(void (^)(id json))success
                            failure:(void (^)(NSString* errmsg))failure;
//上传起卦结果
+ (NSURLSessionDataTask *)doUploadGuaWithQuestion:(NSString *)question
                     gua_gender:(NSString *)gender
                       gua_date:(NSString *)date
                        gua_gua:(NSString *)gua
                        success:(void (^)(id))success
                        failure:(void (^)(NSString* errmsg))failure;

 
// 删除个人的
+ (NSURLSessionDataTask *)deleteGuaItemsWithId:(NSString *)gid  success:(void (^)(id))success
                     failure:(void (^)(NSString* errmsg))failure;

/**
 获取数据
 type = 0默认 1个人历史 2study已解决  3 help resolv
 */
+ (NSURLSessionDataTask *)doLoadGuaItemsWithType:(int)type Success:(void (^)(id))success failure:(void (^)(NSString *))failure;


//上传日志
+ (NSURLSessionDataTask*)doUploadErrorLogs:(NSString *)content
                        success:(void (^)(id))success
                        failure:(void (^)(NSString* errmsg))failure;


+ (NSURLSessionDataTask *)doCommitGuaDetail:(NSString *)detail name:(NSString *)name gid:(NSString *)gid success:(void (^)(id))success failure:(void (^)(NSString *))failure;

//更新登录时间
+ (void)doUpdateOnlineTime;



@end
