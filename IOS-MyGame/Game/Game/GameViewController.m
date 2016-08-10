//
//  GameViewController.m
//  Game
//
//  Created by sike on 16/3/8.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "GameViewController.h"
#import "UIView+Helper.h"
#import "SoundManager.h"
#import "SCLAlertView.h"
#import "GameConfig.h"
#import "Utils.h"
#import "AFHttpRequest+Request.h"
#import "MBProgressHUD.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

#import <ShareSDKExtension/ShareSDK+Extension.h>

@interface GameViewController()<UIAlertViewDelegate>
@property (strong, nonatomic) UIView *startPillar;
@property (strong, nonatomic) UIView *endPillar;
@property (strong, nonatomic) UIView *board;
@property (strong, nonatomic) UIImageView *sprite;

@property (strong, nonatomic) UILabel *level;
@property (assign, nonatomic) NSUInteger levelCount;

@property (assign, nonatomic) CGFloat distance;
@property (assign, nonatomic) BOOL boardUpdated;

@property (strong, nonatomic) UILongPressGestureRecognizer *lpgr;
@end

@implementation GameViewController


#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

static CGFloat const kPillarHeight = 200;
static CGFloat const kPillarMaxWidth = 100;   //最大宽度
static CGFloat const kPillarMinWidth = 10;    //最小宽度

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.startPillar = [self randomPillar];  //创建开始半圆
    self.endPillar = [self randomPillar];    //创建结束半圆
    
    self.startPillar.width = kPillarMaxWidth;   //开始半径宽度为200
    self.endPillar.width = 80;                  //结束半径宽度为80
    
    self.distance = [self randomDistance];    //抵达距离
    self.endPillar.left = self.startPillar.right+self.distance;
    [self.view addSubview:self.startPillar];
    [self.view addSubview:self.endPillar];
    [self.view addSubview:self.sprite];
    [self.view addSubview:self.level];
    [self updateLevel];  //更新等级
    [self randomMusic];  //随机音乐 
    
    //增加手势事件
    self.lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    self.lpgr.minimumPressDuration = 0.1;
    [self.view addGestureRecognizer:self.lpgr];
    
    

    
}

//播放随机音乐
- (void)randomMusic {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud boolForKey:@"com.running.musicState"]) {
        NSUInteger musicIndex = arc4random() % 3;
        NSString *music = musicIndex == 0 ? @"background.mp3" : [NSString stringWithFormat:@"background%lu", (unsigned long)musicIndex];
        [[SoundManager sharedManager] playMusic:music looping:YES];
    }
}

//重新开始
- (void)again {
    [self.startPillar removeFromSuperview];
    [self.endPillar removeFromSuperview];
    [self.sprite removeFromSuperview];
    [self.board removeFromSuperview];
    
    _sprite = nil;
    _board = nil;
    
    self.levelCount = 0;
    
    self.startPillar = [self randomPillar];
    self.endPillar = [self randomPillar];
    
    self.startPillar.width = kPillarMaxWidth;
    self.endPillar.width = 80;
    
    self.distance = [self randomDistance];
    self.endPillar.left = self.startPillar.right+self.distance;
    [self.view addSubview:self.startPillar];
    [self.view addSubview:self.endPillar];
    [self.view addSubview:self.sprite];
    
    [self updateLevel];
    [self randomMusic];
    [self.view addGestureRecognizer:self.lpgr];
}

- (void)updateLevel {
    self.level.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.levelCount];
}

