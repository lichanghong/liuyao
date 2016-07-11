//
//  LYLocalUtil.h
//  LYApp
//
//  Created by lichanghong on 16/7/4.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYLocalUtil : NSObject

+ (BOOL)archiveArray:(NSArray *)arr withFileName:(NSString *)name;
+ (NSArray *)unarchiveArrayWithFileName:(NSString *)name;

+ (instancetype)defaultUtil;


+ (bool)clearData;
+ (NSString *)documentPathWithFile:(NSString *)filename;



+ (NSString *)historyVCDataFileName;

+ (NSString *)studyVCDataFileName;
+ (NSString *)helpVCDataFileName;

@end
