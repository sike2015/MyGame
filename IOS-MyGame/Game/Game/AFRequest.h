//
//  AFRequest.h
//  Game
//
//  Created by sike on 16/3/23.
//  Copyright © 2016年 sike. All rights reserved.
//
#import "BLLConfig.h"
#import <Foundation/Foundation.h>


typedef void (^RequestCompletionBlocks)(id result);
typedef void (^RequestFailedBlocks)(NSError *error);
typedef void (^RequestProgress)(double progress);


@interface AFRequest : NSObject
//异步请求方式
- (void)startRequestMethod:(NSString *)url                      //请求url
                    params:(NSDictionary *)params               //参数
               fieldParams:(NSDictionary *)fieldParams          //文件参数
             requestMethod:(NSString *)method                   //请求方法
              onCompletion:(RequestCompletionBlocks)onCompletion
                   onError:(RequestFailedBlocks)onError;
//取消当前请求
- (void)cancelRequest;
@end
