//
//  HomPageViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HomPageViewController.h"
#import "HomePageHeader.h"
#import "HJMoreClassTableViewCell.h"
#import "ExcellentCoursesTableViewCell.h"
@interface HomPageViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 头部视图 */
@property (nonatomic,strong) HomePageHeader *headerView;

@end

@implementation HomPageViewController

#pragma mark-头部视图
-(HomePageHeader *)headerView
{
    if (!_headerView) {
        
        _headerView = [[HomePageHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    [self.customNavBar wr_setBottomLineHidden:YES];
    
    [self setNav];
    
    [self.view addSubview:self.tableView];

    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];

}
#pragma mark-设置导航栏
-(void)setNav
{
    
    UITextField *searchTexf = [[UITextField alloc] init];
    [searchTexf setBackgroundColor:[UIColor colorWithHexString:@"#ffb0b1"]];
    searchTexf.placeholder = @"输入关键字";
    [searchTexf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchTexf.font = [UIFont systemFontOfSize:15];
    searchTexf.textColor = [UIColor whiteColor];
    [self.customNavBar addSubview:searchTexf];
    [searchTexf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(30);
        make.left.offset(30);
        make.right.offset(-30);
        make.bottom.offset(-5);
    }];
    searchTexf.layer.cornerRadius = 5.0f;
    searchTexf.layer.masksToBounds = YES;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:kGetImage(@"searchIcon") forState:UIControlStateNormal];
    searchBtn.size = CGSizeMake(30, 30);
    searchTexf.leftView = searchBtn;
    searchTexf.leftViewMode = UITextFieldViewModeAlways;
    
    
}

#pragma mark-创建列表
-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-TabBarHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }else
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *const identifer = @"HJMoreClassTableViewCell";
        
        HJMoreClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[HJMoreClassTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataArray = @[@{@"image":@"curriculumIcon",@"name":@"课程"},@{@"image":@"shopIcon",@"name":@"商城"},@{@"image":@"SeverIcon",@"name":@"服务"},@{@"image":@"dynamic",@"name":@"动态"}];
        
        return cell;
        
    }else
    {
        
        static NSString *const identifer = @"identifer";
        
        ExcellentCoursesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[ExcellentCoursesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        return cell;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 120;
    }else
    {
        return 120;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        return 60;
    }else
    {
        return 0.01;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView *headerView = [[UIView alloc] init];
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.offset(0);
            make.top.offset(15);
        }];
        UIView *verLine = [[UIView alloc] init];
        verLine.backgroundColor = [UIColor colorWithHexString:@"#fd2824"];
        [bgView addSubview:verLine];
        [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.offset(0);
            make.height.offset(20);
            make.width.offset(3);
        }];
        
        UILabel *textLabel = [UILabel labelWithFontSize:18 textColor:[UIColor blackColor]];
        textLabel.text = @"精品课程";
        [bgView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(verLine.mas_right).offset(10);
        }];
        
        
        return headerView;
    }else
    {
        return nil;
    }
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 155-TopHeight*2)
    {
        CGFloat alpha = (offsetY - (155-TopHeight*2)) / TopHeight;
        
        [self.customNavBar wr_setBackgroundAlpha:alpha];
    }
    else
    {
        [self.customNavBar wr_setBackgroundAlpha:0];
    }
    
}

@end
