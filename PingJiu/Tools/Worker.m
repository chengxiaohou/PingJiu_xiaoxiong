//
//  Worker.m
//  lvYou
//
//  Created by 小熊 on 2018/11/19.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "Worker.h"

@implementation Worker
+(id)MainSB:(NSString *)viewControllerIdentifer{
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:SBName bundle:nil];
    
    return [SB instantiateViewControllerWithIdentifier:viewControllerIdentifer];
}
+ (BOOL)gotoLoginIfNotLogin:(UIViewController *)vc
{
    if (!USER.isLogin)
    {
        UINavigationController *navc = [Worker MainSB:SBLoginName];
        
        if (vc)
        {
            [vc presentViewController:navc animated:YES completion:nil];
        }
        else
        {
            //            [ROOT_TBC presentViewController:navc animated:YES completion:nil];
        }
        
        
    }
    return USER.isLogin;
}

#pragma mark 去登陆（未登陆）
+ (BOOL)gotoLoginIfNotLogin
{
    // 为登录
    if (!USER.isLogin)
    {
        UIViewController *vc = TopVC.navigationController ? TopVC.navigationController : TopVC;
        // 如果当前不是登录系列页面，则跳转登录系列
        if (![vc.restorationIdentifier isEqualToString:SBLoginName]) {
            
            UINavigationController *navc = [Worker MainSB:SBLoginName];
            [TopVC presentViewController:navc animated:YES completion:nil];
        }
        
        
    }
    NSLog(@"gotoLoginIfNotLogin被驳回，用户已登录%@", USER);
    return USER.isLogin;
}

#pragma mark 智能VC跳转
+ (void)showVC:(UIViewController *)vc
{
    // 如果TopVC是导航C 则直接push
    if ([TopVC isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController *)TopVC;
        [nav pushViewController:vc animated:YES];
    }
    // 是TopVC带导航C的VC 则智能push
    else if (TopVC.navigationController)
    {
        // 如果对方是Nav 用present
        if ([vc isKindOfClass:[UINavigationController class]])
            [TopVC presentViewController:vc animated:1 completion:nil];
        // 如果对方不是Nav 用push
        else [TopVC.navigationController pushViewController:vc animated:YES];
    }
    // 如果TopVC是不带导航C的VC 则present
    else if (!TopVC.navigationController)
    {
        [TopVC presentViewController:vc animated:YES completion:nil];
    }
}
#pragma mark 当前VC
+ (UIViewController *)theTopVC
{
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [Worker findTopViewController:viewController];
}
+ (UIViewController*)findTopViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [Worker findTopViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [Worker findTopViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [Worker findTopViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [Worker findTopViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
    
}

+ (NSString *)convertErrorMessage:(NSString *)string
{
    if ([string isEqualToString:@"请求超时。"])
    {
        return @"请求超时";
    }
    else if ([string isEqualToString:@"未能读取数据，因为它的格式不正确。"])
    {
        return @"服务器异常";
    }
    else if ([string isEqualToString:@"网络连接已中断。"])
    {
        return @"请检查您的网络";
    }
    else
    {
        return string;
    }
}
@end
