//
//  TheUser.h
//  QuanQiuBang
//
//  Created by 橙晓侯 on 16/1/6.
//  Copyright © 2016年 小马网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObj.h"

@interface TheUser : BaseObj

/** 登录状态 */
@property (nonatomic, assign) BOOL isLogin; //
/** ID (uid) */
@property (nonatomic,strong) NSString *ID;//
/*真实名字*/
@property (nonatomic, strong) NSString *name;

/*头像*/
@property (nonatomic, strong) NSString *headImg;
/*性别  0女 1男*/
@property (nonatomic, strong) NSString *sex;//

/*手机号码*/
@property (nonatomic, strong) NSString *phone;//

/*昵称*/
@property (nonatomic, strong) NSString *nickName;
/*用户名*/
@property (nonatomic, strong) NSString *userName;//
@property (nonatomic, strong) NSString *userToken;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *addressName;
@property (nonatomic, strong) NSString *addressPhone;
//========================== 以下方法是给单例USER用的，其余用户不要调用这些方法 ==========================

+ (TheUser *)user;
/** 退出并清空账号缓存 */
- (void)cleanTheLoginDataAndLogout;
//- (void)cleanUserDataAndLogout __attribute__((deprecated("Use cleanTheLoginDataAndLogout instead.「方法名表述有歧义」")));
/** 退出登录 不清空账号密码 */
- (void)logout;
/** 清空全部属性 */
- (void)cleanUserData;
/** 从缓存加载用户数据 */
- (BOOL)loadUserDataFromCache;
/** 缓存用户属性 */
- (void)cacheUserData;
/** 获取缓存的用户对象 */
- (TheUser *)getCacheUser;
/** 清空缓存的用户数据 */
- (void)cleanUserCacheData;
/** 是否置顶 */
//- (BOOL)isTop;

- (void)cleanUserDataAndLogout;
@end
