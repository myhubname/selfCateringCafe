//
//  HJDeanViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJDeanViewController.h"
#import "HJDeanHeader.h"
#import "HJDeanTableViewCell.h"
#import "HJUpgradeViewController.h"
@interface HJDeanViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableViw;

/** header */
@property (nonatomic,strong) HJDeanHeader *header;

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;

@end

@implementation HJDeanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    [self.customNavBar wr_setBottomLineHidden:YES];
    
    [self.customNavBar setTitle:@"开通院长"];

    [self.customNavBar setTitleLabelColor:[UIColor whiteColor]];

    
    self.dataArray = @[@"社群平台所有课程、资料、人脉资源，全部共享；",@"新推荐社员，可以获得60%的奖励收益；",@"可以分享推广自媒咖商学院付费课程，获得收益；",@"可以分享推广自媒咖商学院付费课程，获得收益；",@"可以在平台机制下建立分社，可申请加入讲师团",@"享受私人订制专属个人宣传海报和宣传网推文案;",@"可以在平台机制下建立分社，可申请加入讲师团",@"享受私人订制专属个人宣传海报和宣传网推文案;",@"可以在平台机制下建立分社，可申请加入讲师团；",@"获得抖音公社&自媒咖商学院专属授权书（电子版）",@"后期优先获得千万粉丝矩阵联盟整体盈利分红机会；",@"优先享受其他更多高端增值服务。"];
    
    [self.view addSubview:self.tableViw];
    
    [self.view insertSubview:self.customNavBar aboveSubview:self.tableViw];

}

-(HJDeanHeader *)header
{
    if (!_header) {
        
        _header = [[HJDeanHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2+125)];
    }
    return _header;
}

-(HJBaseTableview *)tableViw
{
    if (!_tableViw) {
        
        _tableViw = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped andVc:self];
        _tableViw.delegate = self;
        _tableViw.dataSource = self;
        
        _tableViw.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableViw.tableHeaderView = self.header;
        
        _tableViw.backgroundColor = [UIColor whiteColor];
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        
        UIButton *upgradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upgradeButton setTitle:@"立即升级" forState:UIControlStateNormal];
        [upgradeButton setBackgroundColor:[UIColor colorWithHexString:@"#e3b79a"]];
        [upgradeButton setTitleColor:[UIColor colorWithHexString:@"#462d17"] forState:UIControlStateNormal];
        [upgradeButton addTarget:self action:@selector(upGradeClick) forControlEvents:UIControlEventTouchUpInside];
        upgradeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [footerView addSubview:upgradeButton];
        [upgradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(25);
            make.right.offset(-25);
            make.height.offset(50);
        }];
        upgradeButton.layer.cornerRadius = 25.0f;
        upgradeButton.layer.masksToBounds = YES;
        
        HJLayoutBtn *tickBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
        [tickBtn setImage:kGetImage(@"tickNomer") forState:UIControlStateNormal];
        [tickBtn setImage:kGetImage(@"tickSel") forState:UIControlStateSelected];
        [tickBtn setTitle:@"开启自动续期(可在设置中修改)" forState:UIControlStateNormal];
        [tickBtn setTitleColor:[UIColor colorWithHexString:@"#686868"] forState:UIControlStateNormal];
        tickBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [tickBtn addTarget:self action:@selector(tickClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:tickBtn];
        [tickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(upgradeButton.mas_centerX);
            make.top.equalTo(upgradeButton.mas_bottom).offset(10);
        }];
        
        
        _tableViw.tableFooterView = footerView;
        
        
    }
    return _tableViw;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    HJDeanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJDeanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.alertLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    cell.connentLabel.text = self.dataArray[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}


-(void)tickClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    
}

-(void)upGradeClick
{
    HJLog(@"1");
    
    HJUpgradeViewController *upVc = [[HJUpgradeViewController alloc] init];
    
    [self.navigationController pushViewController:upVc animated:YES];
}



@end
