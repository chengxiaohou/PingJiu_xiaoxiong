//
//  MyOrderVC.h
//  PingJiu
//
//  Created by 小熊 on 2018/11/30.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderVC : BaseVC
@property (nonatomic,assign) NSInteger diff;
+(void)showTheMyOrderVC:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
