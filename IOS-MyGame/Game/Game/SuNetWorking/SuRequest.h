//
//  SuRequest.h
//  Exhibition
//
//  Created by nwwl on 13-12-5.
//  Copyright (c) 2013年 nwwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLLConfig.h"

typedef void (^RequestCompletionBlocks)(id result);
typedef void (^RequestFailedBlocks)(NSError *error);


@interface SuRequest : NSObject{
    NSOperationQueue *OperationQueue;   //开启一个队列
}

//取消当前请求
- (void)cancelRequest;

//异步请求方式
- (void)startRequestMethod:(NSString *)url                      //请求url
                    params:(NSDictionary *)params               //参数
               fieldParams:(NSDictionary *)fieldParams          //文件参数
             requestMethod:(NSString *)method                   //请求方法
              onCompletion:(RequestCompletionBlocks)onCompletion
                   onError:(RequestFailedBlocks)onError;
@end