- (void)changeBoard {     //改变手中的Board
    if (self.boardUpdated) {
        self.board.top -= 1;
        self.board.height += 1;
        [self performSelector:@selector(changeBoard) withObject:nil afterDelay:0.005];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)lpgr {
    if (lpgr.state == UIGestureRecognizerStateBegan) {
        if (self.board) {
            [self.board removeFromSuperview];
            _board = nil;
        }
        
        self.board.left = self.startPillar.right;
        self.board.top = self.startPillar.top;
        self.board.height = 0;
        [self.view addSubview:self.board];
        
        self.boardUpdated = YES;
        [self changeBoard];
        
    } else if (lpgr.state == UIGestureRecognizerStateChanged) {
        
        
    } else if (lpgr.state == UIGestureRecognizerStateEnded) {
        self.boardUpdated = NO;
        [self.view removeGestureRecognizer:self.lpgr];
        [UIView animateWithDuration: 0.5f
                              delay: 0.0f
                            options: UIViewAnimationOptionCurveEaseIn
                         animations: ^{
                             self.board.transform = CGAffineTransformRotate(self.board.transform, M_PI/2);
                         }
                         completion: ^(BOOL finished) {
                             [self.sprite startAnimating];
                             [self spriteMove];
                         }];
    }
}

//人物移动
- (void)spriteMove {
    if (self.sprite.centerX < self.board.right) {
        self.sprite.centerX++;
        [self performSelector:@selector(spriteMove) withObject:nil afterDelay:0.002];
    } else {
        [self.sprite stopAnimating];
        if (self.board.right < self.endPillar.left || self.board.right > self.endPillar.right) {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            if (![ud boolForKey:@"com.tianping.running"]) {
                [[SoundManager sharedManager] playSound:@"ouch.wav" looping:NO];
            };
            [self spriteCrash];
        } else {
            [self next];
        }
    }
}

- (void)spriteCrash {
    if (self.sprite.top <= ScreenHeight) {
        self.sprite.top++;
        [self performSelector:@selector(spriteCrash) withObject:nil afterDelay:0.002];
    } else {
        [self gameOver];
    }
}

- (void)next {
    [self.view removeGestureRecognizer:self.lpgr];
    
    UIView *newPillar = [self randomPillar];
    newPillar.left = ScreenWidth;
    [self.view addSubview:newPillar];
    
    CGFloat lastDistance = self.distance;
    self.distance = [self randomDistance];
    
    [UIView animateWithDuration:.5f
                     animations:^{
                         self.startPillar.right = 0;
                         self.endPillar.right = kPillarMaxWidth;
                         self.board.centerX -= lastDistance + self.endPillar.width;
                         
                         self.sprite.left -= lastDistance + self.endPillar.width;
                         newPillar.left = kPillarMaxWidth + self.distance;
                     } completion:^(BOOL finished) {
                         self.startPillar = self.endPillar;
                         self.endPillar = newPillar;
                         self.levelCount++;
                         [self updateLevel];
                         [self.view addGestureRecognizer:self.lpgr];
                     }];
}

- (void)gameOver {
    
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    //Using Selector
    [alert addButton:@"再来一次" actionBlock:^(void) {
        [self again];
    }];
    
    //Using Block
    [alert addButton:@"返回" actionBlock:^(void) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addButton:@"微信分享" actionBlock:^(void) {
        NSLog(@"微信分享!");
        [self weiChatShare];
          [self again];
    }];
    
    
    NSMutableDictionary *getSaveDict = [Utils loadDataFrom:kSaveInfo];
    
    
    NSUInteger maxLevel = [getSaveDict[kScore]integerValue ]; //历史最高得分
    NSString *udid = getSaveDict[kUDID];
    NSString *userType = getSaveDict[kUserType];
    NSString *userName = getSaveDict[kUserName];

    
    
    //如果当前得分大于历史最高分
    if (self.levelCount >maxLevel) {
        maxLevel = self.levelCount;    //重新纪录最高分
        
        [getSaveDict setValue:[NSString stringWithFormat:@"%ld",(unsigned long)maxLevel] forKey:kScore];
        
        [Utils saveData:getSaveDict to:kSaveInfo];
        
        //更新当前数据
        AFHttpRequest *request = [[AFHttpRequest alloc]init ];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        [request insertUpdate:userName
                        score:[NSString stringWithFormat:@"%ld",(unsigned long)maxLevel]
                         type:userType
                         udid:udid
                 onCompletion:^(id result) {
                     NSLog(@"result:%@",result);
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [hud hideAnimated:YES];
                     });
                     
                 } onError:^(NSError *error) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [hud hideAnimated:YES];
                     });
                 }];
        
    }
    


    
    
    NSString *subTitle = [NSString stringWithFormat:@"分数 %lu 最佳 %lu", (unsigned long)self.levelCount, (unsigned long)maxLevel];
    [alert showSuccess:self title:@"游戏结束" subTitle:subTitle closeButtonTitle:nil duration:0.0f];
    
    
    
    
    
    
}

//微信分享
- (void)weiChatShare {
    
    
    NSMutableDictionary *getSaveDict = [Utils loadDataFrom:kSaveInfo];
    
    
    NSUInteger maxLevel = [getSaveDict[kScore]integerValue ]; //历史最高得分
    
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shareIcon.png"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:nil
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://pre.im/GameOnline"]
                                          title:[NSString stringWithFormat:@"我在游戏里最高玩到%lu分 你也来试试",(unsigned long)maxLevel]
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:self
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               if (error.code == 105) {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:@"请确认是否安装并登陆了微信"
                                                                                  delegate:self
                                                                         cancelButtonTitle:@"知道了"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                               }else{
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@",error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                               }
                               
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
    
}


- (UIView *)randomPillar {
    CGFloat height = kPillarHeight;
    CGFloat width = (arc4random() % ((int)kPillarMaxWidth-(int)kPillarMinWidth+1)) + kPillarMinWidth;
    CGRect rect = CGRectMake(0, ScreenHeight-height, width, height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor blackColor];
    view.userInteractionEnabled = NO;
    return view;
}

- (CGFloat)randomDistance {
    CGFloat start = self.startPillar.right;
    CGFloat end = ScreenWidth - 10 - self.endPillar.width - start;
    
    CGFloat distance = (arc4random() % ((int)end - (int)start + 1)) + start;
    return MAX(10, distance);
}

#pragma mark - getters & setters

- (UIImageView *)sprite {
    if (!_sprite) {
        _sprite = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _sprite.left = self.startPillar.right-20;
        _sprite.bottom = self.startPillar.top;
        _sprite.contentMode = UIViewContentModeScaleAspectFit;
        _sprite.image = [UIImage imageNamed:@"tianpingpai"];
        
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:10];
        for (int i = 1; i < 8; i++) {
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"tianRun%d", i]]];
        }
        _sprite.animationImages = images;
        _sprite.animationDuration = 0.2;
    }
    return _sprite;
}

- (UIView *)board {
    if (!_board) {
        _board = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
        _board.backgroundColor = [UIColor blackColor];
        _board.layer.anchorPoint = CGPointMake(0, 1);
    }
    return _board;
}

- (UILabel *)level {
    if (!_level) {
        CGRect rect = CGRectMake(0, 0, ScreenWidth, 40);
        _level = [[UILabel alloc] initWithFrame:rect];
        _level.centerX = self.view.centerX;
        _level.top = 200;
        _level.top = 150;
//        if (IS_IPHONE_4_AND_OLDER) {
//            _level.top = 100;
//            
//        }
        _level.backgroundColor = [UIColor clearColor];
        _level.textColor = [UIColor blackColor];
        _level.font = [UIFont fontWithName:@"Superclarendon" size:30];
        _level.textAlignment = NSTextAlignmentCenter;
    }
    return _level;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self again];
}

@end
