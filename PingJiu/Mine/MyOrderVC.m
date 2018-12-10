//
//  MyOrderVC.m
//  PingJiu
//
//  Created by 小熊 on 2018/11/30.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "MyOrderVC.h"

@interface MyOrderVC ()
@property (weak, nonatomic) IBOutlet EETableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (nonatomic,strong) UIButton *orgilBtn;
@end

@implementation MyOrderVC
+(void)showTheMyOrderVC:(NSInteger)tag
{
    MyOrderVC *order = [Worker MainSB:@"MyOrderVC"];
    order.diff = tag;
    [Worker showVC:order];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.nav.backgroundColor = ThemeColor;
    [self.nav setTitle:@"设置" leftText:nil rightTitle:nil showBackImg:YES];
    self.nav.delegate = self;
    [self confiTheView];
    
}

- (void)confiTheView
{
    [_btn1 setTitleColor:ThemeColor forState:UIControlStateNormal];
    _orgilBtn = _btn1;
    if (_diff == 5) {
        _btn1.hidden = NO;
        _btn2.hidden = YES;
        _btn3.hidden = YES;
        _btn4.hidden = YES;
        _btn5.hidden = YES;
        [_btn1 setTitleColor:ThemeColor forState:UIControlStateNormal];
        [_btn1 setTitle:@"退换/售后" forState:UIControlStateNormal];
        
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
    return 0;
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)onClick:(UIButton *)sender {
    
    if (sender != _orgilBtn) {
        [sender setTitleColor:ThemeColor forState:UIControlStateNormal];
        [_orgilBtn setTitleColor:HexColor(0x333333) forState:UIControlStateNormal];
        _orgilBtn = sender;
    }
}


@end
