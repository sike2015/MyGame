//
//  NSString+Trimming.m
//  Clock
//
//  Created by 苏孝禹  on 12-8-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/** 去空格 */
- (NSString *)trim {
    
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}



//判断一个字符串是不是 整数 
- (BOOL)isPureInt:(NSString*)string{
    
    
    if([string rangeOfString:@"."].length>0){
        return NO;
    }else{
        return YES;
    }
}

@end
