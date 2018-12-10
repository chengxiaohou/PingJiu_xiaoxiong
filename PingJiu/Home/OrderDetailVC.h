//
//  OrderDetailVC.h
//  PingJiu
//
//  Created by 小熊 on 2018/12/10.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailVC : BaseVC
@property (nonatomic,strong) NSDictionary *dic;
+(void)showTheOrderDetailVC:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
