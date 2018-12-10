//
//  MyAddressVC.m
//  JunJie
//
//  Created by 小熊 on 2017/2/23.
//  Copyright © 2017年 小熊. All rights reserved.
//

#import "MyAddressVC.h"
#import "AddNewAddressVC.h"
@interface MyAddressVC ()<UITableViewDataSource,UITableViewDelegate,NavViewDelegate>
@property (weak, nonatomic) IBOutlet EETableView *tableView;


@end

@implementation MyAddressVC
{
    NSInteger _currentPage; //当前页数
    NSInteger _pageSize; //一页获取多少个数
    
    NSInteger first;  //判断是否是第一次添加地址 1是 0 否
   // NSDictionary *_dics; //通知传的数据
   // BOOL _isClickMoRen; //判断是否点击默认，来取决返回时是否刷新
    NSString *addressId;
    NSMutableArray *_MJDatas;
    NSInteger _defTag;
}

+(void)showTheMyAddressVC:(NSInteger)diff
{
    MyAddressVC *adr = [Worker MainSB:@"MyAddressVC"];
    adr.diff = diff;
    [Worker showVC:adr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.nav.backgroundColor = ThemeColor;
    [self.nav setTitle:@"管理收货地址" leftText:nil rightTitle:nil showBackImg:YES];
    self.nav.delegate = self;
    _currentPage = 1;
    _pageSize = 10;
 
    [self configMJRefresh];
    
   // self.keepNotificationWhenDisappear = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRefrsh:) name:@"refreshAddress" object:nil];
    
}


- (void)onRefrsh:(NSNotification *)note
{
    [_tableView.mj_header beginRefreshing];
}

- (void)left
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)configMJRefresh
{
     __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *head = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (!_MJDatas){_MJDatas = [NSMutableArray array];}
        else{[_MJDatas removeAllObjects];}

        _currentPage = 1;
        [weakSelf getTheMyadressDatas];
    }];
    _tableView.mj_header = head;
  

    // 立即执行
    [_tableView.mj_header beginRefreshing];
}



