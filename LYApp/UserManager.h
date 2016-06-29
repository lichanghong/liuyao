//
//  UserManager.h
//  LYApp
//
//  Created by lichanghong on 16/6/29.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

@property (nonatomic,strong)NSString *userid;
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *gender;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *blocked;





+ (instancetype)defaultManager;


@end
