//
//  AddNewAddressVC.m
//  JunJie
//
//  Created by 小熊 on 2018/2/23.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "AddNewAddressVC.h"

@interface AddNewAddressVC ()<UITextViewDelegate,UITextFieldDelegate,NavViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextField *textF1; //收件人姓名
@property (weak, nonatomic) IBOutlet UITextField *textF2; //收件人号码
@property (weak, nonatomic) IBOutlet UITextField *textF3;
//@property (weak, nonatomic) IBOutlet EETextView *textvVew3;

@property (weak, nonatomic) IBOutlet UILabel *remberLb; //提示



@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end

@implementation AddNewAddressVC
{
    NSString *_consignee; //收货人
    NSString *_phone;//收货人电话
//    NSString *_area; //省
//    NSString *_addressDetail; //地址详情
    
    
    
}

- (void)right
{
    [self.view endEditing:YES];
    [self onSure];
}

- (void)onSure
{
    if (_textF1.text.length != 0 && _textF2.text.length != 0 &&
        _textF3.text.length != 0 && _textView1.text.length != 0 ) {
        
       // if ([Worker isMobileNumber:_textF2.text]) {
            [self addTheNewAddrss];
//        }
//        else
//        {
//            [MBProgressHUD showMessag:@"输入的号码不正确" toView:Window];
//        }
        
    }
    else
    {
        [MBProgressHUD showMessag:@"请将数据填写完整" toView:Window];
    }
}

#pragma mark 确认添加新地址接口
- (void)addTheNewAddrss
{

    
    
    NSDictionary *parameters;
    //新增地址，从我的地址进入
 
    if (_diff ==200) {
        parameters = @{
                       @"id":_model.ID,
                       @"name":_textF1.text,
                       @"phone":_textF2.text,
                       @"area":_textF3.text,
                       @"address":_textView1.text,

                       };
        
    }
    
    else{
        parameters = @{
                       @"name":_textF1.text,
                       @"phone":_textF2.text,
                       @"area":_textF3.text,
                       @"address":_textView1.text,
                       
                       };
    }
   // [self post1_URL:BASEURL@"api/user/add_address" parameters:parameters success:^(NSDictionary *dic) {
        
        
        [MBProgressHUD showMessag:@"添加成功" toView:Window];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshAddress" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
   // } elseAction:nil failure:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nav.backgroundColor = ThemeColor;
    [self.nav setTitle:@"添加新地址" leftText:nil rightTitle:@"保存" showBackImg:YES];
    _view1.layer.cornerRadius = 4;
    _view1.layer.borderWidth = 1;
    _view1.layer.borderColor = HexColor(0xe8e8e8).CGColor;
    _textF3.borderStyle = UITextBorderStyleNone;
  
    if (_diff == 200) { //编辑收货地址
        [self.nav setTitle:@"编辑收货地址" leftText:nil rightTitle:@"保存" showBackImg:YES];
        _textF1.text = _model.name;
        _textF2.text = _model.phone;
        _textF3.text = _model.area;
        
        _textView1.text = _model.address;

        
//        _area = _model.area;
//        _addressDetail = _model.address;

        
    }
    else{
        
        [self.nav setTitle:@"添加新地址" leftText:nil rightTitle:@"保存" showBackImg:YES];
        
        
    }
    
    
    
    
    
   // self.keepNotificationWhenDisappear = YES;
    self.nav.delegate = self;
    
    _textF1.borderStyle = UITextBorderStyleNone;
    _textF2.borderStyle = UITextBorderStyleNone;
    
    if (_textView1.text.length > 0) {
        _remberLb.hidden = YES;
    }
    else
    {
        _remberLb.hidden = NO;
    }
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTheAddress:) name:@"slectedAddress" object:nil];
    
}
#pragma mark 通知获取选取地址设置数据
- (void)refreshTheAddress:(NSNotification *)note
{
    
    
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:note.userInfo];
    _textF3.text = [NSString stringWithFormat:@"%@%@",dic[@"province"],dic[@"city"]];
   
    
    //_area = [NSString stringWithFormat:@"%@%@",dic[@"province"],dic[@"city"]] ;
    //_addressDetail = dic[@"address"];
    
    
    if ([dic[@"address"] length] != 0) {
        _textView1.text = dic[@"address"];
        _remberLb.hidden = YES;
        
    }
    else
    {
      _textView1.text = @"";
      _remberLb.hidden = NO;
    }
    
    
}

#pragma mark 跳转到地图
- (IBAction)onMAp:(UIButton *)sender {
//    MyMapVC *map = [Worker MainSB:@"MyMapVC"];
//    [self.navigationController pushViewController:map  animated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 跳转到地图
- (IBAction)jumpToMyMap:(UIButton *)sender {
    
//    MyMapVC *map = [Worker MainSB:@"MyMapVC"];
//    [self.navigationController pushViewController:map  animated:YES];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark
- (void)textViewDidChange:(UITextView *)textView
{
    if ([_textView1.text length] == 0) {
        [_remberLb setHidden:NO];
    }
    else{
        
        [_remberLb setHidden:YES];
    }
    
    
    
    if (textView.tag == 10) {
        CGRect frame = textView.frame;
        float  height = [ self heightForTextView:textView WithText:textView.text];
        frame.size.height = height;
        _viewHeight.constant = height + 297;
    }
    
}



- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width , CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                        context:nil];
    float textHeight = size.size.height + 16.0;
    return textHeight;
}






@end
