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

+ (void)doGetGuaResultWithGid:(NSString *)gid success:(void (^)(id))success failure:(void (^)(NSString *))failure;

+ (void)doRegistNewUserWithUsername:(NSString *)username PW:(NSString *)pw
                            success:(void (^)(id json))success
                            failure:(void (^)(NSString*errmsg))failure;

+ (void)doLoginWithUsername:(NSString *)username PW:(NSString *)pw
                            success:(void (^)(id json))success
                            failure:(void (^)(NSString* errmsg))failure;


//上传起卦结果
+ (void)doUploadGuaWithQuestion:(NSString *)question
                     gua_gender:(NSString *)gender
                       gua_date:(NSString *)date
                        gua_gua:(NSString *)gua
                        success:(void (^)(id))success
                        failure:(void (^)(NSString* errmsg))failure;


/**
 获取数据
 type = 0默认 1个人历史 2study已解决  3 help resolv
 */
+ (void)doLoadGuaItemsWithType:(int)type Success:(void (^)(id))success failure:(void (^)(NSString *))failure;

// 删除个人的
+ (void)deleteGuaItemsWithId:(NSString *)gid  success:(void (^)(id))success
                     failure:(void (^)(NSString* errmsg))failure;


//上传日志
+ (void)doUploadErrorLogs:(NSString *)content
                        success:(void (^)(id))success
                        failure:(void (^)(NSString* errmsg))failure;


//上传解卦
+ (void)doCommitGuaDetail:(NSString *)detail name:(NSString *)name gid:(NSString *)gid success:(void (^)(id))success failure:(void (^)(NSString *))failure;





@end
