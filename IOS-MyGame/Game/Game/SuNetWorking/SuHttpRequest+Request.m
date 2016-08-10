//
//  SuHttpRequest+Request.m
//  Game
//
//  Created by sike on 16/8/1.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "SuHttpRequest+Request.h"

@implementation SuHttpRequest (Request)

//测试PHP的信息
-(void) userTestPhp:(NSString *)user
           password:(NSString *)password
       onCompletion:(RequestCompletionBlocks)onCompletion
            onError:(RequestFailedBlocks)onError{
    NSMutableString *contentJsonURL = [[NSMutableString alloc]initWithString:kWebSiteURL];
    [contentJsonURL appendFormat:@"query.php"];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:user forKey:@"username"];
    [dict setObject:password forKey:@"password"];
    

    [self requestGet:contentJsonURL
        onCompletion:^(id result) {
          onCompletion(result);
    } onError:^(NSError *error) {
        onError(error);
    }];
    
    
}








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
    
    NSLog(@"dict:%@",dict);
    
    //get请求
    [self requestGet:contentJsonURL
              params:dict
        onCompletion:^(id result) {
            onCompletion(result);
        } onError:^(NSError *error) {
            onError(error);
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
        } ];
    
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
    
    //get请求
    [self requestGet:contentJsonURL
              params:dict
        onCompletion:^(id result) {
            onCompletion(result);
        } onError:^(NSError *error) {
            onError(error);
        } ];
    
}

@end
