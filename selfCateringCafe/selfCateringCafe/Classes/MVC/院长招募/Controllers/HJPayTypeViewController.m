//
//  HJPayTypeViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/19.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJPayTypeViewController.h"
#import "HJChangePasswordViewController.h"
#import "CYPasswordView.h"
#define kRequestTime 3.0f
#define kDelay 1.0f
@interface HJPayTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;

/** 选中 */
@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic, strong) CYPasswordView *passwordView;

@end

@implementation HJPayTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"订单支付";
    
    self.dataArray = @[@{@"image":@"wallet",@"name":@"余额支付"},@{@"image":@"wxPayIcon",@"name":@"微信支付"},@{@"image":@"AlipayIcon",@"name":@"支付宝支付"}];
    
    [self.view addSubview:self.tableView];
    
    /** 注册取消按钮点击的通知 */
    [CYNotificationCenter addObserver:self selector:@selector(cancel) name:CYPasswordViewCancleButtonClickNotification object:nil];
    [CYNotificationCenter addObserver:self selector:@selector(forgetPWD) name:CYPasswordViewForgetPWDButtonClickNotification object:nil];


}

- (void)dealloc {
    CYLog(@"cy =========== %@：我走了", [self class]);
    
    [CYNotificationCenter removeObserver:self];
}

- (void)cancel {
    CYLog(@"关闭密码框");
}

- (void)forgetPWD {
    CYLog(@"忘记密码");
}

-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f5"];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        
        UILabel *alertLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#999999"]];
        alertLabel.text = @"请选择支付方式";
        [headerView addSubview:alertLabel];
        [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
        }];
        _tableView.tableHeaderView = headerView;
        
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
        
        UIButton *footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [footerBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        footerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [footerBtn setTintColor:[UIColor whiteColor]];
        [footerBtn setBackgroundColor:[UIColor colorWithHexString:@"#ed0424"]];
        [footerBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:footerBtn];
        [footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
            make.height.offset(45);
            make.right.offset(-15);
        }];
        footerBtn.layer.cornerRadius = 22.5f;
        footerBtn.layer.masksToBounds = YES;
        
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.imageView.image = kGetImage(self.dataArray[indexPath.row][@"image"]);
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.text = self.dataArray[indexPath.row][@"name"];
    
    if (self.selectedIndex == indexPath.row) {
        
        cell.accessoryView = [[UIImageView alloc] initWithImage:kGetImage(@"PayTickSel")];
    }else
    {
        cell.accessoryView = [[UIImageView alloc] initWithImage:kGetImage(@"PayTickNomer")];
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedIndex = indexPath.row;
    
    [self.tableView reloadData];
    
}
-(void)submitClick
{
    
    if (self.selectedIndex == 0) {
        
        [HUDManager showLoading];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userid"] = userDefaultGet(userid);
        [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/payPassState" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
            if (result.isSucess) {
                
                [HUDManager hidenHud];
                if ([result.data[@"ispaypass"] integerValue] == 0) {
                    
                    [self alertVcTitle:@"系统提示" message:@"您未设置支付密码?" leftTitle:@"取消" leftTitleColor:[UIColor blackColor] leftClick:^(id leftClick) {
                    } rightTitle:@"去设置" righttextColor:[UIColor redColor] andRightClick:^(id rightClick) {
                        HJChangePasswordViewController *changeVc = [[HJChangePasswordViewController alloc] init];
                        changeVc.type = result.data[@"ispaypass"];
                        [self.navigationController pushViewController:changeVc animated:YES];
                        
                    }];
                }else
                {
                    __weak typeof(self)weakSelf = self;
                    CYPasswordView *passwordView = [[CYPasswordView alloc] init];
                    passwordView.title = @"输入交易密码";
                    passwordView.loadingText = @"提交中...";
                    [passwordView showInView:self.view.window];
                    passwordView.finish = ^(NSString *password) {
                        [weakSelf.passwordView hideKeyboard];
                        [weakSelf.passwordView startLoading];
                        NSMutableDictionary *params = [NSMutableDictionary dictionary];
                        [[HJNetWorkManager shareManager] AFPostDataUrl:@"" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
                            
                            if (result.isSucess) {
                                
                                [weakSelf.passwordView requestComplete:YES message:@"申购成功，做一些处理"];
                                [weakSelf.passwordView stopLoading];
                                [weakSelf.passwordView hide];
                            
                                
                            }else
                            {
                                [weakSelf.passwordView requestComplete:NO message:@"申购失败，做一些处理"];
                                [weakSelf.passwordView stopLoading];
                                [weakSelf.passwordView hide];

                            }
                            
                        } Faild:^(NSError * _Nonnull error) {
                            
                            [weakSelf.passwordView requestComplete:NO message:@"申购失败，做一些处理"];
                            [weakSelf.passwordView stopLoading];
                            [weakSelf.passwordView hide];
                        }];
                    };
                    
                }
                
            }
            
        } Faild:^(NSError * _Nonnull error) {
            
        }];
        
        
    }else if (self.selectedIndex == 1)
    {
        [HUDManager showLoading];
        NSMutableDictionary *payParams = [NSMutableDictionary dictionary];
        payParams[@"userid"] = userDefaultGet(userid);
        payParams[@"sn"] = self.snStr;
        payParams[@"type"] = @(2);
        [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/WxPay/wxPay" params:payParams sucessBlock:^(HJNetWorkModel * _Nonnull result) {
            if (result.isSucess) {
                
                [HUDManager hidenHud];
                
                PayReq *req = [[PayReq alloc] init];
                req.openID = result.data[@"appid"];
                req.partnerId = result.data[@"partnerid"];
                req.prepayId = result.data[@"prepayid"];
                req.nonceStr = result.data[@"noncestr"];
                req.timeStamp = [[result.data objectForKey:@"timestamp"] intValue];
                req.package = result.data[@"package"];
                req.sign = result.data[@"sign"];
                [WXApi sendReq:req completion:^(BOOL success) {
                    if (success == NO) {
                        [HUDManager showStateHud:@"支付失败" state:HUDStateTypeFail];
                    }
                }];
            }
        } Faild:^(NSError * _Nonnull error) {
            
        }];
        
    }


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //TODO: 页面appear 禁用
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //TODO: 页面Disappear 启用
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

@end
