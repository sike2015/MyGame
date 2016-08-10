//
//  SuHttpRequest+Request.h
//  Game
//
//  Created by sike on 16/8/1.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "SuHttpRequest.h"

@interface SuHttpRequest (Request)
//测试PHP的信息
-(void) userTestPhp:(NSString *)user
           password:(NSString *)password
       onCompletion:(RequestCompletionBlocks)onCompletion
            onError:(RequestFailedBlocks)onError;


//插入php信息
- (void)insertPhp:(NSString *)name
            score:(NSString *)score
             type:(NSString *)type
             udid:(NSString *)udid
     onCompletion:(RequestCompletionBlocks)onCompletion
          onError:(RequestFailedBlocks)onError;


//读取php 信息
- (void)quertPhp:(NSString *)php
    onCompletion:(RequestCompletionBlocks)onCompletion
         onError:(RequestFailedBlocks)onError;

//更新php信息
- (void)update:(NSString *)score
          udid:(NSString *)udid
  onCompletion:(RequestCompletionBlocks)onCompletion
       onError:(RequestFailedBlocks)onError;
@end
