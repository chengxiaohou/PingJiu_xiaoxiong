//
//  PaywayView.h
//  shuiDianHui
//
//  Created by 小熊 on 2018/8/8.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaywayView : UIView
@property (nonatomic,copy) void (^onPay)(NSInteger tag);
@property (nonatomic,copy) void (^onCancel)(void);
@end
