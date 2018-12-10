//
//  UserInfoVC.m
//  Beauvigno
//
//  Created by 橙晓侯 on 2017/9/7.
//  Copyright © 2017年 小熊. All rights reserved.
//

#import "UserInfoVC.h"
#import "UploadObj.h"
@interface UserInfoVC ()
@property (weak, nonatomic) IBOutlet EEImageView *iconView;
@property (weak, nonatomic) IBOutlet EETextField *nameTF;
@property (weak, nonatomic) IBOutlet UILabel *sexLB;
@property (weak, nonatomic) IBOutlet EEView *sexView;
/** 上传的头像 */
@property (strong, nonatomic) UploadObj *iconObj;
@end

@implementation UserInfoVC

+ (void)showTheUserInfoVC
{
    UserInfoVC *userInfo = [Worker MainSB:@"UserInfoVC"];
    [Worker showVC:userInfo];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self refreshUI];
}

//#pragma mark 请求用户信息
//- (void)requestUserInfo
//{
//    MJWeakSelf
//    [self get3_URL:BASEURL@"api/user/userInfo"
//        parameters:nil
//           success:^(NSDictionary *dic) {
//               
//               [Mine mj_setKeyValues:dic[@"data"]];
//               [weakSelf refreshUI];
//               
//           } elseAction:nil failure:nil];
//}

#pragma mark 配置UI
- (void)configUI
{
    MJWeakSelf
    // 取头像对象
    _iconObj = [[UploadObj alloc] initWithURL:USER.headImg isUploaded:1];
    [_iconView setClickEvent:^{
    
        
        [[VDCameraAndPhotoTool shareInstance] showImagePickerWithFinishBack:^(UIImage *image, NSString *videoPath) {
            
            weakSelf.iconView.image = image;
//            [OSSImageUploader uploadImages:@[image] success:^(NSArray<NSString *> *names) {
//
//                weakSelf.iconObj.uploadURL = names[0];
//            } failure:nil];
            
        } cutRatio:1];
    }];
    
    [_sexView setClickEvent:^{
        
        //========================== 性别 Alert ==========================
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"选择性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            weakSelf.sexLB.text = @"男";
        }]];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            weakSelf.sexLB.text = @"女";
        }]];
        [self presentViewController:ac animated:YES completion:nil];
        //========================== === ==========================
    }];
}

#pragma mark 刷新UI
- (void)refreshUI
{
    SetImageViewImageWithURL_C(_iconView, USER.headImg, IconHolderName)
    _nameTF.text = USER.userName;
    if ([USER.sex integerValue] == 0) {
        _sexLB.text = @"男";
    }
    if ([USER.sex integerValue] == 1) {
        _sexLB.text = @"女";
    }
}

- (void)right
{
    if (!_nameTF.hasText) {
        
        [MBProgressHUD showMessage:@"请输入昵称" toView:Window];
        return;// 拦截 ---------------------------------------
    }
    int sex = [_sexLB.text isEqualToString:@"男"] ? 0 : 1;
//    [self post2_URL:BASEURL@"api/user/updateUser"
//         parameters:@{
//                      @"name":_nameTF.text,
//                      @"sex":@(sex),
//                      @"headImg":_iconObj.uploadURL,
//                      }
//            success:^(NSDictionary *dic) {
    
              //  [USER mj_setKeyValues:dic[@"data"]];
              USER.headImg = _iconObj.uploadURL;
    USER.nickName = _nameTF.text;
    USER.userName = _nameTF.text;
    USER.sex = [NSString stringWithFormat:@"%@",@(sex)];
                [self.navigationController popViewControllerAnimated:YES];
                
          //  } elseAction:nil failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
