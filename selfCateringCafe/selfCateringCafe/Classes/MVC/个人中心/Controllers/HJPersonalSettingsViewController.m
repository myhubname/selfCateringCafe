//
//  HJPersonalSettingsViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/18.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJPersonalSettingsViewController.h"
#import "HJAddressViewController.h"
#import "HJChangePasswordViewController.h"
#import "HJUploadQRCodeViewController.h"
@interface HJPersonalSettingsViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/**列表*/
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 字典 */
@property (nonatomic,copy) NSDictionary *dic;

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;

/** 头像  */
@property (nonatomic,strong) UIImageView *iconImageView;

/** ispaypass */
@property (nonatomic,copy) NSString *ispaypass;

@end

@implementation HJPersonalSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"个人设置";
    
    
    [self.view addSubview:self.tableView];
    
    [self getData];
}

#pragma mark-获取数据
-(void)getData
{
    [HUDManager showLoading];

    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        //创建信号量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userid"] = userDefaultGet(userid);
        [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/CenterInfo" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {

            if (result.isSucess) {
                
                self.dic = result.data;
                
                [self.iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,result.data[@"userface"]]] placeholder:kGetImage(@"UserPlaceIcon")];
                
                if ([result.data[@"weixin"] length] == 0) {
                    
                    self.dataArray = @[@[@"用户",@"手机号码",@"绑定微信号"],@[@"收款码",@"收货地址",@"绑定银行卡",@"支付密码管理"]];
                    
                }else
                {
                    self.dataArray = @[@[@"用户",@"手机号码",@"微信号"],@[@"收款码",@"收货地址",@"绑定银行卡",@"支付密码管理"]];
                }
                
            }
            //          设置一个网络请求 ，无论成功或者失败发送信号量：
            dispatch_semaphore_signal(semaphore);
            
        } Faild:^(NSError * _Nonnull error) {
            
            dispatch_semaphore_signal(semaphore);

        }];
        
        // 在网络请求任务成功之前，信号量等待中
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // 创建信号量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

        [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/payPassState" params:@{@"userid":userDefaultGet(userid)}.mutableCopy sucessBlock:^(HJNetWorkModel * _Nonnull result) {
            if (result.isSucess) {
                
                self.ispaypass = result.data[@"ispaypass"];
                
            }
            dispatch_semaphore_signal(semaphore);

        } Faild:^(NSError * _Nonnull error) {
           
            dispatch_semaphore_signal(semaphore);

        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //回到主线程刷新
            
            [self.tableView reloadData];
            
            [HUDManager hidenHud];
            
        });
    });
    
}

#pragma mark-创建列表
-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(1);
            make.bottom.offset(0);
        }];
        
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"用户"]) {
     
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        [cell.contentView addSubview:self.iconImageView];
        
    }else if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"手机号码"])
    {
        cell.detailTextLabel.text = self.dic[@"user"];
    }else if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"微信号"])
    {
        cell.detailTextLabel.text = self.dic[@"weixin"];
    }else if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"支付密码管理"])
    {
        if ([self.ispaypass integerValue] == 0) {
            
            cell.detailTextLabel.text = @"未设置";
        }else
        {
            cell.detailTextLabel.text = @"已设置";
        }
        
    }else if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"收款码"])
    {
        if ([self.dic[@"paycode"] length] == 0) {
            
            cell.detailTextLabel.text = @"未设置";
            
        }else
        {
            cell.detailTextLabel.text = @"已设置";
        }
        
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"用户"]) {
        
        return 100;
    }else
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"用户"]) {

        [self sheetAlertVcNoTitleAndMessage:[UIColor blackColor] bottomBlock:^(id action) {
            
        } BottomTitle:@"取消" TopTitle:@"相机" TopTitleColor:[UIColor blackColor] topBlock:^(id action) {
            
            [self openCamera];
            
        } secondTitle:@"从相册中选择" secondColor:[UIColor blackColor] secondBlock:^(id action) {
            
            [self openPhotoLibrary];
        }];
        
    }else if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"收货地址"])
    {
        HJAddressViewController *addressVc = [[HJAddressViewController alloc] init];
        [self.navigationController pushViewController:addressVc animated:YES];

    }else if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"支付密码管理"])
    {
        HJChangePasswordViewController *changePasswordVc = [[HJChangePasswordViewController alloc] init];
        changePasswordVc.type = self.ispaypass;
        [self.navigationController pushViewController:changePasswordVc animated:YES];
    
    }else if ([self.dataArray[indexPath.section][indexPath.row] isEqualToString:@"收款码"])
    {
        HJUploadQRCodeViewController *uploadVc = [[HJUploadQRCodeViewController alloc] init];
        uploadVc.paycode = self.dic[@"paycode"];
        __weak typeof(self)weakself = self;
        uploadVc.uploadSucessBlock = ^(NSString * _Nonnull imageStr) {
          
            [HUDManager showLoading];
            NSMutableDictionary *faceDic = [NSMutableDictionary dictionary];
            faceDic[@"modField"] = @"paycode";
            faceDic[@"modVal"] = imageStr;
            faceDic[@"userid"] = userDefaultGet(userid);
            [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/modUser" params:faceDic sucessBlock:^(HJNetWorkModel * _Nonnull result) {
                if (result.isSucess) {
                    
                    [HUDManager showStateHud:@"修改成功" state:HUDStateTypeSuccess];
                    
                    [weakself getData];
                    
                }
            } Faild:^(NSError * _Nonnull error) {
                
            }];
            
        };
        
        [self.navigationController pushViewController:uploadVc animated:YES];
    }
    
}

/**
 
 *  调用照相机
 
 */

- (void)openCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = YES; //可编辑
    
    //判断是否可以打开照相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //摄像头
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
    else
        
    {
        
        NSLog(@"没有摄像头");
        
    }
}

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
         
            NSMutableDictionary *faceDic = [NSMutableDictionary dictionary];
            faceDic[@"modField"] = @"userface";
            faceDic[@"modVal"] = [NSString stringWithFormat:@"%@",result.data[@"pic"]];
            faceDic[@"userid"] = userDefaultGet(userid);
            [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/modUser" params:faceDic sucessBlock:^(HJNetWorkModel * _Nonnull result) {
                if (result.isSucess) {

                    [HUDManager showStateHud:@"修改成功" state:HUDStateTypeSuccess];

                    weakself.iconImageView.image = image;
                    
                }
            } Faild:^(NSError * _Nonnull error) {

            }];
        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
    
    
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark-头像
-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-75, 15, 60, 60)];
        _iconImageView.layer.cornerRadius = 30.0f;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}




@end
