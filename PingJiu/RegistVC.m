//
//  RegistVC.m
//  Beauvigno
//
//  Created by 小熊 on 2017/8/21.
//  Copyright © 2017年 小熊. All rights reserved.
//

#import "RegistVC.h"

@interface RegistVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UITextField *textF1; //手机号码
@property (weak, nonatomic) IBOutlet UITextField *textF2; //验证码
@property (weak, nonatomic) IBOutlet UITextField *textF3; //输入密码
@property (weak, nonatomic) IBOutlet UITextField *textF4; //再次输入密码
@property (weak, nonatomic) IBOutlet UITextField *textF5; //邀请码
@property (weak, nonatomic) IBOutlet UIButton *codeBtn; //验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *registBtn; //注册按钮
@property (weak, nonatomic) IBOutlet UIView *botomBackView;

@end

@implementation RegistVC
{
    NSString *_referUid;
}
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
    self.nav.backgroundColor = ThemeColor;
    [self.nav setTitle:@"注册" leftText:nil rightTitle:nil showBackImg:YES];
    self.nav.delegate = self;
    _referUid = @"";
    [self layout];
}

- (void)left
{
   // [CD stop];
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self.navigationController popViewControllerAnimated:YES];
}


- (void)layout
{
    _registBtn.layer.cornerRadius = 4;
    _textF1.borderStyle = UITextBorderStyleNone;
    _textF2.borderStyle = UITextBorderStyleNone;
    _textF3.borderStyle = UITextBorderStyleNone;
    _textF4.borderStyle = UITextBorderStyleNone;
    _textF5.borderStyle = UITextBorderStyleNone;
    _textF1.delegate = self;
    _textF2.delegate = self;
    _textF3.delegate = self;
    _textF4.delegate = self;
    _textF5.delegate = self;
    
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
    
    _view5.layer.cornerRadius = CorRad;
    _view5.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view5.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 发送验证码
- (IBAction)onCode:(UIButton *)sender {
    
    
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
    NSDictionary *parameters = @{@"phone":_textF1.text,@"type":@"3001"};
    
    
    [self post2_URL:url
         parameters:parameters  success:^(NSDictionary *dic) {
             
             // 验证码
          //   [CD startCountDown];
             
             
             
         } elseAction:nil failure:^(NSError *error) {
             
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


#pragma mark 注册
- (IBAction)onRegist:(UIButton *)sender {
    
    
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view endEditing:YES];
//    [CD stop];
//    if (_textF1.text.length == 0 || ![Worker isMobileNumber:_textF1.text]) {
//        [MBProgressHUD showError:@"输入的号码不正确" toView:self.view];
//        return;
//
//    }
 //   else
        if (_textF3.text.length == 0) {
        [MBProgressHUD showError:@"密码不能为空" toView:self.view];
        return;
    }
//    else if (![Worker isPassWordNumber:_textF3.text]) {
//
//
//        [self showFunctionAlertWithTitle:nil message:@"密码长度应在6-16之间，必须包含数字,字母,字符中的任意两种以上" functionName:@"确定" Handler:^{
//        }];
//
//        return;
//    }
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
        [self requstRegist];
    }
}

#pragma mark 注册接口

- (void)requstRegist
{
    
    [self post2_URL:BASEURL@"api/user/register"
         parameters:@{
                      @"phone":_textF1.text,
                      @"password":[_textF3.text MD5],
                      @"code":_textF2.text,
                      @"referUid":_referUid
                      }
            success:^(NSDictionary *dic) {
                
               // [self.navigationController popViewControllerAnimated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
            } elseAction:^(NSDictionary *dic) {
                
                [MBProgressHUD showError:dic[@"msg"] toView:Window];
            } failure:^(NSError *error) {
                
            }];
    
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
    else {
        
        if (_view5.height + _view5.y > Height - 325) {
            
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.view.frame = CGRectMake(0, -fabs(_view5.height + _view5.y - (Height - 325)), Width, Height);
            }];
        }
        
    }
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    MJWeakSelf;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.view.frame = CGRectMake(0, 0, Width, Height );
    }];
    
    
    if (textField == _textF5) {
        _referUid = textField.text;
    }
    
}

@end
