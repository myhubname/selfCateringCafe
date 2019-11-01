//
//  HJCourseViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/4.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJCourseViewController.h"
#import "HJCourseTopView.h"
#import "HJSearchTableViewCell.h"
@interface HJCourseViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 顶部视图 */
@property (nonatomic,strong) HJCourseTopView *topView;



@end

@implementation HJCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.tableView];
    
    
    
}
#pragma mark-设置导航栏
-(void)setNav
{
    UITextField *searchTexf = [[UITextField alloc] init];
    searchTexf.placeholder = @"搜索课程";
    searchTexf.font = [UIFont systemFontOfSize:15];
    searchTexf.backgroundColor = [UIColor whiteColor];
    [searchTexf setTintColor:[UIColor colorWithHexString:@"#fd5b48"]];
    [self.customNavBar addSubview:searchTexf];
    [searchTexf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(54);
        make.right.offset(-44);
        make.height.offset(35);
        make.bottom.offset(-5);
    }];
    searchTexf.layer.cornerRadius = 5.0f;
    searchTexf.layer.masksToBounds = YES;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:kGetImage(@"searchLigrayIcon") forState:UIControlStateNormal];
    searchBtn.size = CGSizeMake(35, 35);
    searchTexf.leftView =  searchBtn;
    searchTexf.leftViewMode = UITextFieldViewModeAlways;

    
    
}
#pragma mark-获取数据
-(void)getData:(BOOL)isHeader
{
    
    
}


#pragma mark-创建顶部
-(HJCourseTopView *)topView
{
    if (!_topView) {
        
        _topView = [[HJCourseTopView alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, 55)];
    }
    return _topView;
}


-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, self.topView.top+self.topView.height, SCREEN_WIDTH, SCREENH_HEIGHT-self.topView.top-self.topView.height) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    HJSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}



@end

