//
//  TheUser.m
//  QuanQiuBang
//
//  Created by 橙晓侯 on 16/1/6.
//  Copyright © 2016年 小马网络. All rights reserved.
//

#import "TheUser.h"

@interface TheUser ()



@end

@implementation TheUser

MJExtensionLogAllProperties

// 单例对象
static TheUser *userInstance = nil;
// 执行一次
static dispatch_once_t predicate;

+ (TheUser *)user
{
    dispatch_once(&predicate, ^
                  {
                      userInstance = [[self alloc] init];
                  });
    
    return userInstance;
}

#pragma mark 注销单例
+ (void)deallocInstance {
    
    userInstance = nil;
    predicate = 0l;
    
}


- (void)cleanUserDataAndLogout
{
    //    [UDManager cleanTheLoginData]; // 清除保存的账号密码
    //    NSLog(@"清空账号密码");
    //    [self logout];
    
    
    NSDictionary *dic = [USER mj_keyValues];
    NSArray *values = [dic allValues];
    NSArray *keys = [dic allKeys];
    
    // 制造“空”字典
    NSInteger i = 0;
    for (id obj in values)
    {
        if ([obj isKindOfClass:[NSString  class]])
        {
            [dic setValue:@"" forKey:keys[i]];
        }
        else
        {
            [dic setValue:@0 forKey:keys[i]];
        }
        
        i++;
    }
    // 给USER的属性置“空”
    [USER mj_setKeyValues:dic];
    [self logout];
    NSLog(@"退出登录，清空用户属性");
    
}

- (void)cleanTheLoginDataAndLogout
{
    [UDManager cleanTheLoginData]; // 清除保存的账号密码
    NSLog(@"清空账号密码");
    [self logout];
    
}

#pragma mark 登出
- (void)logout
{
    [USER cleanUserData];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_DidLogout object:nil];
    NSLog(@"退出登录");
}

#pragma mark 清空全部属性
- (void)cleanUserData
{
    [TheUser deallocInstance];
    
    NSLog(@"报幕员：单例已注销%@", USER);
}

#pragma mark 从缓存加载用户数据
- (BOOL)loadUserDataFromCache
{
//    [USER cleanUserData]; 一般都是打开时才调用，可能没有老数据，先不清空老数据
    if ([USER getCacheUser]) {
        
        [USER mj_setKeyValues:[[USER getCacheUser] mj_keyValues]];
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark 缓存用户属性
- (void)cacheUserData
{
    NSDictionary *dic = [USER mj_keyValues];
    // 缓存用户信息到本地
    TheUser *temp = [TheUser mj_objectWithKeyValues:dic];
    temp.isLogin = 0;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:temp];
    [UD setObject:data forKey:USER_Cache];
}

#pragma mark 获取缓存的用户对象
- (TheUser *)getCacheUser
{
    TheUser *u = [NSKeyedUnarchiver unarchiveObjectWithData:[UD objectForKey:USER_Cache]];
    return u;
}

#pragma mark 清空缓存的用户数据
- (void)cleanUserCacheData
{
    [UD setObject:nil forKey:USER_Cache];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"userToken":@"token",
             };
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    
    return oldValue;
}

// 橙晓侯扩展方法 分身替换回本体 使用此方法必须覆写mj_replacedKeyFromPropertyName，以免与通用筛选冲突
+ (NSDictionary *)replacedListDic
{
    return nil;
//    @{
//      @"friendHeadImg"   :@"headImg",
//      @"img"             :@"headImg",
//      @"userHeadImg"     :@"headImg",
//      @"heamImg"         :@"headImg",
//      @"friendUid"       :@"ID",
//      @"uid"             :@"ID",
//      @"userUid"         :@"ID",
//      @"master"          :@"isMaster",
//      @"userName"        :@"name",
//      @"friendName"      :@"name",
//      // 导入联系人
//      @"friend"          :@"isFriend",
//      @"user"            :@"isUser",
//      };
}

@end
