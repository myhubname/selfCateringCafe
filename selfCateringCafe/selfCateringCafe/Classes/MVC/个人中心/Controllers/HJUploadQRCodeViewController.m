//
//  HJUploadQRCodeViewController.m
//  InterestingCrowdSourcing
//
//  Created by 胡俊杰 on 2020/1/9.
//  Copyright © 2020 胡俊杰. All rights reserved.
//

#import "HJUploadQRCodeViewController.h"
@interface HJUploadQRCodeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/** 图片 */
@property (nonatomic,weak) UIImageView *centerImageView;

/** 提示 */
@property (nonatomic,weak) UILabel *alertLabel;

@end

@implementation HJUploadQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"上传收款码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
    
    if (self.paycode.length == 0) {
        
        self.alertLabel.hidden = NO;
    }else
    {
        self.alertLabel.hidden = YES;
        [self.centerImageView setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,self.paycode]]];
    }
}

-(void)creatUI
{
    
    UIImageView *centerImageView = [[UIImageView alloc] init];
    centerImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:centerImageView];
    [centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-50);
        make.width.offset(SCREEN_WIDTH/2+30);
        make.height.offset(SCREEN_WIDTH/2 + 120);
        make.centerX.offset(0);
    }];
    self.centerImageView = centerImageView;
    
    UILabel *alertLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    alertLabel.text = @"未上传收款码";
    [centerImageView addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
    }];
    self.alertLabel = alertLabel;
    
    
    UIButton *postCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [postCodeBtn setTitle:@"上传收款码" forState:UIControlStateNormal];
    [postCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    postCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    postCodeBtn.backgroundColor = HJRGBColor(249, 87, 75);
    [postCodeBtn addTarget:self action:@selector(postImageCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postCodeBtn];
    [postCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.height.offset(45);
        make.top.equalTo(centerImageView.mas_bottom).offset(30);
    }];
    postCodeBtn.layer.cornerRadius = 22.5f;
    postCodeBtn.layer.masksToBounds = YES;
    
}
-(void)postImageCode
{
    [self openPhotoLibrary];
}
#pragma mark-打开相册
-(void)openPhotoLibrary
{
    // 进入相册
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        imagePicker.allowsEditing = YES;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
            NSLog(@"打开相册");
            
        }];
    }
    
    else
        
    {
        NSLog(@"不能打开相册");
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __weak typeof(self)weakself = self;
    [HUDManager showLoading];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pic"] = encodedImageStr;
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/Upload/uploadPic" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            weakself.centerImageView.image = image;

            weakself.alertLabel.hidden = YES;
            
            if (weakself.uploadSucessBlock) {
                
                weakself.uploadSucessBlock(result.data[@"pic"]);
            }
        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
    
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
