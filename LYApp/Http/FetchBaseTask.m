//
//  FetchBaseTask.m
//  LYApp
//
//  Created by lichanghong on 16/6/30.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "FetchBaseTask.h"

@implementation FetchBaseTask

- (id)initWithSuccess:(void (^)(id json))success failure:(void (^)(NSError*))failure skipped:(void (^)())skipped force:(BOOL)bForceRefresh
{
    if (self = [super init]) {
        self.success = ^(id json){
            dispatch_async(dispatch_get_main_queue(), ^{
                success(json);
            });
        };
        self.failure = ^(NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        };
        self.skipped= ^(){
            dispatch_async(dispatch_get_main_queue(),^{
                skipped();
            });
        };
        self.isCanceled =false;
        self.bForceRefresh=bForceRefresh;
    }
    return self;
}




@end
