//
//  AppDelegate.m
//  KuaiYong
//
//  Created by lijinwei on 15/6/13.
//  Copyright (c) 2015年 lijinwei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UIHelper.h"
#import "DSNavigationBar.h"
#import "LaunchAppMgr.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "LaunchGuideViewController.h"

@interface AppDelegate () <LaunchGuideViewControllerDelegate>

@property (strong, nonatomic) UINavigationController *navigationController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [[LaunchAppMgr sharedManager] initalize];
    
    [self.window makeKeyAndVisible];
    
    [self initShareSDK];
    
    if ([LaunchGuideViewController firstTimeStartForCurrentVersion]) {
        [self showLaunchViewController];
    }
    else {
        [self initMainView];
    }

    return YES;
}

- (void)initShareSDK {
    [ShareSDK registerApp:@"86b7c59a1fba"];//字符串api20为您的ShareSDK的AppKey
    
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台 （注意：2个方法只用写其中一个就可以）
    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                              redirectUri:@"http://www.sharesdk.cn"];
                              //weiboSDKCls:[WeiboSDK class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用  http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                           wechatCls:[WXApi class]];
}

- (void) initMainView{
    self.navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[DSNavigationBar class] toolbarClass:nil];

    [self.navigationController setViewControllers:@[[[ViewController alloc] init]]];
    [[DSNavigationBar appearance] setNavigationBarWithColor:COLOR(80, 87, 131)];
    [self.window setRootViewController:self.navigationController];
}

- (void) showLaunchViewController
{
    LaunchGuideViewController *guideViewController = [[LaunchGuideViewController alloc] init];
    guideViewController.view.frame = [UIScreen mainScreen].bounds;
    guideViewController.delegate = self;
    self.window.rootViewController = guideViewController;
}

- (void) didGuideViewEnded {
    [self initMainView];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
