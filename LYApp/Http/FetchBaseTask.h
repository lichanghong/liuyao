//
//  FetchBaseTask.h
//  LYApp
//
//  Created by lichanghong on 16/6/30.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchBaseTask : NSOperation

@property (nonatomic,strong) void (^success)(id json) ;
@property (nonatomic,strong) void (^failure)(NSError *error) ;
@property (nonatomic,strong) void (^skipped)() ;
@property (nonatomic,assign) BOOL isCanceled ;
@property (nonatomic,assign) BOOL bForceRefresh;

- (id)initWithSuccess:(void (^)(id json))success failure:(void (^)(NSError *))failure skipped:(void (^)())skipped force:(BOOL)bForceRefresh;



@end
