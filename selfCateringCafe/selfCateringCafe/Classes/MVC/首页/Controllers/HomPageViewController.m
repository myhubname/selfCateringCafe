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
#import "HJBaseWebViewController.h"
#import "HJCourseViewController.h"
#import "HJShopViewController.h"
#import "HJSeverViewController.h"
#import "HJCourseDetailViewController.h"
@interface HomPageViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 头部视图 */
@property (nonatomic,strong) HomePageHeader *headerView;

/** 字典 */
@property (nonatomic,copy) NSDictionary *dataDic;

/** 轮播图数组 */
@property (nonatomic,strong) NSMutableArray *bannerArray;


@end

@implementation HomPageViewController

-(NSMutableArray *)bannerArray
{
    if (!_bannerArray) {
        
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

#pragma mark-头部视图
-(HomePageHeader *)headerView
{
    if (!_headerView) {
        
        _headerView = [[HomePageHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _headerView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self)weakself = self;
        _headerView.scroTextClick = ^(NSString * _Nonnull html) {
            
            HJBaseWebViewController *webVC = [[HJBaseWebViewController alloc] init];
            webVC.customNavBar.title = @"文章详情";
            webVC.urlStr = [NSURL URLWithString:html];
            [weakself.navigationController pushViewController:webVC animated:YES];
            
        };
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

    
    __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getData];
    }];
    
    [self getData];
    
}
#pragma mark-获取数据
-(void)getData
{
    [HUDManager showLoading];
    [[HJNetWorkManager shareManager] AFGetDataUrl:@"Api/Index/getMallData" params:@{}.mutableCopy sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            self.dataDic = result.data;
            
            [self.bannerArray removeAllObjects];
            [result.data[@"banner"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self.bannerArray addObject:[NSString stringWithFormat:@"%@%@",ApiImagefix,obj[@"pic"]]];
            }];
            
            
            
        }
        self.headerView.dic = self.dataDic;
        
        self.headerView.sdcyScrollView.imageURLStringsGroup = self.bannerArray;
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        
    } Faild:^(NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
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
    return [self.dataDic[@"prolist"] count];
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
        
        cell.dataArray = @[@{@"image":@"ProjectResourceIcon",@"name":@"商学院"},@{@"image":@"shopIcon",@"name":@"线上商城"},@{@"image":@"LocalServiceIcon",@"name":@"本地服务"},@{@"image":@"ProjectResourcesIcon",@"name":@"项目资源"}];
        
        __weak typeof(self)weakself = self;
        cell.classBlock = ^(NSDictionary * _Nonnull dic) {
          
            if ([dic[@"name"] isEqualToString:@"本地服务"]) {
                
                HJSeverViewController *severVc = [[HJSeverViewController alloc] init];
                
                [weakself.navigationController pushViewController:severVc animated:YES];
                
            }else if ([dic[@"name"] isEqualToString:@"商学院"])
            {
                HJCourseViewController *courseVc = [[HJCourseViewController alloc] init];
                
                [weakself.navigationController pushViewController:courseVc animated:YES];
            }else if ([dic[@"name"] isEqualToString:@"线上商城"])
            {
                HJShopViewController *shopVc = [[HJShopViewController alloc] init];
                
                [weakself.navigationController pushViewController:shopVc animated:YES];
            }else
            {
                [HUDManager showTextHud:@"敬请期待~"];
            }
            
        };
        return cell;
        
    }else
    {
        
        static NSString *const identifer = @"identifer";
        
        ExcellentCoursesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[ExcellentCoursesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dic = self.dataDic[@"prolist"][indexPath.row];
        
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HJCourseDetailViewController *courseVc = [[HJCourseDetailViewController alloc] init];
    courseVc.courseDetail_Id = self.dataDic[@"prolist"][indexPath.row][@"Id"];
    [self.navigationController pushViewController:courseVc animated:YES];
    
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
