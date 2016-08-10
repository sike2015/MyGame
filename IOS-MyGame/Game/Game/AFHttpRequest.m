//
//  AFHttpRequest.m
//  Game
//
//  Created by sike on 16/3/23.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "AFHttpRequest.h"

@implementation AFHttpRequest


//get请求
- (void)requestGet:(NSString *)url                      //请求url
            params:(NSDictionary *)params               //参数
      onCompletion:(RequestCompletionBlocks)onCompletion
           onError:(RequestFailedBlocks)onError
        onProgress:(RequestProgress)onProgress{
    
    
    [self startRequestMethod:url
                      params:params
                 fieldParams:nil
               requestMethod:kGET
                onCompletion:^(id result) {
                    onCompletion(result);
                } onError:^(NSError *error) {
                    onError(error);
                }];
}



//post请求
- (void)requestPost:(NSString *)url                      //请求url
             params:(NSDictionary *)params               //参数
       onCompletion:(RequestCompletionBlocks)onCompletion
            onError:(RequestFailedBlocks)onError
         onProgress:(RequestProgress)onProgress{
    
    
    [self startRequestMethod:url
                      params:params
                 fieldParams:nil
               requestMethod:kPOST onCompletion:^(id result) {
                   onCompletion(result);
               } onError:^(NSError *error) {
                   onError(error);
               }];
}
@end
