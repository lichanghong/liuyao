//
//  LYLocalUtil.m
//  LYApp
//
//  Created by lichanghong on 16/7/4.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYLocalUtil.h"

@implementation LYLocalUtil

- (void)encodeWithCoder:(NSCoder *)aCoder
{
//    [aCoder encodeObject:self.userid forKey:kuserid];
//    [aCoder encodeObject:self.username forKey:kusername];
//    [aCoder encodeObject:self.gender forKey:kgender];
//    [aCoder encodeObject:self.nickname forKey:knickname];
//    [aCoder encodeObject:self.blocked forKey:kblocked];
    
}

+ (BOOL)archiveArray:(NSArray *)arr withFileName:(NSString *)name
{
    return [NSKeyedArchiver archiveRootObject:arr toFile:[LYLocalUtil documentPathWithFile:name]];
}

+ (NSArray *)unarchiveArrayWithFileName:(NSString *)name
{
    NSArray *manager = [NSKeyedUnarchiver unarchiveObjectWithFile:[LYLocalUtil documentPathWithFile:name]];
    return manager;
}

+ (NSString *)historyVCDataFileName
{
    return @"fhlsafklahsllkklsjflsdkfklsf";
}

+ (NSString *)studyVCDataFileName
{
    return @"jlkasfjaslkfhlhashfdsssfdsfd";
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
//    self.userid = [aDecoder decodeObjectForKey:kuserid];
//    self.username = [aDecoder decodeObjectForKey:kusername];
//    self.gender = [aDecoder decodeObjectForKey:kgender];
//    self.nickname = [aDecoder decodeObjectForKey:knickname];
//    self.blocked = [aDecoder decodeObjectForKey:kblocked];
    return self;
}
+ (bool)clearData
{
    [UserManager clearData];
    NSError *err;
    NSError *err1;
    [[NSFileManager defaultManager]removeItemAtPath:[LYLocalUtil documentPathWithFile:[LYLocalUtil historyVCDataFileName]] error:&err];
    [[NSFileManager defaultManager]removeItemAtPath:[LYLocalUtil documentPathWithFile:[LYLocalUtil studyVCDataFileName]] error:&err1];
    if (err1 || err) {
        DDLogError(@"err=%@  --- err1=%@",err,err1);
        return false;
    }
    return YES;
}

+(instancetype)defaultUtil
{
    static LYLocalUtil *s_manager = nil;
    @synchronized (self) {
        if (s_manager) {
            return s_manager;
        }
        s_manager = [[LYLocalUtil alloc]init];
    }
    return s_manager;
}

+ (NSString *)documentPathWithFile:(NSString *)filename
{
    // 获取文件路径
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *userFilePath      = [[documents firstObject] stringByAppendingPathComponent:filename];
    return userFilePath;
}

@end
