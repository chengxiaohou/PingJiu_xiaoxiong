//
//  WebVC.h
//  GoldenB
//
//  Created by 橙晓侯 on 16/5/12.
//  Copyright © 2016年 橙晓侯. All rights reserved.
//

#import "BaseVC.h"
#import "IMYWebView.h"
@interface WebVC : BaseVC
@property (nonatomic, strong) IMYWebView *webView;
/** 要打开的URL */
@property (nonatomic, strong) NSString *url;
/** 本地H5代码 */
@property (nonatomic, strong) NSString *HTMLString;
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic,assign) NSInteger diff;

+ (WebVC *)gotoWebWithUrl:(NSString *)url vc:(UIViewController *)oldVC __attribute__((deprecated("Use showWithUrl instead.")));

/** show方法1 */
+ (WebVC *)showWithUrl:(NSString *)url andTheTitle:(NSString *)title andTheDiff:(NSInteger)diff; //200 pop 100dismiss
/** show方法2 */
+ (WebVC *)showWithHTMLString:(NSString *)HTMLString andTheTitle:(NSString *)title andTheDiff:(NSInteger)diff;
@end
