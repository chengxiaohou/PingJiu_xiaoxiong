//
//  AppDelegate.m
//  PingJiu
//
//  Created by 小熊 on 2018/11/28.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self autoLogin];
    return YES;
}
#pragma mark 自动登录
- (void)autoLogin
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session.requestSerializer setValue:USER.userToken forHTTPHeaderField:@"user_token"];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    
//    NSString *pwd = @"qq123456";
//    NSString *mdString = [pwd MD5];
//    NSDictionary *dic = @{
//                          @"userName":@"13049331080",
//                          @"pwd":mdString
//                          };
//    NSString *URL = SYSURL@"api/user/login";
    
    [session POST:@"http://119.28.27.217:8080/logistics/api/geturl" parameters:nil progress:nil
     
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSDictionary *dic = responseObject;
              USER.isLogin = NO;
             
              if ([dic[@"success"] isEqual:@(1)]) {
                  USER.isLogin = YES;
                  USER.nickName = @"小智";
                  USER.userName = @"小智";
                  USER.ID = @"27";
                  USER.headImg = @"http://qn.sdhui.net/FoDPn4TaJPrFu2qabIvD7pvHaGMN";
                  NSLog(@"自动登录%@", dic);
                  NSDictionary *temp = dic[@"data"];
                  [USER mj_setKeyValues:temp];
                  NSLog(@"%@",USER.nickName);
                 if ([temp[@"type"] isEqualToString:@"2"]) {
                     
                     if ([temp[@"url"] length] > 0) {
                         [UDManager keepTheUrl:temp[@"url"]];
                     }
                     
                      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                      
                      UIViewController *ctrl = [storyboard instantiateViewControllerWithIdentifier:@"NewDetailVC"];
                      
                      self.window.rootViewController = ctrl;
                  }
                 else{
                     [MBProgressHUD showMessage:[NSString stringWithFormat:@"欢迎回来%@",USER.userName] toView:Window];
                     
                     KUserNewNotiWithUserInfo(nil);
                 }
              
                  
                  
                  
                  
                  
                  /*
                   
                   */
              }
              else
              {
                  [MBProgressHUD showMessage:@"登陆失败，您已下线" toView:Window];
              }
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"报错：%@", [error localizedDescription]);
              [MBProgressHUD showError:@"网络加载出错,您已下线" toView:Window];
          }];
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
