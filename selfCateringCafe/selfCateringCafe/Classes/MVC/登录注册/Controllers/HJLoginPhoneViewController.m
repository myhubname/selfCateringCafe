//
//  HJLoginPhoneViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJLoginPhoneViewController.h"
#import "HJTexfLineImageTableViewCell.h"
#import "HJLoginRegistAlert.h"
#import "HJRigistViewController.h"
@interface HJLoginPhoneViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 数组 */
@property (nonatomic,strong) NSArray *dataArray;

/** HJLoginRegistAlert */
@property (nonatomic,strong) HJLoginRegistAlert *alertView;



@end

@implementation HJLoginPhoneViewController

-(NSArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = @[@{@"image":@"phonIcon",@"placehodel":@"请输入手机号",@"text":@""}.mutableCopy,@{@"image":@"passwordIcon",@"placehodel":@"请输入密码",@"text":@""}.mutableCopy];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.customNavBar wr_setBackgroundAlpha:0.0];
    
    [self.customNavBar wr_setLeftButtonWithImage:kGetImage(@"closeBlack")];
   
    self.customNavBar.title = @"登录";
    
    [self.customNavBar setTitleLabelColor:[UIColor blackColor]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
    
    [self.view addSubview:self.alertView];
}

-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-60) style:UITableViewStyleGrouped andVc:self];
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
        
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [forgetBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [footerView addSubview:forgetBtn];
        [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-30);
            make.top.offset(0);
        }];
        
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#ff5846"]];
        [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
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

    
    __weak typeof(self)weakself = self;
    cell.changeBlock = ^(UITextField * _Nonnull texf) {
      
        [weakself.dataArray[indexPath.row] setObject:texf.text forKey:@"text"];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)loginClick
{

    HJLog(@"%@%@",self.dataArray[0][@"text"],self.dataArray[1][@"text"]);
    
}

#pragma mark-注册
-(HJLoginRegistAlert *)alertView
{
    if (!_alertView) {
        
        _alertView = [[HJLoginRegistAlert alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT-60, SCREEN_WIDTH, 60)];
        __weak typeof(self)weakself = self;
        [_alertView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            
            HJRigistViewController *rigistVc = [[HJRigistViewController alloc] init];
            
            [weakself.navigationController pushViewController:rigistVc animated:YES];
        }];
    }
    return _alertView;
}


@end
