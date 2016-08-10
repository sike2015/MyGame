//
//  Utils.m
//  Men-iPad
//
//  Created by 苏孝禹 on 11/24/11.
//  Copyright 2011 Yunhe Shi. All rights reserved.
//

#import "Utils.h"
#import  <ifaddrs.h>
#import <arpa/inet.h>

@implementation Utils




+ (NSString *)applicationDocumentsDirectory:(NSString *)filename
{
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
														 NSUserDomainMask,
														 YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	NSString *appendPath = filename;
    return [basePath stringByAppendingPathComponent:appendPath];
}

+(NSString *)applicationCachesDirectory:(NSString *)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
														 NSUserDomainMask,
														 YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return [basePath stringByAppendingPathComponent:filename];
}

#pragma mark -
#pragma mark Bookmark load ans save
+(id)loadDataFrom:(NSString *)filename
{
	NSString *filePath = [Utils applicationDocumentsDirectory:filename];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
	{
		NSData *data = [[NSMutableData alloc]
						initWithContentsOfFile:filePath];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
										 initForReadingWithData:data];
		id result = [unarchiver decodeObjectForKey:@"data"];
		[unarchiver finishDecoding];
		return result;
	}
	else
	{
		return nil;
	}
}

+(void)saveData:(id)dataToSave to:(NSString *)filename
{
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
								 initForWritingWithMutableData:data];
	[archiver encodeObject:dataToSave forKey:@"data"];
	[archiver finishEncoding];
	NSString *filePath = [Utils applicationDocumentsDirectory:filename];
	//NSLog(@"save filePath: %@", filePath);
	[data writeToFile:filePath atomically:YES];
    
}
//删除文件
+ (void)removeData:(NSString *)filename{
    NSString *filePath = [Utils applicationCachesDirectory:filename];
    //NSLog(@"filePath: %@", filePath);
    NSFileManager *defaultManager;
    defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:filePath error:nil];
}





// Get IP Address
+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}


//得到当前的时间
+(NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}


+ (BOOL)validateEmail:(NSString *)emailAddress {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailAddress];
}

+ (BOOL)validatePhone:(NSString *)phoneNumber
{
    if (phoneNumber.length == 11 && [[phoneNumber substringToIndex:1] isEqualToString:@"1"])
    {
        //  NSLog(@"[[phoneNumber substringToIndex:2] intValue] : %d",[[phoneNumber substringWithRange:NSMakeRange(1, 1)] intValue]);
        
        if ([[phoneNumber substringWithRange:NSMakeRange(1, 1)] intValue] >2) {  //第二位数字 应该大于2
            return YES;
        }else{
            return NO;
        }
    }
    else{
        return NO;
    }
}

+ (BOOL)validatePassword:(NSString *)password
{
    NSString *passwordRegex = @"^(?=(((.*)[0-9]+(.*)[a-zA-z]+(.*))|((.*)[a-zA-z]+(.*)[0-9]+(.*)))$)[0-9A-Za-z~!@#$%^&*()_+-=]{6,15}$";
    
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}





//yes 到正序 no为倒叙
+ (NSArray *)sortArray:(NSArray *)dataArray withKey:(NSString *)key ascending:(BOOL)ascending{
    if (!dataArray || !key) {
        return nil;
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending] ;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:dataArray] ;
    
    return [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}


//清空硬盘所有存储数据
+(void)clearDiskData {
    NSString *imageFilePath = [Utils applicationCachesDirectory:@"image"];
    NSString *userFilePath = [Utils applicationCachesDirectory:@"user"];
    NSString *saveDataFilePath = [Utils applicationCachesDirectory:@"saveData"];
    [[NSFileManager defaultManager] removeItemAtPath:imageFilePath error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:userFilePath error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:saveDataFilePath error:nil];
}




@end
