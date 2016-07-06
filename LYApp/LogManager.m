//
//  MSLogManager.m
//  MobiSentry
//
//  Created by MobiSentry on 8/18/14.
//  Copyright (c) 2014 MobiSentry. All rights reserved.
//

#import "LogManager.h"
#import "Http/HttpUtil.h"

@interface LogManager()
@property (nonatomic,strong)NSTimer *timer;

@end

#define UPLOADLOGS_DIR_NAME  @"uploadLogs"

@implementation LogManager

+ (instancetype)defaultManager
{
    static LogManager *s_manager = nil;
    if (s_manager == nil) {
        s_manager = [[LogManager alloc]init];
        [s_manager timer];
    }
    return s_manager;
}

- (NSTimer *)timer
{
    if (_timer == nil) {
        //每20分钟检查一次，是否距离上次成功上传时间超过24小时
        _timer = [NSTimer  scheduledTimerWithTimeInterval:60*20 target:self selector:@selector(checkUploadInterval:) userInfo:nil repeats:YES];
    }
    return _timer;
}

//日志上传成功之后，删除日志文件
- (void)deleteLoggersWhenPostSuccess:(NSString *)tempDir
{
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:tempDir error:&error];
    if (!success) {
        DDLogInfo(@"failed to delete log file..error = %@",error);
    }
    //if nil,had printed log,so don't need else statement..
}
 
- (NSString *)logContents
{
    //获得日志文件所有内容到contents
    NSMutableString *contents = nil;
    NSArray *logfilepathes = [self rawLogFilePaths];
    if (logfilepathes) {
        contents = [NSMutableString string];
        for (NSString *path in logfilepathes) {
            NSError *error = nil;
            NSString *fileContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            if (!error) {
                [contents appendString:fileContent];
            }
            else
            {
                DDLogInfo(@"read log content error = %@",error);
            }
        }
    }
    
    //如果只要消息日志
    NSArray *strArr = [contents componentsSeparatedByString:@"\n"];
    contents = [NSMutableString string];
    
    for (NSString *item in strArr) {
        NSString* item2 = [NSString stringWithFormat:@"%@\n",item];
        [contents appendString:item2];
    }
    return contents;
}

//获得日志文件路径
- (NSArray *)sortedLogFilePaths
{
    NSArray *loggers = [DDLog allLoggers];
    DDFileLogger *fileLogger = [[loggers lastObject] class] == [DDFileLogger class]?[loggers lastObject]:nil ;
    if (fileLogger !=nil ) {
        return fileLogger.logFileManager.unsortedLogFilePaths;
    }
    else
    {
        DDLogInfo(@"get log failed");
        return nil;
    }
}

- (void)doUploadLog:(NSString *)data withPath:tpath failed:(void (^)())failed
{
    [HttpUtil doUploadErrorLogs:data success:^(id result) {
        //                         //记录上传成功的时间，reason:需检测下次上传距离这次24小时
        [[NSUserDefaults standardUserDefaults] setObject:@([[NSDate date]timeIntervalSinceNow]) forKey:@"APP_LOG_UPLOAD_TIME"];
        [self deleteLoggersWhenPostSuccess:tpath];

    } failure:^(NSString *errmsg) {
        DDLogInfo(@"uploadLog error =%@",errmsg);
        failed();
    }];
}

//距离上次成功上传时间超过24小时
- (void)checkUploadInterval:(NSTimer *)timer
{
    //程序第一次执行，APP_LOG_UPLOAD_TIME初始化时间（当做已经上传一次日志）
    NSString *dateStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"APP_LOG_UPLOAD_TIME"]];
    if (dateStr) {
        //已经上传一次日志，距离24H开始再次上传
        if ([self isMorethan24HoursLogupload])
        {
            DDLogInfo(@"距离24H开始再次上传日志");
            //开始检测wifi上传
            [self uploadLog:NO];
        }
    }
    else
    {
        DDLogInfo(@"程序第一次启动，上传日志");
    }
}

//计算日志上传距离现在是否大于24小时
- (BOOL)isMorethan24HoursLogupload
{
    BOOL result = NO;
    NSString *dateStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"APP_LOG_UPLOAD_TIME"]];
    NSTimeInterval interval = [dateStr longLongValue];
    int days=((int)interval)/(3600*24);
    if (days >=1 ) {
        result = YES;
    }
    return result;
}

