//
//  AppDelegate.m
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "AppDelegate.h"
#import "UserManager.h"
#import <JSPatch/JSPatch.h>
#import "LogManager.h"
#import "HttpUtil.h"

@interface AppDelegate ()

@end

@interface LogFileFormatter : NSObject <DDLogFormatter>
{
    NSDateFormatter *dateFormatter;
}
- (id)init;
- (instancetype)initWithDateFormatter:(NSDateFormatter *)dateFormatter;

@end

@implementation LogFileFormatter

- (id)init
{
    return [self initWithDateFormatter:nil];
}

- (instancetype)initWithDateFormatter:(NSDateFormatter *)aDateFormatter
{
    if ((self = [super init]))
    {
        
        if (aDateFormatter)
        {
            dateFormatter = aDateFormatter;
        }
        else
        {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4]; // 10.4+ style
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
        }
    }
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *dateAndTime = [dateFormatter stringFromDate:(logMessage->_timestamp)];
    return [NSString stringWithFormat:@"%@ : %@", dateAndTime, logMessage->_message];
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [JSPatch startWithAppKey:@"f7a5f0d7916932c1"];
//    [JSPatch sync];
    
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    [LogManager defaultManager];
    [UserManager defaultManager];
    
#ifdef DEBUG
    [DDLog addLogger:[DDASLLogger sharedInstance]];
#endif //
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance]setColorsEnabled:YES];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFormatter=[[LogFileFormatter alloc] init];
    fileLogger.logFileManager.maximumNumberOfLogFiles = 5;
    [DDLog addLogger:fileLogger];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [HttpUtil shareInstance];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    [JSPatch sync];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
