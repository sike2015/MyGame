//
//  SuBaseObject.m
//  testProject
//
//  Created by sike on 16/5/27.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "SuBaseObject.h"
#import <objc/runtime.h>


@implementation SuBaseObject


+(id)suObjectWithKeyValues:(NSDictionary *)aDictionary{
    id objc = [[self alloc] init];
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount); //预先获取属性的数量
    
    for (unsigned int i = 0; i < outCount; ++i) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);           //获取当前属性的名称
        NSString *key = [NSString stringWithUTF8String:propertyName];   //转换为uft－8的名字
        id value = aDictionary[key];
        
        
        //如果Value  则设置为空字符串
        if (value == nil ||[value isEqual:[NSNull null]]) {
            value = @"";
        }
        
        //如果value 存在时
        if (value) {
            //进行setValue对象
            [objc setValue:value forKey:key];
        }
        
        
    }
    
    free(properties);
    
    
    
    return objc;
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int coutCount = 0;
    
    Ivar *vars = class_copyIvarList([self class], &coutCount); //1.使用 class_copyIvarList 方法获取当前 Model 的所有成员变量.
    
    for (unsigned i=0; i<coutCount; i++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);                   //得到当前的名称
        NSString *key = [NSString stringWithUTF8String:name];   //转换为uft－8的名字
        id value = [self valueForKey:key];                      //取到当前的value
        [aCoder encodeObject:value forKey:key];
        
        
    }
    
    
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        
        unsigned int outCount = 0;
        
        
        Ivar *ivars = class_copyIvarList([self class], &outCount);  //遍历得到当前所有对象
        
        
        for (unsigned i=0; i<outCount; i++) {
            Ivar ivar = ivars[i];                       //取出每一个动态对象
            
            const char *name = ivar_getName(ivar);      //获取当前的名称
            
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [self valueForKey:key];
            [self setValue:value forKey:key];
            
        }
        
        
        
        
        
        
    }
    
    return self;
}



@end