//是否无条件上传日志
- (void)uploadLog:(BOOL)bforceUpload
{
    void (^failed)()=^{
          DDLogInfo(@"someerroralksfjlsjflkajfadf");
    };
    //临时文件目录开始创建并移动日志文件到临时目录
    NSString *uploaddir = [self uploadDir];
    [self moveLogsToTempLogs:uploaddir];
    
    NSString *zipFilePath = [uploaddir stringByAppendingPathComponent:@"upload"];
    //如果临时目录不存在zip文件，创建 info.log文件
    BOOL isDirectory=NO;
    BOOL zipExists = [[NSFileManager defaultManager] fileExistsAtPath:zipFilePath isDirectory:&isDirectory];
    if (!zipExists) {
        //不存在zip文件，创建 info.log文件
        NSString *filePath = [uploaddir stringByAppendingPathComponent:@"info.log"];
#ifdef DEBUG
      NSString* debug=@"DEBUG";
#else
      NSString* debug=@"RELEASE";
#endif
        NSString *result = [NSString stringWithFormat:@"version: %@ %@\n",VERSION_STRING,debug];
        NSData *contents = [result dataUsingEncoding:NSUTF8StringEncoding];
        [[NSFileManager defaultManager]createFileAtPath:filePath contents:contents attributes:nil];
    }
    //没有压缩失败就读取zip数据上传
    NSString *data = [NSString stringWithContentsOfFile:zipFilePath usedEncoding:NSUTF8StringEncoding error:nil];
    
    if (!bforceUpload)
    {
        DDLogInfo(@"========================================upload log ===================%s",__func__);
        [self doUploadLog:data withPath:uploaddir failed:failed];
    }
    else
    {
        [self doUploadLog:data withPath:uploaddir failed:failed];
    }
}

//临时文件目录
- (NSString *)uploadDir
{
    //caches 路径,513 error ,permission deny
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *tempLog = [caches stringByAppendingPathComponent:UPLOADLOGS_DIR_NAME];
    
    //查看目录如果已经存在就直接返回路径，否则创建目录并返回路径，如果创建路径失败则返回nil
    if (![[NSFileManager defaultManager] fileExistsAtPath:tempLog isDirectory:nil])
    {
        NSError *createError = nil;
        BOOL createSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:tempLog withIntermediateDirectories:YES attributes:nil error:&createError];
        
        if (createSuccess) {
        }
        else
        {
            DDLogInfo(@"slfdlsfalf  = %@",createError);
            tempLog=nil;
        }
    }
    return tempLog;
}

- (void)moveLogsToTempLogs:(NSString *)tempLogFileDir
{
    if (tempLogFileDir != nil) {
        //log path
        NSArray *rawLogFilePaths = [self rawLogFilePaths];
        //traversal 原来的Logs文件夹下的log
        for (NSString *path in rawLogFilePaths) {
            //tempLogFile 全路径path
            NSString *tempLogFilePath = [tempLogFileDir stringByAppendingPathComponent:[[path componentsSeparatedByString:@"/"]lastObject]];
            NSError *moveError = nil;
            [[NSFileManager defaultManager]moveItemAtPath:path toPath:tempLogFilePath error:&moveError];
            if (moveError!=nil && [moveError code]!=0) {
                DDLogInfo(@"sklfjlsjflajff = %@",moveError);
            }
        }
    }
}

/**
 * @brief 获得日志文件路径
 */
- (NSArray *)rawLogFilePaths
{
    NSArray *loggers = [DDLog allLoggers];
    DDFileLogger *fileLogger = [[loggers lastObject] class] == [DDFileLogger class]?[loggers lastObject]:nil ;
    if (fileLogger !=nil ) {
        NSArray *result = fileLogger.logFileManager.unsortedLogFilePaths;
        return  result;
    }
    else
    {
        DDLogInfo(@"get log failed");
        return nil;
    }
}

//- (NSMutableArray *)tempLogFilePaths
//{
//    NSString *tempLogFileDir = [self uploadDir];
//    NSError *getcontentError = nil;
//    NSArray *result = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:tempLogFileDir error:&getcontentError];
//    if (getcontentError==nil || [getcontentError code]==0)
//    {
//        NSMutableArray *resultArr = [NSMutableArray array];
//        for (NSString *path in result) {
//            if ([path hasSuffix:@".log"]) {
//                NSString *resultpath = [tempLogFileDir stringByAppendingPathComponent:path];
//                [resultArr addObject:resultpath];
//            }
//        }
//        return resultArr;
//    }
//    else
//    {
//        DDLogInfo(@"getcontenterror..sjalfjaslkfjaf");
//        return nil;
//    }
//}

@end
