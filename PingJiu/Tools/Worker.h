//
//  Worker.h
//  lvYou
//
//  Created by 小熊 on 2018/11/19.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Worker : NSObject
+ (BOOL)gotoLoginIfNotLogin:(UIViewController *)vc __attribute__((deprecated("Use gotoLoginIfNotLogin instead.(beta)")));
+ (BOOL)gotoLoginIfNotLogin;
+ (id)MainSB:(NSString *)viewControllerIdentifer;
+ (void)showVC:(UIViewController *)vc;
+ (UIViewController *)theTopVC;
+ (UIViewController*)findTopViewController:(UIViewController*)vc;
+ (NSString *)convertErrorMessage:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
