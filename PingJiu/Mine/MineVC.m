//
//  MineVC.m
//  Beauvigno
//
//  Created by 小熊 on 2017/8/21.
//  Copyright © 2017年 小熊. All rights reserved.
//

#import "MineVC.h"
#import "SheZhiVC.h"
@interface MineVC ()



/** 收货地址 */
@property (weak, nonatomic) IBOutlet EEView *shouhuodizhiView;

/** 优惠券 */
@property (weak, nonatomic) IBOutlet EEView *youhuiquanView;
/** 设置 */
@property (weak, nonatomic) IBOutlet EEView *shezhiView;
/** 在线客服 */
@property (weak, nonatomic) IBOutlet EEView *zaixiankefuView;
/** 订单5个view superview */
@property (weak, nonatomic) IBOutlet UIStackView *orderStackView;
/*我的订单View*/
@property (weak, nonatomic) IBOutlet EEView *myOrderView;



/** 设置阴影view */
@property (weak, nonatomic) IBOutlet UIView *shadowView1;
/** 头像view */
@property (weak, nonatomic) IBOutlet EEImageView *iconView;
/** 昵称LB */
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
/** 邀请码LB */
@property (weak, nonatomic) IBOutlet UILabel *codeLB;
/** 推荐人LB */
@property (weak, nonatomic) IBOutlet UILabel *recLB;

@property (weak, nonatomic) IBOutlet EEView *headView;

@property (strong, nonatomic) IBOutlet UIView *erWeiMaView; //二维码View
@property (weak, nonatomic) IBOutlet UIImageView *eWMHeardImageView;

@property (weak, nonatomic) IBOutlet UILabel *eWMName; //二维码弹窗用户名字
@property (weak, nonatomic) IBOutlet UILabel *eWMCode; //二维码邀请码

@property (weak, nonatomic) IBOutlet UIImageView *eWMImageView; //二维码生成的图片

@property (weak, nonatomic) IBOutlet UILabel *telPhoneLb;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MineVC
{
    UIView *_backView;//黑色阴影部分

}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.isSecondDidAppear) {
        [self refreshUI];
    }
    [super viewDidAppear:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self configNotification];
    [self configUI];
    [self refreshUI];
    
    _telPhoneLb.text = @"0733-66778";
    [self configMJRefresh];
   // [self getTheCall];
//    [self configMultiTabDatas];
//    [self configMJRefresh];
}
#pragma mark 上下拉
- (void)configMJRefresh
{
    
    MJWeakSelf;
    if (_telPhoneLb.text.length == 0) {
        MJRefreshNormalHeader *head = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getTheCall];
        }];
        _scrollView.mj_header = head;
        
       // [_scrollView.mj_header beginRefreshing];
    }
    else
    {
        [_scrollView.mj_header endRefreshing];
    }
    
}
        
