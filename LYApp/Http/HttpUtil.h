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

+ (void)doRegistNewUserWithUsername:(NSString *)username PW:(NSString *)pw
                            success:(void (^)(id json))success
                            failure:(void (^)(NSError*))failure;

-(void)doGetMessage:(void (^)())success
          msfailure:(void (^)(long, NSString*))failure;

+(void)doGetMsgDetails:(int)msgid
              mssecret:(NSString*)secret
             mssuccess:(void (^)(id json))success
             msfailure:(void (^)(long, NSString*))failure;

+(void)doGetAllMsgDetails:(NSString*)bxuuid
                mssuccess:(void (^)(id json))success
                msfailure:(void (^)(long, NSString*))failure;
















@end
