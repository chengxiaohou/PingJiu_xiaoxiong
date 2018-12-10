//
//  PaywayView.m
//  shuiDianHui
//
//  Created by 小熊 on 2018/8/8.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "PaywayView.h"
#import "PayCell.h"
#import "PayModel.h"
#define CELL @"PayCell"
@interface PaywayView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *MJDatas;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end
@implementation PaywayView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self configTheViewWithFrame:frame]; 
    }
    return self;
}
- (NSMutableArray *)MJDatas
{
    if (!_MJDatas) {
        _MJDatas = [NSMutableArray array];
    }
    return _MJDatas;
}

- (void)configTheViewWithFrame:(CGRect)frame
{
    NSArray *arr = @[@"支付宝支付",@"微信支付"];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *string = arr[i];
        PayModel *mod = [PayModel new];
        if (i == 0) {
            mod.imageName = @"pay_ic_alipay";
            mod.isSelect = YES;
        }
        else if (i == 1){
            mod.imageName = @"pay_ic_wechat";
            mod.isSelect = NO;
        }
        
        mod.name = string;
        [self.MJDatas addObject:mod];
    }
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, frame.size.height - 50, Width, 50);
    //[btn setBackgroundImage:[UIImage imageNamed:@"order_bnt"] forState:UIControlStateNormal];
    btn.backgroundColor = HexColor(0xA92748);
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btn addTarget:self action:@selector(onPay:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 50)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(21, 14, Width - 42, 22)];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = HexColor(0x666666);
    label.text = @"支付方式";
    [view addSubview:label];
  
  
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(Width - 35, 15, 20, 20);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"home_ic_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelBtn];
    
    [self addSubview:view];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
 
    
    
    
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, Width, frame.size.height - 100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.bounces = NO;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.estimatedRowHeight = 44.0;
    [_tableView registerNib:[UINib nibWithNibName:@"PayCell" bundle:nil] forCellReuseIdentifier:CELL];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    
}

- (void)onCancel:(UIButton *)btn
{
    if (self.onCancel) {
        self.onCancel();
    }
}

- (void)onPay:(UIButton *)btn
{
    if (self.onPay) {
        self.onPay(_indexPath.row);
    }
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
    return self.MJDatas.count;
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < self.MJDatas.count) {
        PayModel *mod = self.MJDatas[indexPath.row];
        cell.image1.image = [UIImage imageNamed:mod.imageName];
        cell.label1.text = mod.name;
        if (mod.isSelect) {
            _indexPath = indexPath;
            [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"home_ic_selected"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"home_ic_select"] forState:UIControlStateNormal];
        }
        
    }
    
    return cell;
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.MJDatas.count) {

    PayCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
    PayCell *cell2 = [tableView cellForRowAtIndexPath:_indexPath];
    PayModel *mod1 = self.MJDatas[indexPath.row];
    PayModel *mod2 = self.MJDatas[_indexPath.row];
    mod2.isSelect = NO;
    mod1.isSelect = YES;
  
    [cell1.btn1 setBackgroundImage:[UIImage imageNamed:@"home_ic_selected"] forState:UIControlStateNormal];
    [cell2.btn1 setBackgroundImage:[UIImage imageNamed:@"home_ic_select"] forState:UIControlStateNormal];
        _indexPath = indexPath;
    }

    
}



@end
