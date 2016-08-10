//
//  AFHttpRequest.h
//  Game
//
//  Created by sike on 16/3/23.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "AFRequest.h"

@interface AFHttpRequest : AFRequest
//get请求
- (void)requestGet:(NSString *)url                      //请求url
            params:(NSDictionary *)params               //参数
      onCompletion:(RequestCompletionBlocks)onCompletion
           onError:(RequestFailedBlocks)onError
        onProgress:(RequestProgress)onProgress;



//post请求
- (void)requestPost:(NSString *)url                      //请求url
             params:(NSDictionary *)params               //参数
       onCompletion:(RequestCompletionBlocks)onCompletion
            onError:(RequestFailedBlocks)onError
         onProgress:(RequestProgress)onProgress;
@end
