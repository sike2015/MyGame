//
//  AFHttpRequest+Request.m
//  Game
//
//  Created by sike on 16/7/15.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "AFHttpRequest+Request.h"

@implementation AFHttpRequest (Request)


//插入php信息
- (void)insertPhp:(NSString *)name
            score:(NSString *)score
             type:(NSString *)type
             udid:(NSString *)udid
     onCompletion:(RequestCompletionBlocks)onCompletion
          onError:(RequestFailedBlocks)onError{
    
    NSMutableString *contentJsonURL = [[NSMutableString alloc]initWithString:kWebSiteURL];
    [contentJsonURL appendFormat:@"insert.php"];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    
    [dict setObject:name forKey:@"name"];
    [dict setObject:score forKey:@"score"];
    [dict setObject:type forKey:@"type"];
    [dict setObject:udid forKey:@"udid"];
    
//    NSLog(@"dict:%@",dict);
    
    //get请求
    [self requestGet:contentJsonURL
              params:dict
        onCompletion:^(id result) {
            onCompletion(result);
        } onError:^(NSError *error) {
            onError(error);
        }onProgress:^(double progress) {
            
        }];
    
}


//读取php信息
- (void)quertPhp:(NSString *)php
    onCompletion:(RequestCompletionBlocks)onCompletion
         onError:(RequestFailedBlocks)onError{
    
    NSMutableString *contentJsonURL = [[NSMutableString alloc]initWithString:kWebSiteURL];
    [contentJsonURL appendFormat:@"query.php"];
    
    //get请求
    [self requestGet:contentJsonURL
              params:nil
        onCompletion:^(id result) {
            onCompletion(result);
        } onError:^(NSError *error) {
            onError(error);
        } onProgress:^(double progress) {
            
        }];
    
}

//更新php信息
- (void)update:(NSString *)score
          udid:(NSString *)udid
  onCompletion:(RequestCompletionBlocks)onCompletion
       onError:(RequestFailedBlocks)onError{
    
    NSMutableString *contentJsonURL = [[NSMutableString alloc]initWithString:kWebSiteURL];
    [contentJsonURL appendFormat:@"update.php"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:score forKey:@"score"];
    [dict setObject:udid forKey:@"udid"];
    
    NSLog(@"dict:%@",dict);
    
    //get请求
    [self requestGet:contentJsonURL
              params:dict
        onCompletion:^(id result) {
            onCompletion(result);
        } onError:^(NSError *error) {
            onError(error);
        } onProgress:^(double progress) {
            
        }];
    
}


//插入或更新php信息
- (void)insertUpdate:(NSString *)name
               score:(NSString *)score
                type:(NSString *)type
                udid:(NSString *)udid
        onCompletion:(RequestCompletionBlocks)onCompletion
             onError:(RequestFailedBlocks)onError{
    
    
    NSMutableString *contentJsonURL = [[NSMutableString alloc]initWithString:kWebSiteURL];
    [contentJsonURL appendFormat:@"insertUpdate.php"];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:name forKey:@"name"];
    [dict setObject:score forKey:@"score"];
    [dict setObject:type forKey:@"type"];
    [dict setObject:udid forKey:@"udid"];
    
    //    NSLog(@"dict:%@",dict);
    
    //get请求
    [self requestGet:contentJsonURL
              params:dict
        onCompletion:^(id result) {
            onCompletion(result);
        } onError:^(NSError *error) {
            onError(error);
        }onProgress:^(double progress) {
            
        }];
}





//更新新的昵称
- (void)updateName:(NSString *)name
             score:(NSString *)score
              type:(NSString *)type
              udid:(NSString *)udid
      onCompletion:(RequestCompletionBlocks)onCompletion
           onError:(RequestFailedBlocks)onError{
    NSMutableString *contentJsonURL = [[NSMutableString alloc]initWithString:kWebSiteURL];
    [contentJsonURL appendFormat:@"updateName.php"];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:name forKey:@"name"];
    [dict setObject:score forKey:@"score"];
    [dict setObject:type forKey:@"type"];
    [dict setObject:udid forKey:@"udid"];
    
   // NSLog(@"dict:%@",dict);
    
    //get请求
    [self requestGet:contentJsonURL
              params:dict
        onCompletion:^(id result) {
            onCompletion(result);
        } onError:^(NSError *error) {
            onError(error);
        }onProgress:^(double progress) {
            
        }];
    
}

@end
