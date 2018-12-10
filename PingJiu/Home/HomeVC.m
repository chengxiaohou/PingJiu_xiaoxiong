//
//  HomeVC.m
//  PingJiu
//
//  Created by 小熊 on 2018/11/28.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet EETableView *tableView;
@property (nonatomic,strong) NSArray *MJDatas;
@property (nonatomic,strong) UIButton *orgilBtn;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nav setTitle:@"首页" leftText:nil rightTitle:nil showBackImg:NO];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.estimatedRowHeight = 44.0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getTheDatas:0];
    
}

- (void)getTheDatas:(NSInteger)tag
{
    if (tag ==  0) {
   
    _MJDatas = @[
        @{@"image":@"hj1",@"title":@"张裕 赤霞珠干红葡萄酒6瓶 日常配餐",@"content":@"好评率99%",@"price":@"¥ 188",@"des":@"服务承诺  破损包退  正品保证  极速退款  赠运费险",@"Lab":@[@"热销款",@"赤霞珠酿造"],@"detail":@[@"hj1_1",@"hj1_3",@"hj1_4"],@"detailImg":@"hj1_2",@"date":@"生产日期: 2017-01-01 至 2018-08-01"},
        @{@"image":@"hj2",@"title":@"法国红酒原装进口干红葡萄酒2支装波尔多",@"content":@"好评率100%",@"price":@"¥ 288",@"des":@"服务承诺  破损包退  正品保证  极速退款  赠运费险",@"Lab":@[@"口感醇厚"],@"detail":@[@"hj2_1",@"hj2_2",@"hj2_3"],@"detailImg":@"hj2_4",@"date":@"生产日期: 2017-01-01 至 2018-08-01"},
        @{@"image":@"hj3",@"title":@"经典干红葡萄酒750ml 整箱6支装国产红酒",@"content":@"好评率90%",@"price":@"¥ 599",@"des":@"38年王朝品质 老王朝的精品味道",@"Lab":@[],@"detail":@[@"hj3_1",@"hj3_2",@"hj3_3",@"hj3_4",@"hj3_5"],@"detailImg":@"hj3_6",@"date":@"生产日期: 2017-01-01 至 2018-08-01"},
                 
        @{@"image":@"hj4",@"title":@"【7仓速配】莫高冰酒冰葡萄酒甜红酒荣远冰红冰白葡萄酒整箱6支装",@"content":@"好评率90%",@"price":@"¥ 109",@"des":@"18年老树藤葡萄酿造冰酒，甜蜜好喝",@"Lab":@[@"甜美醇厚",@"优雅芬芳"],@"detail":@[@"hj4_1",@"hj4_2",@"hj4_3",@"hj4_4",@"hj4_5",@"hj4_6"],@"detailImg":@"hj4",@"date":@"生产日期: 2017-01-01 至 2018-08-01"},
       
            ];
    }
    else if (tag == 1){
        _MJDatas = @[
                     @{@"image":@"hj1",@"title":@"张裕 赤霞珠干红葡萄酒6瓶 日常配餐",@"content":@"好评率99%",@"price":@"¥ 188",@"des":@"服务承诺  破损包退  正品保证  极速退款  赠运费险",@"Lab":@[@"热销款",@"赤霞珠酿造"],@"detail":@[@"hj1_1",@"hj1_3",@"hj1_4"],@"detailImg":@"hj1_2",@"date":@"生产日期: 2017-01-01 至 2018-08-01"}];
    }
    else{
        _MJDatas = @[];
    }
    
    [_tableView reloadData];
}

- (void)requstTheURL
{
    [self get1_URL:@"" parameters:nil success:^(NSDictionary *dic) {
        
    }];
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
        return 1;
    }
    else{
    return _MJDatas.count;
    }
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        if (!_orgilBtn) {
            _orgilBtn = cell.btn1;
        }
        else{
            NSArray *arr = @[cell.btn1,cell.btn2,cell.btn3,cell.btn4];
            for (UIButton  *btn in arr) {
                if (btn == _orgilBtn) {
                    [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
                }
                else{
                    [btn setTitleColor:HexColor(0x333333) forState:UIControlStateNormal];
                }
            }
        }
        
        [cell.btn1 addTarget:self action:@selector(selectThetype:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(selectThetype:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector(selectThetype:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn4 addTarget:self action:@selector(selectThetype:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else{
        TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        NSDictionary *dic = _MJDatas[indexPath.row];
        cell.image1.image =[UIImage imageNamed:dic[@"image"]];
        cell.label1.text = dic[@"title"];
        cell.label2.text = dic[@"content"];
        cell.label3.text = dic[@"price"];
        NSArray *arr = dic[@"Lab"];
        if (arr.count > 0) {
            
            for (NSInteger i = 0; i < arr.count; i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(12 + (i * (100 + 12)), 12, 100, 30);
                [btn setTitle:arr[i] forState:UIControlStateNormal];
                btn.layer.cornerRadius = 10;
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
                [btn setBackgroundColor:[UIColor lightGrayColor]];
                [cell.tagView addSubview:btn];

            }
            
            
            cell.viewHeight.constant = 24+30;
            
        }
        return cell;
    }
    
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [SPDetailVC showTheSPDetailVC:_MJDatas[indexPath.row]];
}

- (void)selectThetype:(UIButton *)sender {
    
    if (sender != _orgilBtn) {
        _orgilBtn = sender;
        [self getTheDatas:sender.tag - 10];
    }
    
    
}


@end
