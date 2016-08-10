//
//  AppDelegate.m
//  Game
//
//  Created by sike on 16/3/7.
//  Copyright © 2016年 sike. All rights reserved.
//

#import "AppDelegate.h"
#import "AnimalViewController.h"
#import "Game-Swift.h"
#import "IQKeyboardManager.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"

@interface AppDelegate (){
    AnimalViewController *animalVC;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    sleep(2); //预先睡眠2秒钟
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(disAnimalVC) name:@"disAnimalVC" object:nil ];

    
    MainViewControllers *rootVC = [[MainViewControllers alloc]init ];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:rootVC ];
    navController.navigationBarHidden = YES;
    self.window.rootViewController = navController;
    
    [IQKeyboardManager sharedManager];   //安装智能键盘

     [self resignShareSDK];
    
    
    [self.window makeKeyAndVisible];
    
    /*
     如果已经获得发送通知的授权则创建本地通知，否则请求授权
     (注意：如果不请求授权在设置中是没有对应的通知设置项的，
     也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
     */
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }else{
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }

    

    return YES;
}

//注册shareSDK
- (void)resignShareSDK {
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"15c1c7d1d9b98"
     
          activePlatforms:@[
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
                 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxfc5a96dc08336909"
                                       appSecret:@"7d9584ba5dcf495d32a02fbe14c7727f"];
                 break;
             default:
                 break;
         }
     }];
}


#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}

#pragma mark 进入前台设置消息信息
-(void)applicationWillEnterForeground:(UIApplication *)application{
    //进入前台取消应用消息图标
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
}
#pragma mark 进入后台设置消息信息
- (void)applicationWillResignActive:(UIApplication*)application{
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}


//本地通知
- (void)addLocalNotification{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    /*
     设置调用时间
     */
    //通知触发的时间，10s以后
//    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:10.0];
    
    
    //通知触发时间 2天以后
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:60*60*24*2];
    
    //通知重复间隔 0  NSCalendarUnitSecond
    notification.repeatInterval=NSCalendarUnitSecond;
    //当前日历，使用前最好设置时区等信息以便能够自动同步时间
    notification.repeatCalendar=[NSCalendar currentCalendar];
    
    /*
     设置通知属性
     */
    //通知主体
    notification.alertBody=@"您已经有一段时间没玩 天平派Online 是否想玩玩？";
    //应用程序图标右上角显示的消息数
    notification.applicationIconBadgeNumber=1;
    //待机界面的滑动动作提示
    notification.alertAction=@"打开天平派Online";
    //收到通知时播放的声音，默认消息声音
    notification.soundName=UILocalNotificationDefaultSoundName;

    
    /*
     调用通知
     */
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    

    
}

#pragma mark：接收本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{

    // 图标上的数字减1
     application.applicationIconBadgeNumber =0;
    
    //移除所有本地通知
    [self removeNotification];
}

#pragma mark 移除所有本地通知
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}



- (void)disAnimalVC{
    
    
    //2秒钟以后 动画View 消失
    [UIView animateWithDuration:2
                     animations:^{
                         animalVC.view.alpha = 0;
                    
    } completion:^(BOOL finished) {
        //从主视图 移除
        [animalVC.view removeFromSuperview];
         animalVC = nil;
    }];

}







@end
