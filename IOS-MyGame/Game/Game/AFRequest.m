//
//  AFNetRequest.m
//  testNet
//
//  Created by nwwl on 13-11-25.
//  Copyright (c) 2013年 nwwl. All rights reserved.
//

#import "AFRequest.h"
#import "AFNetworking.h"


@interface AFRequest(){
    AFHTTPRequestOperationManager * manager;
}

@end

@implementation AFRequest


- (void)dealloc{
    //    DLog(@"dealloc AFRequest!");
}


//取消当前请求
- (void)cancelRequest{
    [[manager operationQueue]cancelAllOperations];  //取消请求
}

//异步请求方式
- (void)startRequestMethod:(NSString *)url                      //请求url
                    params:(NSDictionary *)params               //参数
               fieldParams:(NSDictionary *)fieldParams          //文件参数
             requestMethod:(NSString *)method                   //请求方法
              onCompletion:(RequestCompletionBlocks)onCompletion
                   onError:(RequestFailedBlocks)onError{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; //状态栏 网络图标开启
    manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.requestSerializer.timeoutInterval  = 10;  //超时时间 10秒钟
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",@"content-type:text/html",nil];
    

    
    

    // DLog(@"params:%@",params);
    if([method isEqualToString:kGET]){
        
        [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; //状态栏 网络图标关闭
            NSError *error = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:[[operation responseString] dataUsingEncoding:NSUnicodeStringEncoding] options:NSJSONReadingMutableLeaves error:&error];
            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                
                NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
                onCompletion(deserializedDictionary);
            } else if ([jsonObject isKindOfClass:[NSArray class]]){
                NSArray *deserializedArray = (NSArray *)jsonObject;
                onCompletion(deserializedArray);
            } else {
                NSLog(@"An error happened while deserializing the JSON data.");
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"error :%@",[error localizedDescription]);
            NSLog(@"usrinfo:%@",error.userInfo);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; //状态栏 网络图标关闭
            NSLog(@"错误编号：%zd",error.code);
            
    
            
            onError(error);
        }];
    }
    
}


@end
