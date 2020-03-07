//
//  HJMyIncomeViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/18.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJMyIncomeViewController.h"
#import "IncomeTableViewCell.h"
#import "IncomeBreakdownViewController.h"
#import "CashWithdrawalViewController.h"
@interface HJMyIncomeViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;

/** alert */
@property (nonatomic,copy) NSArray *alertArray;

/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;

/** 字典 */
@property (nonatomic,copy) NSDictionary *dic;


@end

@implementation HJMyIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"我的收益";
    
    self.dataArray = @[@"收益明细",@"提现记录"];
    
    [self.view addSubview:self.tableView];
    
    [self getData];
}
#pragma mark-获取数据
-(void)getData
{
    [HUDManager showLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/getCashtxt" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            self.dic = result.data[@"amount"];
            
            self.alertArray = result.data[@"topic"];
            
            self.priceLabel.text = [NSString stringWithFormat:@"%@",result.data[@"amount"][@"amount"]];
            
            [self.tableView reloadData];
        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
}


#pragma mark-创建列表
-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.image = kGetImage(@"balanceIcon");
        [headerView addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.offset(30);
            make.top.offset(15);
            make.left.offset(15);
        }];
        
        UILabel *alertLabel = [UILabel labelWithFontSize:16 textColor:[UIColor blackColor]];
        alertLabel.text = @"收入余额（元）";
        [headerView addSubview:alertLabel];
        [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.mas_right).offset(10);
            make.centerY.equalTo(iconImageView.mas_centerY);
        }];
        
        UILabel *priceLabel = [UILabel labelWithFontSize:35 textColor:[UIColor colorWithHexString:@"#f90801"]];
        priceLabel.text = @"0.0";
        [headerView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.bottom.offset(-15);
        }];
        self.priceLabel = priceLabel;
        
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }else if (section == 1)
    {
        return self.dataArray.count;
    }else
    return self.alertArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *const identifer = @"IncomeTableViewCell";
        
        IncomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[IncomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.withdrawIngLabel.text = [NSString stringWithFormat:@"%@\n\n%@",@"正在提现中(元)",self.dic[@"frezeamount"]];

        cell.withdrawLabel.text = [NSString stringWithFormat:@"%@\n\n%@",@"可提现余额(元)",self.dic[@"amount"]];

        
        return cell;
        
    }else if (indexPath.section == 1)
    {
        static NSString *const identifer = @"firstDentifer";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            
            
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            [cell addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.offset(0);
                make.height.offset(1);
                make.bottom.offset(0);
            }];
            
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        cell.textLabel.text = self.dataArray[indexPath.row];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    else
    {
        static NSString *const identifer = @"identifer";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.text = self.alertArray[indexPath.row];
        
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 100;
    }else if (indexPath.section == 1)
    {
        return 60;
    }
    else
    {
        return 30;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        
        return 15;
    }else
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 80;
    }
    else
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *footerView = [[UIView alloc] init];
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBtn setBackgroundImage:kGetImage(@"submitBg") forState:UIControlStateNormal];
        [submitBtn setTitle:@"我要提交" forState:UIControlStateNormal];
        submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:submitBtn];
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.height.offset(46);
            make.centerY.offset(0);
        }];
        
        return footerView;
    }else
    {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            IncomeBreakdownViewController *breakVc = [[IncomeBreakdownViewController alloc] init];
            
            [self.navigationController pushViewController:breakVc animated:YES];

        }else if (indexPath.row == 1)
        {
            CashWithdrawalViewController *cashVc = [[CashWithdrawalViewController alloc] init];
            
            [self.navigationController pushViewController:cashVc animated:YES];
            
        }
        
    }
    
}


#pragma mark-我要提交
-(void)submitClick
{
    if (self.paycode.length == 0) {
        
        [HUDManager showStateHud:@"请添加付款码" state:HUDStateTypeFail];
        
        return;
    }
    [self showAlertTexfMessage:@"提示" placeHodel:@"请输入提现金额" leftTitle:@"取消" leftClick:^(id action) {
    } rightTitle:@"确定" rightBlock:^(UITextField *action) {
        
        [HUDManager showLoading];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userid"] = userDefaultGet(userid);
        params[@"usermoney"] = @([action.text floatValue]);
        params[@"type"] = @"3";
        [[HJNetWorkManager shareManager] AFPostDataUrl:@"/Api/User/withdraw" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
            if (result.isSucess) {

                [HUDManager showStateHud:@"提交成功" state:HUDStateTypeSuccess];

                [self getData];
            }
        } Faild:^(NSError * _Nonnull error) {
            
        }];
        
        
    }];
    
}


@end
