//
//  SuHttpRequest.h
//  testNet
//
//  Created by nwwl on 13-12-5.
//  Copyright (c) 2013年 nwwl. All rights reserved.
//

#import "SuRequest.h"

@interface SuHttpRequest : SuRequest

//post请求
- (void)requestPost:(NSString *)url                      //请求url
             params:(NSDictionary *)params               //参数
       onCompletion:(RequestCompletionBlocks)onCompletion
            onError:(RequestFailedBlocks)onError;


//post请求 带data
- (void)requestDataPost:(NSString *)url                     //请求url
                 params:(NSDictionary *)params               //参数
            fieldParams:(NSDictionary *)fieldParams          //图片参数
           onCompletion:(RequestCompletionBlocks)onCompletion
                onError:(RequestFailedBlocks)onError;

//post请求 带file
- (void)requestFilePost:(NSString *)url                  //请求url
                 params:(NSDictionary *)params               //参数
            fieldParams:(NSDictionary *)fieldParams          //图片参数
           onCompletion:(RequestCompletionBlocks)onCompletion
                onError:(RequestFailedBlocks)onError;


//get请求
- (void)requestGet:(NSString *)url                      //请求url
      onCompletion:(RequestCompletionBlocks)onCompletion
           onError:(RequestFailedBlocks)onError;

//get请求带参数
- (void)requestGet:(NSString *)url                      //请求url
             params:(NSDictionary *)params               //参数
       onCompletion:(RequestCompletionBlocks)onCompletion
            onError:(RequestFailedBlocks)onError;

@end
