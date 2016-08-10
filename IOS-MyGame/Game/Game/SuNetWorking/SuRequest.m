//
//  SuRequest.m
//  Exhibition
//
//  Created by nwwl on 13-12-5.
//  Copyright (c) 2013年 nwwl. All rights reserved.
//

#import "SuRequest.h"
#import "NSString+extension.h"

@interface SuRequest()


@end

@implementation SuRequest


- (void)dealloc{
    NSLog(@"释放suRequest了！");
    [self cancelRequest]; //取消网络连接
}

//取消当前请求
- (void)cancelRequest{    
    [OperationQueue cancelAllOperations];
    [OperationQueue waitUntilAllOperationsAreFinished];
    
}


#define kSuccess 200

//初始化
- (id)init
{
    if (self = [super init]) {
        OperationQueue = [[NSOperationQueue alloc]init ];
    }
    return self;
}

//异步请求方式
- (void)startRequestMethod:(NSString *)url                      //请求url
                    params:(NSDictionary *)params               //参数
               fieldParams:(NSDictionary *)fieldParams          //文件参数
             requestMethod:(NSString *)method                   //请求方法
              onCompletion:(RequestCompletionBlocks)onCompletion
                   onError:(RequestFailedBlocks)onError{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:60.0f];
    [request setHTTPMethod:method];                     //设定访问方式 POST GET...
    NSMutableData *postData = [NSMutableData data];     //初始化Data

    //拼接字符串
    for (NSString *key in [params allKeys]) {
        if([key isEqualToString:[[params allKeys] lastObject]])
        {
            [postData appendData:[[NSString stringWithFormat:@"%@=%@",key, [params objectForKey:key]]
                                  dataUsingEncoding:NSUTF8StringEncoding]];
        }else{
            [postData appendData:[[NSString stringWithFormat:@"%@=%@&&",key, [params objectForKey:key]]
                                  dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    
    [request setHTTPBody:postData]; //发送的数据
    
    

    
    //开始异步请求
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:OperationQueue
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {

                               NSHTTPURLResponse* urlResponse = (NSHTTPURLResponse*)response;

                               if (urlResponse.statusCode == kSuccess &&[data length] > 0 && connectionError == nil) {
                                   NSData *getData =data; //解压缩
                                   NSString *requestStr = [[NSString alloc] initWithData:getData encoding:NSUTF8StringEncoding];
                                   NSError *error = nil;
                                   
                                   
                                   id jsonObject = [NSJSONSerialization JSONObjectWithData:[requestStr dataUsingEncoding:NSUnicodeStringEncoding] options:NSJSONReadingMutableLeaves error:&error];
                                   
                                   
                                   
                                   if ([jsonObject isKindOfClass:[NSDictionary class]]){
                                       
                                       NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
                                       onCompletion(deserializedDictionary);
                                   } else if ([jsonObject isKindOfClass:[NSArray class]]){
                                       NSArray *deserializedArray = (NSArray *)jsonObject;
                                       onCompletion(deserializedArray);
                                   } else {
                                       NSLog(@"An error happened while deserializing the JSON data.");
                                       onCompletion(getData);
                                   }
                               }else if ([data length] == 0 && connectionError ==nil){
                                   //没有数据
                                   onError(connectionError);
                               }else if (connectionError != nil){
                                   //超时
                                   onError(connectionError);
                               }else{
                                   onError(connectionError);
                               }
           
                    
    }];
    
}


@end
