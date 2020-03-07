//
//  HJCoffeeBeansViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/19.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJCoffeeBeansViewController.h"
#import "HJCoffeeBeanMissionTableViewCell.h"
#import "HJShopViewController.h"
#import "HJCourseViewController.h"
#import "inviteFriendsViewController.h"
#import "HJCoffeBeanDetailViewController.h"
#import "HJExchangeRecordsViewController.h"
@interface HJCoffeeBeansViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 背景图片 */
@property (nonatomic,weak) UIImageView *bgImageView;

/** 头部视图 */
@property (nonatomic,weak) UIImageView *headerImageView;

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;

/** 价格 */
@property (nonatomic,weak) UILabel *priceLabel;

/** o头像 */
@property (nonatomic,weak) UIImageView *iconImageView;

/** 字典 */
@property (nonatomic,copy) NSDictionary *dic;


@end

@implementation HJCoffeeBeansViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.customNavBar wr_setBackgroundAlpha:0];
    
    [self.customNavBar wr_setBottomLineHidden:YES];
    
    [self.customNavBar setTitle:@"我的积分"];

    [self.customNavBar setTitleLabelColor:[UIColor whiteColor]];
    
    self.dataArray = @[@{@"image":@"CheckinIcon",@"name":@"每日签到",@"detail":@"会员每日完成签到+5积分",@"type":@"1"},@{@"image":@"buyCourseIcon",@"name":@"购买课程",@"detail":@"自己购买课程可获得相应积分",@"type":@"2"},@{@"image":@"shareIcon",@"name":@"推广/分享",@"detail":@"成功推荐一位会员",@"type":@"3"},@{@"image":@"point",@"name":@"兑换记录",@"detail":@"积分兑换记录",@"type":@"4"}
                       ];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    bgImageView.image = kGetImage(@"beeanBg");
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    [self.view insertSubview:self.customNavBar aboveSubview:bgImageView];
    
    [self creatheader];
    
    [self creatConnentView];
    
    [self getData];
}
#pragma mark-获取数据
-(void)getData
{
    [HUDManager showLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/CenterInfo" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            self.dic = result.data;
            
            NSString *priceStr = [NSString stringWithFormat:@"积分：%@分",result.data[@"integral"]];
            self.priceLabel.text = priceStr;
            
            NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
            
            NSRange range = [priceStr rangeOfString:[NSString stringWithFormat:@"%@",result.data[@"integral"]]];
            
            [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff001f"] range:range];
            
            [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
            
            self.priceLabel.attributedText = attributeStr;
            
            [self.iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,result.data[@"userface"]]] placeholder:kGetImage(@"UserPlaceIcon")];

            [self.tableView reloadData];
            
        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
}


-(void)creatheader
{
    UIImageView *headerimageView = [[UIImageView alloc] initWithImage:kGetImage(@"beeanHeaBg")];
    headerimageView.frame = CGRectMake(15, TopHeight+30, SCREEN_WIDTH-30, 90);
    headerimageView.userInteractionEnabled = YES;
    [self.bgImageView addSubview:headerimageView];
    self.headerImageView = headerimageView;
    
    
    UIImageView *iconimageView = [[UIImageView alloc] init];
    [headerimageView addSubview:iconimageView];
    [iconimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(50);
        make.centerY.offset(0);
        make.left.offset(15);
    }];
    self.iconImageView = iconimageView;
    iconimageView.layer.cornerRadius = 25.0f;
    iconimageView.layer.masksToBounds = YES;
    
    
    UILabel *priceLabel = [UILabel labelWithFontSize:12 textColor:[UIColor blackColor]];
    [headerimageView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconimageView.mas_centerY);
        make.left.equalTo(iconimageView.mas_right).offset(10);
    }];
  
    
    self.priceLabel = priceLabel;
    
    
    
    HJLayoutBtn *detailBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [detailBtn setImage:kGetImage(@"rightArrowIcon") forState:UIControlStateNormal];
    [detailBtn setTitle:@"明细" forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    detailBtn.HJ_Style = HJLaoutBtnStyleImageRight;
    [detailBtn addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
    [detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headerimageView addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.offset(0);
    }];
    
}

