//
//  SPDetailVC.h
//  PingJiu
//
//  Created by 小熊 on 2018/11/28.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPDetailVC : BaseVC
@property (nonatomic,strong) NSDictionary *dic;
+(void)showTheSPDetailVC:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
