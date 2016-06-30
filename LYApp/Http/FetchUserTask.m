//
//  FetchUserTask.m
//  LYApp
//
//  Created by lichanghong on 16/6/30.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "FetchUserTask.h"
 

@implementation FetchUserTask

#define QUERY_INTERVAL 3

static long sLastRequestTime=0;
- (void)main {
    @autoreleasepool {
//        @try {
//            static id lastJson=nil;
//            if ([self isCanceled] == FALSE) {
//                if(time(NULL) - sLastRequestTime > QUERY_INTERVAL )
//                {
//                    sLastRequestTime = time(NULL);
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                        
//                        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//                        
//                        NSString* api=[[NSString alloc] initWithFormat:@"https://%@/admin.php/admin/user/login", kHostName];
//                        //  DDLogInfo(@"%s:%@",__FUNCTION__,api);
//                        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:api]];
//                        
//                        [request setHTTPMethod:@"POST"];
//                        [request setValue:@"application/x-protobuf" forHTTPHeaderField:@"Content-type"];
//                        
//                        string msg;
//                        if(req.SerializeToString(&msg))
//                        {
//                            NSData * data=[NSData dataWithBytes:msg.c_str() length:msg.length()];
//                            [request setHTTPBody:data];
//                            
//                            AFJSONRequestOperation *operation =
//                            [AFJSONRequestOperation JSONRequestOperationWithRequest:request
//                                                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                                                                                if ([JSON isKindOfClass:[NSDictionary class]]) {
//                                                                                    NSDictionary * obj=(NSDictionary *)JSON;
//                                                                                    if(obj[@"errno"]!=nil )
//                                                                                    {
//                                                                                        if([obj[@"errno"] intValue]==0)
//                                                                                        {
//                                                                                            //                                                            DDLogInfo(@"%s: success: %@",__FUNCTION__,obj[@"data"]);
//                                                                                            success(obj[@"data"]);
//                                                                                        }
//                                                                                        else
//                                                                                        {
//                                                                                            DDLogInfo(@"%s: failed: %d",__FUNCTION__, [obj[@"errno"] intValue]);
//                                                                                            failure([obj[@"errno"] intValue], obj[@"errorMessage"]);
//                                                                                        }
//                                                                                    }
//                                                                                    else
//                                                                                        failure(-1, @"format error");
//                                                                                }
//                                                                                else
//                                                                                    failure(-1, @"format error");
//                                                                            }
//                                                                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                                                                                DDLogInfo(@"%s: Failure: %@",__FUNCTION__, error);
//                                                                                failure(error.code,@"http error");
//                                                                            }];
//                            
//                            [MobiProtocol setPinMode:operation];
//                            [operation start];
//                        }
//                        else
//                        {
//                            DDLogInfo(@"%s why? adfli28890",__FUNCTION__);
//                        }
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//                        /////////////////////////////////////////////
//                        [[MobiProtocol mssharedInstance] doGetAppList:^(id json){
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                lastJson=json;
//                                self.success(json);
//                            });
//                        }
//                                                            msfailure:^(long errorCode, NSString*em){
//                                                                if(errorCode==0)
//                                                                {
//                                                                    sLastRequestTime = time(NULL)-QUERY_INTERVAL+3; //允许3秒后重试
//                                                                }
//                                                                else{
//                                                                    sLastRequestTime = time(NULL)-QUERY_INTERVAL+10;//允许10秒后重试
//                                                                }
//                                                                dispatch_async(dispatch_get_main_queue(), ^{
//                                                                    self.failure(errorCode,em);
//                                                                });
//                                                            }];
//                    });
//                } else {
//                    if(lastJson!=nil)
//                    {
//                        self.success(lastJson);
//                    }
//                    else
//                        self.skipped();
//                }
//            }
//        }@catch (NSException *e) {
//            NSLog(@"why? asdfafasfddsf  exception: %@", e);
//        }@finally {
//            
//        }
    }
}

@end
