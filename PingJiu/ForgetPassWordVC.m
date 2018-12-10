//
//  ForgetPassWordVC.m
//  Beauvigno
//
//  Created by 小熊 on 2017/8/22.
//  Copyright © 2017年 小熊. All rights reserved.
//

#import "ForgetPassWordVC.h"

@interface ForgetPassWordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UITextField *textF1;
@property (weak, nonatomic) IBOutlet UITextField *textF2;
@property (weak, nonatomic) IBOutlet UITextField *textF3;

@property (weak, nonatomic) IBOutlet UITextField *textF4;


@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation ForgetPassWordVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCodeBtn:) name:NOTI_SMSCountDown object:nil];
}

#pragma mark 刷新验证码按钮
- (void)refreshCodeBtn:(NSNotification *)info
{
//    if ([CD SMS_CD] != 0)
//    {
//        [_codeBtn setTitle:[NSString stringWithFormat:@"已发送(%lds)",(long)CD.SMS_CD] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];
    
    self.nav.backgroundColor = ThemeColor;
    [self.nav setTitle:_titleName leftText:nil rightTitle:nil showBackImg:YES];
    self.nav.delegate = self;

}
- (void)left
{
   // [CD stop];
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (void)layout
{
    _view1.layer.cornerRadius = CorRad;
    _view1.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view1.layer.borderWidth = 1;
    _view2.layer.cornerRadius = CorRad;
    _view2.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view2.layer.borderWidth = 1;
    
    _view3.layer.cornerRadius = CorRad;
    _view3.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view3.layer.borderWidth = 1;
    
    _view4.layer.cornerRadius = CorRad;
    _view4.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view4.layer.borderWidth = 1;
    
    _textF1.borderStyle = UITextBorderStyleNone;
    _textF2.borderStyle = UITextBorderStyleNone;
    _textF3.borderStyle = UITextBorderStyleNone;
    _textF4.borderStyle = UITextBorderStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 获取验证码
- (IBAction)getTheCodeBtn:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if (_textF1.text.length != 0)
    {
//        if ([Worker isMobileNumber:_textF1.text]) {
//
//            if (CD.SMS_CD == 0) {
//
//                [self requstTheCode];
//            }
//            else
//            {
//                ErrorCodeCD;
//            }
//
//
//        }
//        else
//        {
//            [MBProgressHUD showError:@"输入的号码不正确" toView:self.view];
//        }
    }
    else
    {
        [MBProgressHUD showError:@"输入的号码不能为空" toView:self.view];
    }

}

#pragma mark 注册号码查重 + 验证码请求
- (void)requstTheCode
{
    NSString *url = BASEURL@"api/user/sms";
    NSDictionary *parameters = @{@"phone":_textF1.text,@"type":@"3002"};
    
    
    [self post2_URL:url
         parameters:parameters  success:^(NSDictionary *dic) {
             
             // 验证码
         //    [CD startCountDown];
             
             
             
         } elseAction:nil failure:^(NSError *error) {
             
     }];
    
}


#pragma mark 提交
- (IBAction)sureBtn:(UIButton *)sender {
    
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view endEditing:YES];
    if (_textF3.text.length == 0  || _textF4.text.length == 0) {
        [MBProgressHUD showError:@"请输入新密码" toView:self.view];
        return;
    }

    else if (![_textF3.text isEqualToString:_textF4.text])
    {
        [MBProgressHUD showMessag:@"两次输入的密码不一致" toView:Window];
        return;
        
    }
    else if (_textF2.text.length == 0)
    {
        [MBProgressHUD showError:@"验证码不能为空" toView:self.view];
        return;
    }
    else
    {
        [self requstChangeThePassWord];
    }
}

#pragma mark 忘记密码接口
- (void)requstChangeThePassWord
{
    [self post1_URL:BASEURL@"api/user/reset_password" parameters:@{@"phone":_textF1.text,@"password":[_textF3.text MD5],@"code":_textF2.text} success:^(NSDictionary *dic) {
        
      //  [UDManager setLoginName:USER.phone password:_textF3.text];
        [self.navigationController popViewControllerAnimated:YES];
        
    } elseAction:^(NSDictionary *dic) {
        
    } failure:^(NSError *error) {
        
    }];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if([string isEqualToString:@" "])
    {
        return NO;
    }
    
    
    
    return YES;
    
}

#pragma mark textFildDeleget
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    MJWeakSelf;
    if (textField == _textF1) {
        if (_view2.y + _view2.height  > Height - 325) {
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.view.frame = CGRectMake(0, -fabs(_view2.y + _view2.height - (Height - 325)), Width, Height);
            }];
        }
        
    }
    else if (textField == _textF2) {
        if (_view3.height + _view3.y  > Height - 325) {
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.view.frame = CGRectMake(0, -fabs(_view3.height + _view3.y - (Height - 325)), Width, Height);
            }];
        }
        
    }
    else if (textField == _textF3) {
        
        if (_view4.height + _view4.y > Height - 325) {
            
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.view.frame = CGRectMake(0, -fabs(_view3.height + _view3.y - (Height - 325)), Width, Height);
            }];
        }
        
    }
    else if (textField == _textF4) {
        
        if ((_view4.height * 2) + _view4.y > Height - 325) {
            
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.view.frame = CGRectMake(0, -fabs((_view3.height * 2) + _view3.y - (Height - 325)), Width, Height);
            }];
        }
        
    }
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    MJWeakSelf;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.view.frame = CGRectMake(0, 0, Width, Height);
    }];
    
}



@end
