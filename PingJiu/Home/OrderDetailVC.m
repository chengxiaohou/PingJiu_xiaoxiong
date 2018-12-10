//
//  OrderDetailVC.m
//  PingJiu
//
//  Created by 小熊 on 2018/12/10.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "OrderDetailVC.h"

@interface OrderDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OrderDetailVC
+(void)showTheOrderDetailVC:(NSDictionary *)dic
{
    OrderDetailVC *order = [Worker MainSB:@"OrderDetailVC"];
    order.dic = dic;
    [Worker showVC:order];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:@"订单详情" leftText:nil rightTitle:nil showBackImg:YES];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - ......::::::: UITableViewDataSource :::::::......

#pragma mark TV段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark TV行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (USER.address.length == 0) {
            TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            cell.btn1.layer.cornerRadius = 10;
            [cell.btn1 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        else{
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.label1.text = USER.addressName;
        cell.label2.text = USER.addressPhone;
        cell.label3.text = USER.address;
        return cell;
        }
    }
    else if(indexPath.section == 1){
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.image1.image = [UIImage imageNamed:_dic[@"detailImg"]];
        cell.label1.text = _dic[@"title"];
        cell.label2.text = [NSString stringWithFormat:@"¥%@",_dic[@"price"]];
        cell.label3.text = @"x1";
        return cell;
    }
    else{
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        cell.label1.textAlignment = NSTextAlignmentRight;
        cell.label2.textAlignment = NSTextAlignmentRight;
        cell.label3.textAlignment = NSTextAlignmentRight;
        
        cell.label1.text = [NSString stringWithFormat:@"付款总金额：%@元",_dic[@"price"]];
        cell.label2.text = @"可用折扣券：0元";
        cell.label3.text = [NSString stringWithFormat:@"实付款金额：%@元",_dic[@"price"]];
        return cell;
    }
    
    
}

- (void)onClick:(UIButton *)btn
{
    [MyAddressVC showTheMyAddressVC:200];
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (IBAction)tiJIaoOrder:(UIButton *)sender {
    if (USER.address.length == 0) {
        [MBProgressHUD showMessag:@"请填写新地址" toView:Window];
    }
    else{
    [MBProgressHUD showMessag:@"订单提交成功" toView:Window];
    [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
