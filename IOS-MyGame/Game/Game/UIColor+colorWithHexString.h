//
//  UIColor+colorWithHexString.h
//  Exhibition
//
//  Created by nwwl on 13-11-18.
//  Copyright (c) 2013年 nwwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (colorWithHexString)

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;  

@end
