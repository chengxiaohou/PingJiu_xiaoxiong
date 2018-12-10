//
//  XiuGaiMiMaVC.m
//  Beauvigno
//
//  Created by 小熊 on 2017/8/22.
//  Copyright © 2017年 小熊. All rights reserved.
//

#import "XiuGaiMiMaVC.h"

@interface XiuGaiMiMaVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UITextField *textF1;
@property (weak, nonatomic) IBOutlet UITextField *textF2;
@property (weak, nonatomic) IBOutlet UITextField *textF3;

@end

@implementation XiuGaiMiMaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.nav.backgroundColor = ThemeColor;
    [self.nav setTitle:@"修改密码" leftText:nil rightTitle:nil showBackImg:YES];
    self.nav.delegate = self;
    
    [self layout];

    
}

- (void)left
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



- (void)layout
{
    
    _textF1.borderStyle = UITextBorderStyleNone;
    _textF2.borderStyle = UITextBorderStyleNone;
    _textF3.borderStyle = UITextBorderStyleNone;

    _view1.layer.cornerRadius = CorRad;
    _view1.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view1.layer.borderWidth = 1;
    
    _view2.layer.cornerRadius = CorRad;
    _view2.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view2.layer.borderWidth = 1;
    
    _view3.layer.cornerRadius = CorRad;
    _view3.layer.borderColor = HexColor(0xd2d2d2).CGColor;
    _view3.layer.borderWidth = 1;

    

}


#pragma mark 提交
- (IBAction)tiJiao:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_textF1.text.length == 0) {
        [MBProgressHUD showMessag:@"请输入原密码" toView:Window];
        return;
    }
    else if (_textF2.text.length == 0 || _textF3.text.length == 0)
    {
        [MBProgressHUD showMessag:@"请设置新密码" toView:Window];
        return;
    }
//    else if (![Worker isPassWordNumber:_textF2.text] ) {
//
//
//        [self showFunctionAlertWithTitle:nil message:@"密码长度应在6-16之间，必须包含数字,字母,字符中的任意两种以上" functionName:@"确定" Handler:^{
//        }];
//
//        return;
//    }
    else if (![_textF2.text isEqualToString:_textF3.text])
    {
        [MBProgressHUD showMessag:@"两次输入的密码不一致" toView:Window];
        return;
        
    }
    [self changeThePassWord];
    
}

- (void)changeThePassWord
{
    [self post1_URL:SYSURL@"api/user/update_password" parameters:@{@"oldPwd":_textF1.text,@"newPwd":_textF2.text} success:^(NSDictionary *dic) {
        
//        [USER logout];
//        [Worker gotoLoginIfNotLogin];
//        
//        [self.navigationController popToRootViewControllerAnimated:0];
//        UITabBarController *vc = (UITabBarController *)Window.rootViewController;
//        vc.selectedIndex = 0;
        
       // [UDManager setLoginName:USER.phone password:_textF2.text];
        [self.navigationController popViewControllerAnimated:YES];
        
    } elseAction:^(NSDictionary *dic) {
        
    } failure:^(NSError *error) {
        
    }];
}


@end