- (void)getTheCall
{
    MJWeakSelf;
    [self get3_URL:SYSURL@"api/service/kefu_phone" parameters:nil success:^(NSDictionary *dic) {
        
        if (![dic[@"data"] isKindOfClass:[NSNull class]]) {
            weakSelf.telPhoneLb.text = dic[@"data"];
        }
        else
        {
        weakSelf.telPhoneLb.text  = @"";
        }
        
        [weakSelf.scrollView.mj_header endRefreshing];
        
    } elseAction:^(NSDictionary *dic) {
        [weakSelf.scrollView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [weakSelf.scrollView.mj_header endRefreshing];
    }];
}

#pragma mark 配置UI
- (void)configUI
{
    MJWeakSelf
    //=========== 设置阴影 ===========
    _shadowView1.layer.shadowColor = [ThemeColor colorWithAlphaComponent:0.5].CGColor;
    _shadowView1.layer.shadowOffset = CGSizeMake(0, 5);// 向右下偏移量
    _shadowView1.layer.shadowOpacity = 1;
    _shadowView1.layer.shadowRadius = 3;//改成8 很好看
    
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - 50)];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.6;
    [self.view addSubview:_backView];
    _erWeiMaView.frame = CGRectMake((Width * (1-0.75)) / 2.0, (Height - ((Width * 0.75) * 1.15)) / 2.0, Width * 0.75,(Width * 0.75) * 1.15);

    [self.view addSubview:_erWeiMaView];
    
    _backView.hidden = YES;
    _erWeiMaView.hidden = YES;
    _erWeiMaView.layer.cornerRadius = 4;
    _eWMImageView.image = [self qrImageForString:@"" imageSize:Width * 0.75 * 0.459 logoImageSize:Width * 0.75 * 0.459];
   
    _eWMHeardImageView.layer.cornerRadius = (Width * 0.75 * 0.2) /2.0;
    SetImageViewImageWithURL_C(_eWMHeardImageView, USER.headImg, IconHolderName);
    _eWMName.text = @"999";
    _eWMCode.text = [NSString stringWithFormat:@"我的邀请码：%@",USER.ID];
   
    #pragma mark 配置按钮功能
    {
        //=========== 5个订单按钮 ===========
        for (EEView *view in _orderStackView.subviews) {
            NSInteger tag = view.tag;
            

            [view setClickEvent:^{

                if (USER.isLogin) {
                    [MyOrderVC showTheMyOrderVC:tag - 100 + 1];
                }
                else{
                    [Worker gotoLoginIfNotLogin];
                }
                
            }];
            
            
            
        }
        
        // 全部订单
        [_myOrderView setClickEvent:^{
         if (USER.isLogin) {
            [MyOrderVC showTheMyOrderVC:0];
          }
         else{
             [Worker gotoLoginIfNotLogin];
         }
        }];
        


//        //我的收货地址
        [_shouhuodizhiView setClickEvent:^{
          if (USER.isLogin) {
            [MyAddressVC showTheMyAddressVC:100];
          }
          else{
              [Worker gotoLoginIfNotLogin];
          }
        }];

       //设置
        [_shezhiView setClickEvent:^{
          if (USER.isLogin) {
            SheZhiVC *sheZhi = [Worker MainSB:@"SheZhiVC"];
            [weakSelf.navigationController pushViewController:sheZhi animated:YES];
           }
          else{
             [Worker gotoLoginIfNotLogin];
           }
        }];
        [_headView setClickEvent:^{
            if (USER.isLogin) {
            [UserInfoVC showTheUserInfoVC];
            }
            else{
                [Worker gotoLoginIfNotLogin];
            }
        }];

        //在线客服
        MJWeakSelf;
        [_zaixiankefuView   setClickEvent:^{
            if (USER.isLogin) {
            if (weakSelf.telPhoneLb.text.length > 0) {
                [self onCallTel:weakSelf.telPhoneLb.text];
            }
            }
            else{
                [Worker gotoLoginIfNotLogin];
            }
        }];

    }
    
}

#pragma mark 客服打电话
- (void)onCallTel:(NSString *)tel
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}

#pragma mark 刷新UI
- (void)refreshUI
{
    _nameLB.text = USER.userName;
    _codeLB.text = [NSString stringWithFormat:@"我的邀请码：%@",USER.ID];
   // _recLB.text = [NSString stringWithFormat:@"推荐人：%@", USER.referName ? Mine.referName : @"无"];
 //   _tianxietuijianrenBtn.hidden = USER.referName;
    SetImageViewImageWithURL_C(_iconView, USER.headImg, IconHolderName)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hiddenTheErWeiMaTanChuang:(UIButton *)sender {
    
    _backView.hidden = YES;
    _erWeiMaView.hidden = YES;
}



//=============二维码
#pragma mark 生成二维码
- (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    CIImage *outPutImage = [filter outputImage];//拿到二维码图片
    return [self createNonInterpolatedUIImageFormCIImage:outPutImage withSize:Imagesize waterImageSize:waterImagesize];
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size waterImageSize:(CGFloat)waterImagesize{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    //logo图
    UIImage *waterimage = [UIImage imageNamed:@"icon_imgApp"];
    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    [waterimage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

#pragma mark QQ客服
- (void)connectTheQQ:(NSString *)qqContent andTheString:(NSString *)tishi
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]] ) {
        
        if (qqContent.length > 0) {
            //在此跟改客服QQ
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            NSString *qqstr = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqContent];
            NSURL *url = [NSURL URLWithString:qqstr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [webView loadRequest:request];
            [self.view addSubview:webView];
            
        }
        else
        {
            [MBProgressHUD showMessag:tishi toView:Window];
        }
        
        
    }
    else
    {
        [MBProgressHUD showMessag:@"没有安装QQ客户端" toView:Window];
    }
}

@end
