//
//  HJUpgradeViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/22.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJUpgradeViewController.h"

@interface HJUpgradeViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;

/** 选中 */
@property (nonatomic,assign) NSInteger selectedIndex;




@end

@implementation HJUpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"订单支付";
    
    self.dataArray = @[@{@"image":@"wallet",@"name":@"余额支付"},@{@"image":@"wxPayIcon",@"name":@"微信支付"},@{@"image":@"AlipayIcon",@"name":@"支付宝支付"}];

    [self.view addSubview:self.tableView];
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



@end
