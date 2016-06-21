//
//  UIColor+Hex.h
//  ChatClient
//
//  Created by  on 11-10-25.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/*
 * Convert a string of format #4172AC into a UIColor instance. Nil is return if the specified string
 * isn't in the correct format.
 */
+ (UIColor *)colorForHex:(NSString *)hexColor;
+ (UIColor *)colorForHex:(NSString *)hexColor alpha:(CGFloat)alpha;

@end
