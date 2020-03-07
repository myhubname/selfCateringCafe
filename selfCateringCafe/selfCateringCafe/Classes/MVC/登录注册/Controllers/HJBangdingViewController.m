//
//  HJBangdingViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/31.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJBangdingViewController.h"
#import "HJTexfLineImageTableViewCell.h"
#import "UIButton+CountDown.h"
#import "HJBaseWebViewController.h"
@interface HJBangdingViewController ()<UITableViewDelegate,UITableViewDataSource>

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

/** 是否存在 */
@property (nonatomic,copy) NSString *isExit;


@end

@implementation HJBangdingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.customNavBar wr_setBackgroundAlpha:0.0];
    
    [self.customNavBar wr_setLeftButtonWithImage:kGetImage(@"returnBack")];
    
    self.customNavBar.title = @"绑定手机号";
    
    [self.customNavBar setTitleLabelColor:[UIColor blackColor]];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
     self.dataArray = @[@{@"image":@"phonIcon",@"placehodel":@"请输入手机号",@"text":@""}.mutableCopy,@{@"image":@"VerificationIcon",@"placehodel":@"请输入验证码",@"text":@""}.mutableCopy,@{@"image":@"passwordIcon",@"placehodel":@"请输入密码",@"text":@""}.mutableCopy,@{@"image":@"InvitationIcon",@"placehodel":@"邀请码（必填）",@"text":@""}.mutableCopy];
    
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
        [loginBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#ff5846"]];
        [loginBtn addTarget:self action:@selector(bangDingClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    if ([cell.leftAlertBtn.currentImage isEqual:[UIImage imageNamed:@"VerificationIcon"]]) {
        
        cell.texf.rightView = self.codeView;
        cell.texf.rightViewMode = UITextFieldViewModeAlways;
    }
    if ([cell.leftAlertBtn.currentImage isEqual:[UIImage imageNamed:@"passwordIcon"]]) {
        
        cell.texf.secureTextEntry = YES;
    }
    
    cell.changeBlock = ^(UITextField * _Nonnull texf) {
        
        [self.dataArray[indexPath.row] setObject:texf.text forKey:@"text"];
        
    };

    
    cell.texf.text = self.dataArray[indexPath.row][@"text"];
    

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

#pragma mark-验证码
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

-(void)codeClick:(UIButton *)sender
{
    if ([self.dataArray[0][@"text"] length] == 0) {
        
        [HUDManager showStateHud:@"请输入手机号" state:HUDStateTypeFail];
        
        return;
    }
    [HUDManager showLoadingHud:@"获取验证码..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.dataArray[0][@"text"];
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/Login/getBindVerifCode" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            [sender startWithTime:59.0 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
            
            self.isExit = result.data[@"exists"];
            
            if ([result.data[@"exists"] integerValue] == 0) {
                
                self.dataArray = @[@{@"image":@"phonIcon",@"placehodel":@"请输入手机号",@"text":self.dataArray[0][@"text"]}.mutableCopy,@{@"image":@"VerificationIcon",@"placehodel":@"请输入验证码",@"text":@""}.mutableCopy,@{@"image":@"passwordIcon",@"placehodel":@"请输入密码",@"text":@""}.mutableCopy,@{@"image":@"InvitationIcon",@"placehodel":@"邀请码（必填）",@"text":@""}.mutableCopy];

                
            }else
            {
                self.dataArray = @[@{@"image":@"phonIcon",@"placehodel":@"请输入手机号",@"text":self.dataArray[0][@"text"]}.mutableCopy,@{@"image":@"VerificationIcon",@"placehodel":@"请输入验证码",@"text":@""}.mutableCopy,];
                
            }
            [self.tableView reloadData];


        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark-是否同意
-(void)agreeClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
}

#pragma mark-绑定手机号
-(void)bangDingClick
{
    HJLog(@"绑定手机号");
   
    [HUDManager showLoadingHud:@"正在绑定..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.dataArray[0][@"text"];
    params[@"openid"] = self.dic[@"openid"];
    params[@"sex"] = self.dic[@"sex"];
    params[@"nickname"] = self.dic[@"nickname"];
    params[@"unionid"] = self.dic[@"unionid"];
    params[@"userface"] = self.dic[@"userface"];
    params[@"code"] = self.dataArray[1][@"text"];
    if ([self.isExit integerValue] == 1) {
        
        
    }else
    {
        params[@"pass"] = self.dataArray[2][@"text"];
        params[@"parent_id"] = self.dataArray[3][@"text"];
    }

    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/Login/wxBind" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        
        if (result.isSucess) {
            
            [HUDManager showStateHud:@"绑定成功" state:HUDStateTypeSuccess];
            
            userDefaultSave(result.data[@"userid"], userid);
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
   
}
@end
