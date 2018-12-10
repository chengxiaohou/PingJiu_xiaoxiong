//
//  SheZhiVC.m
//  Beauvigno
//
//  Created by 小熊 on 2017/8/22.
//  Copyright © 2017年 小熊. All rights reserved.
//

#import "SheZhiVC.h"
#import "ForgetPassWordVC.h"
@interface SheZhiVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet EETableView *tableView;

@end

@implementation SheZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.nav.backgroundColor = ThemeColor;
    [self.nav setTitle:@"设置" leftText:nil rightTitle:nil showBackImg:YES];
    self.nav.delegate = self;
    

}

- (void)left
{

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - ......::::::: UITableViewDataSource :::::::......

#pragma mark TV段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma mark TV行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        NSInteger type = [[UD valueForKey:@"type"] integerValue];
        if (type == 0) {
            return 2;
        }
        else
        {
        return 0;
        }
    }
    else
    {
    return 1;
    }
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"设置cell1" forIndexPath:indexPath];
            return cell;
        }
        else
        {
            TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"设置cell2" forIndexPath:indexPath];
            return cell;
        }
        
    }
    else
    {
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"设置cell3" forIndexPath:indexPath];
        [cell.btn1 addTarget:self action:@selector(onEsc) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}


#pragma mark 退出
- (void)onEsc
{
    [self showFunctionAlertWithTitle:nil message:@"确认退出吗？" functionName:@"确定" Handler:^{
        
//            BOOL isAuthorizedWithQQ = [ShareSDK hasAuthorized:SSDKPlatformTypeQQ];
//            if (isAuthorizedWithQQ) {
//                NSLog(@"我QQ登录授权了");
//                [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
//            }
//
//            BOOL isAuthorizedWithWeChat = [ShareSDK hasAuthorized:SSDKPlatformTypeWechat];
//            if (isAuthorizedWithWeChat) {
//                NSLog(@"我微信登录授权了");
//                [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
//            }

        
        
        
        [USER logout];
        [Worker gotoLoginIfNotLogin];
        
//        [self.navigationController popToRootViewControllerAnimated:0];
//        UITabBarController *vc = (UITabBarController *)Window.rootViewController;
//        vc.selectedIndex = 0;
        
    }];
 
}
#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //修改密码
        if (indexPath.row == 0) {
            XiuGaiMiMaVC *xiugai = [Worker MainSB:@"XiuGaiMiMaVC"];
            [self.navigationController pushViewController:xiugai animated:YES];
        }
        //找回密码
        else if(indexPath.row == 1)
        {
            ForgetPassWordVC *forget = [Worker MainSB:@"ForgetPassWordVC"];
            forget.titleName = @"找回密码";
            [self presentViewController:forget animated:YES completion:nil];
        }
    }
    
}


@end
