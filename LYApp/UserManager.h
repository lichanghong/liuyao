//
//  UserManager.h
//  LYApp
//
//  Created by lichanghong on 16/6/29.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kuserid  = @"userid";
static NSString *kusername = @"username";
static NSString *kgender     = @"gender";
static NSString *knickname      = @"nickname";
static NSString *kblocked      = @"blocked";

@interface UserManager : NSObject <NSCoding>

@property (nonatomic,strong)NSString *userid;
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *gender;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *blocked;



+ (BOOL)archiveUserManager:(UserManager *)usermanager;
+ (UserManager *)unarchiveUserManager;

+ (instancetype)defaultManager;


@end