- (void)getTheMyadressDatas
{
    
    MJWeakSelf;
    [self getMJ_URL:SYSURL@"api/user/address" parameters:nil success:^(NSDictionary *dic) {
       
       
       
       if (![dic[@"data"] isKindOfClass:[NSNull class]]) {
           if ([dic[@"data"] count] > 0) {
               for (NSDictionary *temp in dic[@"data"])
               {
                   
                   
                   address *mod = [address mj_objectWithKeyValues:temp];
                   [_MJDatas addObject:mod];
               }
               
               if (_MJDatas.count == 0) {
                   first = 1;
               }
               else
               {
                   first = 0;
               }
               
               [weakSelf.tableView.mj_footer endRefreshing];
           }
           else
           {
               [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
           }
       
       
       }
       else
       {
         [weakSelf.tableView.mj_footer endRefreshing];
       }
       [weakSelf.tableView.mj_header endRefreshing];
       
       [weakSelf.tableView reloadData];
       
   } elseAction:^(NSDictionary *dic) {
       [weakSelf.tableView.mj_header endRefreshing];
       [weakSelf.tableView.mj_footer endRefreshing];
       [weakSelf.tableView reloadData];
       
   } failure:^(NSError *error) {
       [weakSelf.tableView.mj_header endRefreshing];
       [weakSelf.tableView.mj_footer endRefreshing];
       [weakSelf.tableView reloadData];
       
   } tableView:nil];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ......::::::: UITableViewDataSource :::::::......

#pragma mark TV段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _MJDatas.count;
}
#pragma mark TV行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && _MJDatas.count > 0) {
        return 2;
    }
    else
    {
    return 1;
    }
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  

            
            if (indexPath.section == 0 && indexPath.row == 0) {
                TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"地址管理cell3" forIndexPath:indexPath];
                return cell;
            }
            else
            {
            
            
            TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"地址管理cell1" forIndexPath:indexPath];
            
            if (_MJDatas.count != 0) {
                address *adr = _MJDatas[indexPath.section];
                
                
                cell.label1.text = adr.name;
                cell.label2.text = adr.phone;
                cell.label3.text = [NSString stringWithFormat:@"%@%@",adr.area,adr.address];
               
                if (adr.def) {
                    _defTag = indexPath.section;
                    [cell.btn1 setTitleColor:HexColor(0Xf38300) forState:UIControlStateNormal];
                    [cell.btn1 setTitle:@"默认地址" forState:UIControlStateNormal];
                    [cell.btn6 setBackgroundImage:[UIImage imageNamed:@"wdshdz_btn_checkbox_selected"] forState:UIControlStateNormal];
                    
                }
                else
                {
                    [cell.btn1 setTitleColor:HexColor(0X666666) forState:UIControlStateNormal];
                    [cell.btn1 setTitle:@"设为默认" forState:UIControlStateNormal];
                    //设置默认的按钮
                    cell.btn7.tag = indexPath.section;
                    [cell.btn7 addTarget:self action:@selector(sheZhiMoRen:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.btn6 setBackgroundImage:[UIImage imageNamed:@"wdshdz_btn_checkbox_default"] forState:UIControlStateNormal];
                }
                
                
                //编辑按钮
                cell.btn2.tag = indexPath.section;
                [cell.btn2 addTarget:self action:@selector(editTheAddress:) forControlEvents:UIControlEventTouchUpInside];
                cell.btn3.tag = indexPath.section;
                [cell.btn3 addTarget:self action:@selector(editTheAddress:) forControlEvents:UIControlEventTouchUpInside];
                
                
                //删除按钮
                [cell.btn4.layer setValue:adr.ID forKey:@"idString"];
                [cell.btn5.layer setValue:adr.ID forKey:@"idString"];
                cell.btn4.tag = indexPath.section;
                
                [cell.btn4 addTarget:self action:@selector(deleteTheAddress:) forControlEvents:UIControlEventTouchUpInside];
                cell.btn5.tag = indexPath.section;
                [cell.btn5 addTarget:self action:@selector(deleteTheAddress:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            cell.view1.layer.cornerRadius = 4;
            cell.view1.layer.borderColor = HexColor(0xe8e8e8).CGColor;
            cell.view1.layer.borderWidth = 1;
            
            
            
            return cell;
            }

    
    
   
    
}



#pragma mark 设置默认
- (void)sheZhiMoRen:(UIButton *)btn
{
    address *adr = _MJDatas[btn.tag];
    if (!adr.def) {
        

        
        address *model = _MJDatas[btn.tag];
        
        
        [self postTheBtnURL:BASEURL@"api/user/set_default_address" andTheDic:@{@"id":model.ID,} andTheCaoZuoTag:btn.tag andTheCaoZuoName:@"默认"];
    }
}

#pragma mark 编辑地址
- (void)editTheAddress:(UIButton *)btn
{
    AddNewAddressVC *addnew = [Worker MainSB:@"AddNewAddressVC"];
    addnew.model = _MJDatas[btn.tag];
    addnew.diff = 200;
    addnew.status = first;
    addnew.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addnew animated:YES];
}


#pragma mark 删除地址
- (void)deleteTheAddress:(UIButton *)btn
{
    
    if (_MJDatas.count > 1) {
    [self showFunctionAlertWithTitle:nil message:@"确定删除该地址吗?" functionName:@"确定" Handler:^{
        NSString *idString = [btn.layer valueForKey:@"idString"];
        
        
            [self postTheBtnURL:BASEURL@"api/user/del_address" andTheDic:@{@"id":idString,} andTheCaoZuoTag:btn.tag andTheCaoZuoName:@"删除"];
        
    }];
    }else
    {
        [MBProgressHUD showError:@"该地址不能删除" toView:Window];
    }

}

- (IBAction)addTheNewAddress:(UIButton *)sender {

    AddNewAddressVC *addnew = [Worker MainSB:@"AddNewAddressVC"];
    addnew.diff = 100;
    addnew.status = first;

    [self.navigationController pushViewController:addnew animated:YES];
}




#pragma mark 相关按钮操作
- (void)postTheBtnURL:(NSString *)url andTheDic:(NSDictionary *)dic andTheCaoZuoTag:(NSInteger)tag andTheCaoZuoName:(NSString *)name
{
    MJWeakSelf;
    [self get1_URL:url parameters:dic success:^(NSDictionary *dic) {
        [MBProgressHUD showMessag:dic[@"msg"] toView:Window];
        
        if ([name isEqualToString:@"删除"]) {
            
            for (int i = 0; i < _MJDatas.count; i++) {
                if (i == tag) {
                    [_MJDatas removeObjectAtIndex:i];
                }
            }
            if (_MJDatas.count == 0) {
                first = 1;
            }
            else
            {
                first = 0;
            }
            
            if (_MJDatas.count > 0) {
                address *adr = _MJDatas[0];
                adr.def = YES;
            }
            
            [weakSelf.tableView reloadData];
            
        }
        else if ([name isEqualToString:@"默认"])
        {

            address *mod = _MJDatas[tag];
            addressId = mod.ID;
            mod.def = YES;
            address *modOrgil = _MJDatas[_defTag];
            modOrgil.def = NO;
          
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sheZhiMoRen" object:mod.ID userInfo:@{                                                                                                               @"address":mod
                                                                                                               
                    }];
            
            [weakSelf.tableView reloadData];
            
        }
        
        
    } elseAction:nil failure:nil];
}




#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
