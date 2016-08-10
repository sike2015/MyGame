//
//  NSString+Trimming.h
//  Clock
//
//  Created by 苏孝禹 on 12-8-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/** 去空格 */
- (NSString *) trim;



//判断一个字符串是不是 整数
- (BOOL)isPureInt:(NSString*)string;
@end
