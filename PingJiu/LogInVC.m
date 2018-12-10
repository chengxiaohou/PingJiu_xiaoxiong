//
//  LogInVC.m
//  Beauvigno
//
//  Created by 小熊 on 2017/8/18.
//  Copyright © 2017年 小熊. All rights reserved.
//

#import "LogInVC.h"
#import "RegistVC.h"
#import "ForgetPassWordVC.h"
@interface LogInVC ()

@property (weak, nonatomic) IBOutlet UITextField *textF1;  //手机号
@property (weak, nonatomic) IBOutlet UITextField *textF2; ///密码

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIStackView *stackView1;
@property (weak, nonatomic) IBOutlet UIStackView *stackView2;




@end

@implementation LogInVC
{
    NSString *_loginName;
    NSString *_loginPassWord;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self autoShowLoginInfo];
    self.nav.backgroundColor = ThemeColor;
    [self.nav setTitle:@"登录" leftText:nil rightTitle:nil showBackImg:YES];
    self.nav.delegate = self;
    [self layout];
   
    

}


#pragma mark 自动填充账号密码（如果有）
- (void)autoShowLoginInfo
{
    if ([UDManager getUserName]) {
        _textF1.text = [UDManager getUserName];
    }
    
    if ([UDManager getUserPassword] && [[UD valueForKey:@"type"] integerValue] == 0) {
        _textF2.text = [UDManager getUserPassword];
    }
    else
    {
        _textF2.text = @"";
    }
}

- (void)left
{
    [self dismissViewControllerAnimated:YES completion:nil];
  //  [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)layout
{
    _textF1.borderStyle = UITextBorderStyleNone;
    _textF2.borderStyle =UITextBorderStyleNone;
    
    UITapGestureRecognizer *weiXinLogIn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weiXinLogIn)];
    [_stackView1 addGestureRecognizer:weiXinLogIn];
    
    UITapGestureRecognizer *qqLogIn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qqLogIn)];
    [_stackView2 addGestureRecognizer:qqLogIn];
    
    
    _view1.layer.cornerRadius = CorRad;
    _view1.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view1.layer.borderWidth = 1;
    
    
    _view2.layer.cornerRadius = CorRad;
    _view2.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view2.layer.borderWidth = 1;
}

#pragma mark 微信登录
- (void)weiXinLogIn
{
//    [MBProgressHUD showHUDAddedTo:Window animated:YES];
//    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *resp, NSError *error) {
//        [MBProgressHUD hideHUDForView:Window animated:YES];
//        if (state == SSDKResponseStateSuccess)
//        {
//
//
//            if (resp.uid && resp.nickname && resp.icon) {
//               NSDictionary *dic = resp.credential.rawData;
//               NSString *openID = dic[@"openid"];
//                [self loginRequestTheURL:BASEURL@"api/user/third_login" andTheParameters:@{@"type":@(1002),@"openId":openID} andTheType:1002 andTheOpenID:openID];
//            }
//        }
//
//        else
//        {
//            NSLog(@"%@",error);
//        }
//
//    }];
 
}
#pragma mark QQ登录
- (void)qqLogIn
{
    
//    [MBProgressHUD showHUDAddedTo:Window animated:YES];
//    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//         [MBProgressHUD hideHUDForView:Window animated:YES];
//         if (state == SSDKResponseStateSuccess)
//         {
//
//
//             if (user.uid && user.nickname && user.icon) {
//
//                 NSDictionary *dic = user.credential.rawData;
//                 NSString  *openID = dic[@"openid"];
//                 [self loginRequestTheURL:BASEURL@"api/user/third_login" andTheParameters:@{@"type":@(1001),@"openId":openID} andTheType:1001 andTheOpenID:openID];
//             }
//         }
//
//         else
//         {
//             NSLog(@"%@",error);
//             [MBProgressHUD showError:@"网络请求失败" toView:Window];
//         }
//
//     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 登录
- (IBAction)SignIn:(UIButton *)sender {
    [self.view endEditing:YES];
   // [CD stop];
    
        if (_textF1.text.length != 0 ) {
        if (_textF2.text.length < 1) {
            
            [MBProgressHUD showMessag:@"请将数据填写完整" toView:Window];
            return;
        }
        

        [self loginRequestTheURL:BASEURL@"api/user/login" andTheParameters:@{@"phone":_textF1.text,@"password":[_textF2.text MD5]} andTheType:0 andTheOpenID:nil];
    }
    else
    {
        [MBProgressHUD showMessage:@"手机号格式不正确" toView:Window];
    }

    
}

- (void)loginRequestTheURL:(NSString *)URL andTheParameters:(NSDictionary *)parameters andTheType:(NSInteger)type andTheOpenID:(NSString *)openID
{
    [self post2_URL:URL
         parameters:parameters
            success:^(NSDictionary *dic) {
                
                NSLog(@"================== 用户登录了 =================");
                
                NSDictionary *temp = dic[@"data"];
                [USER mj_setKeyValues:temp];

                
                //普通登录
               
                if (type == 0) {
                    _loginName = _textF1.text;
                    _loginPassWord = _textF2.text;
                    
                }
                //QQ登录
                else if (type == 1001)
                {
                    _loginName = USER.phone;
                    _loginPassWord = openID;
                   
                    
                }
                //微信登录
                else if (type == 1002)
                {
                    _loginName = USER.phone;
                    _loginPassWord = openID;
      
                }
                
                
                // 如果登录的用户改变了,要重置页面
                if (![USER.ID isEqualToString:[UD valueForKey:@"ID"]]) {
                    UITabBarController *vc = (UITabBarController *)Window.rootViewController;
                    vc.selectedIndex = 0;// 定格到第1模块
                    for (UINavigationController *navVC in vc.viewControllers)
                    {
                        [navVC popToRootViewControllerAnimated:0];// 确保4个模块都显示主页
                    }
                }
                
                //保存ID
                [UD setObject:USER.ID forKey:@"ID"];
                [UD setObject:@(type) forKey:@"type"];
            
                
                // 登录成功,记录账号密码
              //  [UDManager setLoginName:_loginName password:_loginPassWord];
                
              //  [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_DidLogin object:dic];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
        } elseAction:^(NSDictionary *dic) {
            
//            if (type != 0) {
//                LoginBangDingVC *bangDIng = [Worker MainSB:@"LoginBangDingVC"];
//                bangDIng.type = type;
//                bangDIng.openId = openID;
//
//                [self presentViewController:bangDIng animated:YES completion:nil];
//               // [LoginBangDingVC showTheloginBangDingVCTheType:type andTheOpenID:openID];
//            }
//
     
         } failure:^(NSError *error) {
     
         }];
}

#pragma mark 忘记密码
- (IBAction)forgetPassWord:(UIButton *)sender {
    
    ForgetPassWordVC *forget = [Worker MainSB:@"ForgetPassWordVC"];
    forget.titleName = @"忘记密码";
    [self presentViewController:forget animated:YES completion:nil];
}

#pragma mark 注册
- (IBAction)ZhuCe:(UIButton *)sender {
    
    RegistVC *regist = [Worker MainSB:@"RegistVC"];
    [self presentViewController:regist animated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"我释放了");
}

@end
