//
//  SPDetailVC.m
//  PingJiu
//
//  Created by 小熊 on 2018/11/28.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "SPDetailVC.h"

@interface SPDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) PaywayView *payView;
@property (weak, nonatomic) IBOutlet EETableView *tableView;
@property (nonatomic,strong) UIView *backView;
@end

@implementation SPDetailVC
+(void)showTheSPDetailVC:(NSDictionary *)dic
{
    SPDetailVC *detail = [Worker MainSB:@"SPDetailVC"];
    detail.dic = dic;
    [Worker showVC:detail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:@"商品详情" leftText:nil rightTitle:nil showBackImg:YES];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    _backView.alpha = 0.6;
    _backView.backgroundColor = [UIColor blackColor];
    _backView.hidden = YES;
    [self.view addSubview:_backView];
    _payView = [[PaywayView alloc] initWithFrame:CGRectMake(0, Height , Width, Width * 0.76)];
    _payView.hidden = YES;
    [self.view addSubview:_payView];
    MJWeakSelf;
    _payView.onCancel = ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.payView.frame = CGRectMake(0, Height , Width, Width * 0.76);
            weakSelf.backView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                weakSelf.payView.hidden = YES;
                weakSelf.backView.hidden = YES;
            }
            
        }];
    };
    
    
    //付款
    _payView.onPay = ^(NSInteger tag) {
        
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.payView.frame = CGRectMake(0, Height , Width, Width * 0.76);
            weakSelf.backView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                weakSelf.payView.hidden = YES;
                weakSelf.backView.hidden = YES;
            }
            
        }];
        
        
        
        
           // [MBProgressHUD showError:@"订单不存在，暂不支持购买" toView:Window];
        
        
        
    };
}

#pragma mark 跳支付
- (void)pay:(NSInteger)tag andTheOrderNumber:(NSString *)orderNumber{
//
//    NSString *url = SYSURL@"api/ali/pay/preCreateOrderByApp";
//    if (tag == 1) {
//        url = SYSURL@"api/wx/pay/preCreateOrderByApp";
//    }
//    NSString *price = [NSString stringWithFormat:@"%@",@"0.1"];
//    //改价格0.01
//
//    [self get1_URL:url parameters:@{@"orderNo":orderNumber,@"payPrice":price} success:^(NSDictionary *dic) {
//
//        if ([dic[@"data"] isKindOfClass:[NSDictionary class]]){
//            NSDictionary *repose = dic[@"data"];
//            //微信支付
//            if (tag == 0) {
//
//                NSString *appScheme = @"shuiDianHui";
//                NSString *orderString = repose[@"body"];
////                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
////                    NSLog(@"reslut = %@",resultDic);
////                }];
//
//            }
//            //支付宝支付
//            else
//            {
//                PayReq *request = [[PayReq alloc] init] ;
//                request.partnerId = repose[@"partnerid"];
//                request.prepayId =  repose[@"prepayid"];
//                request.package = repose[@"package"];
//                request.nonceStr= repose[@"noncestr"];
//                int tamp = [repose[@"timestamp"] intValue];
//                request.timeStamp = tamp ;
//                request.sign= repose[@"sign"];
//                [WXApi sendReq:request];
//
//
//            }
//
//        }
//
//    }];
}

#pragma mark - ......::::::: UITableViewDataSource :::::::......

#pragma mark TV段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark TV行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1+[_dic[@"detail"] count];
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.image1.image = [UIImage imageNamed:_dic[@"detailImg"]];
        cell.label1.text = _dic[@"title"];
        cell.label2.text = _dic[@"des"];
        cell.label3.text = _dic[@"price"];
        cell.label4.text = _dic[@"content"];
        cell.label5.text = _dic[@"date"];
        return cell;
    }
    else{
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        NSArray *arr = _dic[@"detail"];
        if (arr.count > 0) {
            UIImage *imageV = [UIImage imageNamed:arr[indexPath.row - 1]];
            if (!imageV) {
                cell.imageHeight.constant = 0;
            }
            else{
                CGFloat space = (imageV.size.height * 0.1) / (imageV.size.width * 0.1);
                cell.imageHeight.constant = Width * space;
                cell.image1.image = imageV;
            }
            
            
            
            
        }
        
        return cell;
    }
    
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)onBuy:(UIButton *)sender {
    
    if (USER.isLogin) {
//        _backView.alpha = 0.6;
//        _backView.hidden = NO;
//        _payView.hidden = NO;
//        MJWeakSelf;
//        [UIView animateWithDuration:0.3 animations:^{
//            weakSelf.payView.frame = CGRectMake(0, Height - (Width * 0.76) , Width, Width * 0.76);
//        }];
        [OrderDetailVC showTheOrderDetailVC:_dic];
        
    }

    else{
    [Worker gotoLoginIfNotLogin];
    }
}


@end
