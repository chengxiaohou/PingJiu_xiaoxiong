//
//  MyAddressVC.h
//  JunJie
//
//  Created by 小熊 on 2017/2/23.
//  Copyright © 2017年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAddressVC : BaseVC
@property (nonatomic,assign) NSInteger diff; //100 我的个人中心进入  其他是确认订单调入选地址
+(void)showTheMyAddressVC:(NSInteger)diff;
@end
