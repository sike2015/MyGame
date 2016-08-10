//
//  AFHttpRequest+Request.h
//  Game
//
//  Created by sike on 16/7/15.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "AFHttpRequest.h"

@interface AFHttpRequest (Request)


//插入php信息
- (void)insertPhp:(NSString *)name
            score:(NSString *)score
             type:(NSString *)type
             udid:(NSString *)udid
     onCompletion:(RequestCompletionBlocks)onCompletion
          onError:(RequestFailedBlocks)onError;


//更新php信息
- (void)update:(NSString *)score
          udid:(NSString *)udid
  onCompletion:(RequestCompletionBlocks)onCompletion
       onError:(RequestFailedBlocks)onError;

//读取php 信息
- (void)quertPhp:(NSString *)php
    onCompletion:(RequestCompletionBlocks)onCompletion
         onError:(RequestFailedBlocks)onError;


//插入更新php信息
- (void)insertUpdate:(NSString *)name
               score:(NSString *)score
                type:(NSString *)type
                udid:(NSString *)udid
        onCompletion:(RequestCompletionBlocks)onCompletion
             onError:(RequestFailedBlocks)onError;


//更新新的昵称
- (void)updateName:(NSString *)name
               score:(NSString *)score
                type:(NSString *)type
                udid:(NSString *)udid
        onCompletion:(RequestCompletionBlocks)onCompletion
             onError:(RequestFailedBlocks)onError;


@end
