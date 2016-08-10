//
//  AnimalViewController.m
//  Game
//
//  Created by sike on 16/7/11.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "AnimalViewController.h"
#import "UIColor+colorWithHexString.h"

@interface AnimalViewController(){
    
    UIImageView *animalImageView;  //动画View
    
}

@end

@implementation AnimalViewController


typedef void (^RequestCompletionBlocks)(bool result);

#define kSetTime 1.5
#define kScale 2

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#fdd100"];
    
    animalImageView = [[UIImageView alloc]initWithFrame:self.view.bounds ];
    animalImageView.image = [UIImage imageNamed:@"animal"];
    animalImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:animalImageView];
    
    
     __block typeof(self)bself = self;
    
    //开始执行第一个动画
    [self setAnimal:kSetTime
              scale:kScale
           setRect:CGRectMake(230, 0, 0,0)
       onCompletion:^(bool result) {
        
           
        __block typeof(self)sendSelf = bself;
           //开始执行第二个动画
           [bself setAnimal:kSetTime
                     scale:kScale
                  setRect:CGRectMake(10, 0, 0,0)
              onCompletion:^(bool result) {
                  //开始执行第三个动画
                  [sendSelf setAnimal:kSetTime
                             scale:kScale
                           setRect:CGRectMake(-200, 0, 0,0)
                      onCompletion:^(bool result) {
                          [[NSNotificationCenter defaultCenter]postNotificationName:@"disAnimalVC" object:nil ];
                      }];
              }];
           
    }];
    
    
}


//设置动画
- (void)setAnimal:(float)time           //时间
            scale:(float)scale          //缩放比例
         setRect:(CGRect)setRect        //中心点
     onCompletion:(RequestCompletionBlocks)onCompletion{
    
    
    [UIView animateWithDuration:time
                     animations:^{
                         
                         //移动位置
                         
                         
//  animalImageView.transform = CGAffineTransformTranslate(animalImageView.transform, setRect.origin.x, setRect.origin.y);

                         animalImageView.frame = CGRectMake(setRect.origin.x, setRect.origin.y, animalImageView.frame.size.width, animalImageView.frame.size.height);
                         
                         //放大倍数
                         CGAffineTransform scareAffineTransform =
                         CGAffineTransformScale(animalImageView.transform, scale, scale);
                         [animalImageView setTransform:scareAffineTransform];
                         
                         
                     } completion:^(BOOL finished) {
                         
                         
                         [UIView animateWithDuration:kSetTime
                                          animations:^{
                             
//                                animalImageView.transform = CGAffineTransformIdentity;
                                              
                                              
                                //还原为 初始状态
                                animalImageView.center = CGPointMake(self.view.center.x, self.view.center.y);
                                              
                                CGAffineTransform scareAffineTransform =  CGAffineTransformScale(animalImageView.transform, 0.5,  0.5);
                                [animalImageView setTransform:scareAffineTransform];
                                              
                                              
                         } completion:^(BOOL finished) {
                  
                             
                             onCompletion(finished);
                         }];
                         
             
                     }];
    
    
}










@end
