//
//  NewDetailVC.m
//  PingJiu
//
//  Created by 小熊 on 2018/12/6.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "NewDetailVC.h"

@interface NewDetailVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet EEView *view1;
@property (weak, nonatomic) IBOutlet EEView *view2;
@property (weak, nonatomic) IBOutlet EEView *view3;
@property (weak, nonatomic) IBOutlet EEView *view4;
@property (weak, nonatomic) IBOutlet EEView *view5;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation NewDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //@"https://www.60658.com"
    NSString *string = [UDManager getTheUrl];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
    [self configTheView];
}
- (IBAction)onBack:(UIButton *)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (void)configTheView
{
    _backBtn.clipsToBounds = YES;
 _backBtn.layer.cornerRadius = 13.0;
    MJWeakSelf;
    //首页
    [_view1 setClickEvent:^{
        
        [weakSelf.webView reloadInputViews];
    }];
    
    //后退
    [_view2 setClickEvent:^{
       
        if ([weakSelf.webView canGoBack]) {
            [weakSelf.webView goBack];
        }
        
    }];
    
    //前进
    [_view3 setClickEvent:^{
        
        if ([weakSelf.webView canGoForward]) {
            [weakSelf.webView goForward];
        }
        
    }];
    
    //刷新
    [_view4 setClickEvent:^{
        
        [weakSelf.webView reload];
    }];
    
    //退出
    [_view5 setClickEvent:^{
     if (self.webView.loading)
        {
            [self.webView stopLoading];
        }
    }];
}

- (void)getTheDatas
{
    
}

@end
