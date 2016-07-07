//
//  UserManager.m
//  LYApp
//
//  Created by lichanghong on 16/6/29.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "UserManager.h"
#import "LYLocalUtil.h"

@implementation UserManager


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userid forKey:kuserid];
    [aCoder encodeObject:self.username forKey:kusername];
    [aCoder encodeObject:self.gender forKey:kgender];
    [aCoder encodeObject:self.nickname forKey:knickname];
    [aCoder encodeObject:self.blocked forKey:kblocked];
    
}

+ (BOOL)archiveUserManager:(UserManager *)usermanager
{
   return [NSKeyedArchiver archiveRootObject:usermanager toFile:[LYLocalUtil documentPathWithFile:@"UserManager"]];
}

+ (UserManager *)unarchiveUserManager
{
    UserManager *manager = [NSKeyedUnarchiver unarchiveObjectWithFile:[LYLocalUtil documentPathWithFile:@"UserManager"]];
    return manager;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.userid = [aDecoder decodeObjectForKey:kuserid];
    self.username = [aDecoder decodeObjectForKey:kusername];
    self.gender = [aDecoder decodeObjectForKey:kgender];
    self.nickname = [aDecoder decodeObjectForKey:knickname];
    self.blocked = [aDecoder decodeObjectForKey:kblocked];
    return self;
}
+ (bool)clearData
{
    UserManager *manager= [UserManager defaultManager];
    manager.userid = nil;
    manager.username = nil;
    manager.gender = nil;
    manager.nickname = nil;
    manager.blocked = nil;
    NSError *err;
    [[NSFileManager defaultManager]removeItemAtPath:[LYLocalUtil documentPathWithFile:@"UserManager"] error:&err];
    if (err) {
        DDLogError(@"cleardata error %@",err);
        return NO;
    }
    return YES;
}

+(instancetype)defaultManager
{
    static UserManager *s_manager = nil;
    @synchronized (self) {
        if (s_manager) {
            return s_manager;
        }
        UserManager *manager =[UserManager unarchiveUserManager];
        s_manager = manager?manager:[[UserManager alloc]init];
    }
    return s_manager;
}

@end
