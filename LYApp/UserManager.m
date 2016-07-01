//
//  UserManager.m
//  LYApp
//
//  Created by lichanghong on 16/6/29.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userid forKey:kuserid];
    [aCoder encodeObject:self.username forKey:kusername];
    [aCoder encodeObject:self.gender forKey:kgender];
    [aCoder encodeObject:self.nickname forKey:knickname];
    [aCoder encodeObject:self.blocked forKey:kblocked];
    
}

+ (NSString *)savedFilePath
{
    // 获取文件路径
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *userFilePath      = [[documents firstObject] stringByAppendingPathComponent:@"UserManager"];
    return userFilePath;
}
+ (BOOL)archiveUserManager:(UserManager *)usermanager
{
   return [NSKeyedArchiver archiveRootObject:usermanager toFile:[UserManager savedFilePath]];
}

+ (UserManager *)unarchiveUserManager
{
    UserManager *manager = [NSKeyedUnarchiver unarchiveObjectWithFile:[UserManager savedFilePath]];
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
