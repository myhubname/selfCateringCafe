//
//  HJRigistViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJRigistViewController.h"
#import "HJTexfLineImageTableViewCell.h"
#import "UIButton+CountDown.h"
#import "HJBaseWebViewController.h"
@interface HJRigistViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 数组 */
@property (nonatomic,strong) NSArray *dataArray;

/** 按钮 */
@property (nonatomic,strong) UIButton *codeBtn;

/** 验证码View */
@property (nonatomic,strong) UIView *codeView;

/** 同意 */
@property (nonatomic,weak) UIButton *agreeBtn;

@end

@implementation HJRigistViewController

-(NSArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = @[@{@"image":@"phonIcon",@"placehodel":@"请输入手机号",@"text":@""}.mutableCopy,@{@"image":@"passwordIcon",@"placehodel":@"请输入密码",@"text":@""}.mutableCopy,@{@"image":@"VerificationIcon",@"placehodel":@"请输入验证码",@"text":@""}.mutableCopy,@{@"image":@"InvitationIcon",@"placehodel":@"邀请码（必填）",@"text":@""}.mutableCopy];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.customNavBar wr_setBackgroundAlpha:0.0];
    
    [self.customNavBar wr_setLeftButtonWithImage:kGetImage(@"returnBack")];
    
    self.customNavBar.title = @"注册";

    [self.customNavBar setTitleLabelColor:[UIColor blackColor]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];

    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
}

-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        UIImageView *loginImageView = [[UIImageView alloc] initWithImage:kGetImage(@"logoIcon")];
        [headerView addSubview:loginImageView];
        [loginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(122);
            make.centerX.offset(0);
            make.centerY.offset(TopHeight/2);
        }];
        _tableView.tableHeaderView = headerView;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        
        HJLayoutBtn *AgreementBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
        [AgreementBtn setImage:kGetImage(@"AgreeNomer") forState:UIControlStateNormal];
        [AgreementBtn setImage:kGetImage(@"AgreeSel") forState:UIControlStateSelected];
        AgreementBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [AgreementBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [AgreementBtn addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:AgreementBtn];
        [AgreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(30);
            make.top.offset(15);
        }];
        AgreementBtn.selected = YES;
        self.agreeBtn = AgreementBtn;
        
        UILabel *pinTaiLabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
        pinTaiLabel.text = @"《平台注册协议》";
        pinTaiLabel.userInteractionEnabled = YES;
        [footerView addSubview:pinTaiLabel];
        [pinTaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(AgreementBtn.mas_right).offset(0);
            make.centerY.equalTo(AgreementBtn.mas_centerY);
        }];
        __weak typeof(self)weakself = self;
        [pinTaiLabel addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
           
            HJBaseWebViewController *webVc = [[HJBaseWebViewController alloc] init];
            webVc.customNavBar.title =@"《平台注册协议》";
            webVc.urlStr = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApiPrefix,@"Mobile/Index/service.html"]];
            [weakself.navigationController pushViewController:webVc animated:YES];
        }];
        
        
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#ff5846"]];
        [loginBtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(30);
            make.right.offset(-30);
            make.height.offset(45);
            make.centerY.offset(0);
        }];
        loginBtn.layer.cornerRadius = 22.5f;
        loginBtn.layer.masksToBounds = YES;
        
        
        
        _tableView.tableFooterView = footerView;
        
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    HJTexfLineImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJTexfLineImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    [cell.leftAlertBtn setImage:kGetImage(self.dataArray[indexPath.row][@"image"]) forState:UIControlStateNormal];
    
    cell.texf.placeholder = self.dataArray[indexPath.row][@"placehodel"];
    
    cell.changeBlock = ^(UITextField * _Nonnull texf) {
  
        [self.dataArray[indexPath.row] setObject:texf.text forKey:@"text"];
   
    };
    if (indexPath.row == 2) {
        
        cell.texf.rightView = self.codeView;
        cell.texf.rightViewMode = UITextFieldViewModeAlways;
    }else if (indexPath.row == 1)
    {
        cell.texf.secureTextEntry = YES;
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark-注册
-(void)registClick
{
    if (self.agreeBtn.selected == YES) {
        
        if ([self.dataArray[0][@"text"] length] == 0) {
            
            [HUDManager showStateHud:@"请输入手机号" state:HUDStateTypeFail];
            return;
        }else if ([self.dataArray[1][@"text"] length] == 0)
        {
            [HUDManager showStateHud:@"请输入密码" state:HUDStateTypeFail];
            
            return;
        }else if ([self.dataArray[2][@"text"] length] == 0)
        {
            [HUDManager showStateHud:@"请输入验证码" state:HUDStateTypeFail];
            return;
        }else
        {
            [HUDManager showLoadingHud:@"正在注册..."];
            
            NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
            parmas[@"phone"] = self.dataArray[0][@"text"];
            parmas[@"pass"] = [self.dataArray[1][@"text"] md5String];
            parmas[@"code"] = self.dataArray[2][@"text"];
            parmas[@"parent_id"] = self.dataArray[3][@"text"];
            [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/Register/create" params:parmas sucessBlock:^(HJNetWorkModel * _Nonnull result) {
                if (result.isSucess) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    userDefaultSave(result.data[@"userid"], userid);
                    
                    [HUDManager showStateHud:@"注册成功" state:HUDStateTypeSuccess];
                    
                }
            } Faild:^(NSError * _Nonnull error) {
                
            }];
        }
        
    }else
    {
        [HUDManager showStateHud:@"请同意平台协议" state:HUDStateTypeFail];
    }
    
}
#pragma mark-获取验证码
-(void)codeClick:(UIButton *)sender
{
    if ([self.dataArray[0][@"text"] length] == 0) {
        
        [HUDManager showStateHud:@"请输入手机号" state:HUDStateTypeFail];
        
        return;
    }
    [HUDManager showLoadingHud:@"获取验证码..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.dataArray[0][@"text"];
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/Register/getRegVerifCode" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            [HUDManager hidenHud];
            [sender startWithTime:59.0 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
    

}

-(UIButton *)codeBtn
{
    if (!_codeBtn) {
        
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
        [_codeBtn setTitleColor:[UIColor colorWithHexString:@"#fd4640"] forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _codeBtn.layer.borderWidth = 1.0f;
        _codeBtn.layer.borderColor = [UIColor colorWithHexString:@"#fd4640"].CGColor;
        _codeBtn.layer.masksToBounds = YES;
        _codeBtn.layer.cornerRadius = 20.0f;
    }
    return _codeBtn;
}

-(UIView *)codeView
{
    if (!_codeView) {
        
        _codeView = [[UIView alloc] init];
        _codeView.size = CGSizeMake(120, 50);
        [_codeView addSubview:self.codeBtn];
        [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);
            make.width.offset(100);
            make.height.offset(40);
        }];
    }
    return _codeView;
}

-(void)agreeClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
}
@end