-(void)detailClick
{
    HJCoffeBeanDetailViewController *coffeVc = [[HJCoffeBeanDetailViewController alloc] init];
    
    
    [self.navigationController pushViewController:coffeVc animated:YES];
    
}

-(void)creatConnentView
{
    
    UIView *connentView = [[UIView alloc] initWithFrame:CGRectMake(15, self.headerImageView.top+self.headerImageView.height+30, SCREEN_WIDTH-30, SCREENH_HEIGHT-self.headerImageView.top-self.headerImageView.height-30-30-TabBarHeight)];
    connentView.backgroundColor = [UIColor whiteColor];
    [self.bgImageView addSubview:connentView];
    connentView.layer.cornerRadius = 5.0f;
    connentView.layer.masksToBounds = YES;
    
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [connentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.offset(0);
        make.height.offset(60);
    }];
    
    
    UIButton *MacaBeanMissionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [MacaBeanMissionBtn setTitle:@"积分任务" forState:UIControlStateNormal];
    [MacaBeanMissionBtn setTitleColor:[UIColor colorWithHexString:@"#E76D70"] forState:UIControlStateNormal];
    MacaBeanMissionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:MacaBeanMissionBtn];
    [MacaBeanMissionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset((SCREEN_WIDTH-30)/2);
        make.top.bottom.offset(0);
    }];
    
    UIButton *shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopBtn setTitle:@"积分商城" forState:UIControlStateNormal];
    [shopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shopBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shopBtn addTarget:self action:@selector(shopClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:shopBtn];
    [shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(MacaBeanMissionBtn.mas_right).offset(0);
        make.width.equalTo(MacaBeanMissionBtn);
        make.top.bottom.offset(0);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#FBFBFB"];
    [topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
    UIView *alertLine = [[UIView alloc] init];
    alertLine.backgroundColor = [UIColor colorWithHexString:@"#D78E91"];
    [topView addSubview:alertLine];
    [alertLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset((SCREEN_WIDTH-30)/2);
        make.bottom.offset(0);
        make.height.offset(1);
    }];

    [connentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
    
}

-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *const identifer = @"identifer";
    
    HJCoffeeBeanMissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJCoffeeBeanMissionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.dic = self.dataArray[indexPath.row];
    cell.dataSource = self.dic;
    
    __weak typeof(self)weakself = self;
    cell.block = ^(NSDictionary * _Nonnull dic) {
        
        if ([dic[@"type"] integerValue] == 1) {
            
            [HUDManager showLoading];
            [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/sign" params:@{@"userid":userDefaultGet(userid)}.mutableCopy sucessBlock:^(HJNetWorkModel * _Nonnull result) {
                if (result.isSucess) {
                    [weakself getData];
                }
            } Faild:^(NSError * _Nonnull error) {
                
            }];
        }else if ([dic[@"type"] integerValue] == 2)
        {
            HJCourseViewController *courseVc = [[HJCourseViewController alloc] init];
            
            [weakself.navigationController pushViewController:courseVc animated:YES];

        }else if ([dic[@"type"] integerValue] == 3)
        {
            inviteFriendsViewController *vc = [[inviteFriendsViewController alloc] init];
            
            [weakself.navigationController pushViewController:vc animated:YES];

        }
        else
        {
            HJExchangeRecordsViewController *exRecordVc = [[HJExchangeRecordsViewController alloc] init];

            [weakself.navigationController pushViewController:exRecordVc animated:YES];
        }
        
        
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark-咖豆商城
-(void)shopClick
{
    HJShopViewController *shopVc = [[HJShopViewController alloc] init];
    
    [self.navigationController pushViewController:shopVc animated:YES];
    
}


@end

