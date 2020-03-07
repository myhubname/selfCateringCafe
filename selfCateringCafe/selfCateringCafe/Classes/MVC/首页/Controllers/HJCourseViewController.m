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
#import "CourseModel.h"
#import "HJCourseDetailViewController.h"
#import "ShowCateView.h"
@interface HJCourseViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 顶部视图 */
@property (nonatomic,strong) HJCourseTopView *topView;

/** 课程分类ID 查找时请带上该值 */
@property (nonatomic,assign) int inftype;

/** 关键词 */
@property (nonatomic,copy) NSString *keyword;

/** 1 表示倒序 2表示升序 */
@property (nonatomic,assign) int ord;

/** 排序类别，未全... price 表示安装价格排序 sale表示安装销售量的排序 hits表示安装人气排序 date 时间 */
@property (nonatomic,copy) NSString *ordtype;

/** index */
@property (nonatomic,assign) NSInteger index;

/** 类别数组 */
@property (nonatomic,strong) NSMutableArray *cateArray;

/** 数组 */
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation HJCourseViewController

-(NSMutableArray *)cateArray
{
    if (!_cateArray) {
        
        _cateArray = [NSMutableArray array];
        
    }
    return _cateArray;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    
    [self.view addSubview:self.topView];
    
    [self.view addSubview:self.tableView];
    
    self.inftype = 0;
    
    __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself getData:YES];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [weakself getData:NO];
        
    }];
    
    
}
#pragma mark-设置导航栏
-(void)setNav
{
    UITextField *searchTexf = [[UITextField alloc] init];
    searchTexf.placeholder = @"搜索课程";
    searchTexf.font = [UIFont systemFontOfSize:15];
    searchTexf.backgroundColor = [UIColor whiteColor];
    [searchTexf setTintColor:[UIColor colorWithHexString:@"#fd5b48"]];
    searchTexf.returnKeyType = UIReturnKeySearch;
    searchTexf.delegate = self;
    [self.customNavBar addSubview:searchTexf];
    [searchTexf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(54);
        make.right.offset(-44);
        make.height.offset(35);
        make.bottom.offset(-5);
    }];
    searchTexf.layer.cornerRadius = 5.0f;
    searchTexf.layer.masksToBounds = YES;
    
    UIView *leftView = [[UIView alloc] init];
    leftView.size = CGSizeMake(35, 35);
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:kGetImage(@"searchLigrayIcon") forState:UIControlStateNormal];
    searchBtn.size = CGSizeMake(35, 35);
    [leftView addSubview:searchBtn];
    searchTexf.leftView =  leftView;
    searchTexf.leftViewMode = UITextFieldViewModeAlways;
    
}
#pragma mark-获取数据
-(void)getData:(BOOL)isHeader
{
    if (isHeader) {
        
        [self.tableView.mj_footer endRefreshing];
    }else
    {
        
        [self.tableView.mj_header endRefreshing];
        
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    params[@"inftype"] = @(self.inftype);
    params[@"keyword"] = self.keyword;
    params[@"ord"] = @(self.ord);
    params[@"ordtype"] = self.ordtype;
    if (isHeader) {
        
        self.index = 0;
    }else
    {
        self.index += 1;
    }
    
    params[@"index"] = @(self.index);
    
    [HUDManager showLoading];
    
    [[HJNetWorkManager shareManager] AFGetDataUrl:@"Api/Course/getCourse" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            NSArray *models = [NSArray modelArrayWithClass:[CourseModel class] json:result.data[@"list"]];

            if (isHeader) {
             
                [self.cateArray removeAllObjects];
                
                [self.cateArray addObject:@{@"Id":@"0",@"topic":@"全部"}];
                
                [self.cateArray addObjectsFromArray:result.data[@"cate"]];
                
                [self.dataArray removeAllObjects];

                
                [self.dataArray addObjectsFromArray:models];
                
                if (models.count < 15) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [self.tableView.mj_header endRefreshing];
                
            }else
            {
                
                if (models.count < 15) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
                
                [self.dataArray addObjectsFromArray:models];
                
            }
            
        }else
        {
            if (isHeader) {
                
                [self.tableView.mj_header endRefreshing];
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
            
        }
        
        [self.tableView reloadData];
        
    } Faild:^(NSError * _Nonnull error) {
        
        if (isHeader) {
            
            [self.tableView.mj_header endRefreshing];
        }else
        {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
}


#pragma mark-创建顶部
-(HJCourseTopView *)topView
{
    if (!_topView) {
        
        _topView = [[HJCourseTopView alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, 55)];
        
        [_topView.classBtn addTarget:self action:@selector(classClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView.sellBtn addTarget:self action:@selector(sellClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView.priceBtn addTarget:self action:@selector(priceClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView.timeBtn addTarget:self action:@selector(timeClick:) forControlEvents:UIControlEventTouchUpInside];
        
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
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    HJSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.model = self.dataArray[indexPath.row];
    

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HJCourseDetailViewController *courseVc = [[HJCourseDetailViewController alloc] init];
    courseVc.courseDetail_Id = [self.dataArray[indexPath.row] Id];
    [self.navigationController pushViewController:courseVc animated:YES];
 
    
}

#pragma mark-分类点击
-(void)classClick:(HJLayoutBtn *)sender
{
    CGRect absoluteRect = [self.topView convertRect:self.topView.bounds toView:[UIApplication sharedApplication].keyWindow];
    __weak typeof(self)weakself = self;
    [ShowCateView showCateRect:absoluteRect dataSource:self.cateArray selectedId:[NSString stringWithFormat:@"%d",self.inftype] selectedBlock:^(NSDictionary * _Nonnull dic) {
        
        weakself.inftype = [dic[@"Id"] intValue];
        
        [sender setTitle:dic[@"topic"] forState:UIControlStateNormal];
    
        [weakself.tableView.mj_header beginRefreshing];
        
    }];
}

-(void)sellClick:(HJLayoutBtn *)sender
{
    if ([self.ordtype isEqualToString:@"sale"]) {
        
        
        if (self.ord == 1) {
            
            self.ord = 2;
            
            [sender setImage:kGetImage(@"sortDown") forState:UIControlStateNormal];

            
        }else
        {
            self.ord = 1;
            
            [sender setImage:kGetImage(@"sortIconUp") forState:UIControlStateNormal];
            
        }
        
        
    }else
    {
        [sender setImage:kGetImage(@"sortIconUp") forState:UIControlStateNormal];
        
        [sender setTitleColor:[UIColor colorWithHexString:@"#fd3528"] forState:UIControlStateNormal];
        
        self.ordtype = @"sale";
        
        self.ord = 1;
        
        [self.topView.priceBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        [self.topView.priceBtn setImage:kGetImage(@"sortIconNomer") forState:UIControlStateNormal];
        
        [self.topView.timeBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        [self.topView.timeBtn setImage:kGetImage(@"timeSort") forState:UIControlStateNormal];
        
    }

    [self.tableView.mj_header beginRefreshing];
    
}


-(void)priceClick:(HJLayoutBtn *)sender
{
    if ([self.ordtype isEqualToString:@"price"]) {
        
        if (self.ord == 1) {
            
            self.ord = 2;
            
            [sender setImage:kGetImage(@"sortDown") forState:UIControlStateNormal];
            
            
        }else
        {
            self.ord = 1;
            
            [sender setImage:kGetImage(@"sortIconUp") forState:UIControlStateNormal];
            
        }
        
    }else
    {
        [sender setImage:kGetImage(@"sortIconUp") forState:UIControlStateNormal];
        
        [sender setTitleColor:[UIColor colorWithHexString:@"#fd3528"] forState:UIControlStateNormal];
        
        self.ordtype = @"price";
        
        self.ord = 1;
        
        [self.topView.sellBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        [self.topView.sellBtn setImage:kGetImage(@"sortIconNomer") forState:UIControlStateNormal];
        
        [self.topView.timeBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        [self.topView.timeBtn setImage:kGetImage(@"timeSort") forState:UIControlStateNormal];

    }
    
    [self.tableView.mj_header beginRefreshing];
}


-(void)timeClick:(HJLayoutBtn *)sender
{
    
    if ([self.ordtype isEqualToString:@"date"]) {
        
        
        if (self.ord == 1) {
            
            self.ord = 2;
            
            [sender setImage:kGetImage(@"timeSortRight") forState:UIControlStateNormal];
            
            
        }else
        {
            self.ord = 1;
            
            [sender setImage:kGetImage(@"timeSortLeft") forState:UIControlStateNormal];
            
        }
        
    }else
    {
        self.ordtype = @"date";
        
        self.ord = 1;
        
        
        [sender setImage:kGetImage(@"timeSortLeft") forState:UIControlStateNormal];
        
        [sender setTitleColor:[UIColor colorWithHexString:@"#fd3528"] forState:UIControlStateNormal];

        [self.topView.sellBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        [self.topView.sellBtn setImage:kGetImage(@"sortIconNomer") forState:UIControlStateNormal];

        [self.topView.priceBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
        [self.topView.priceBtn setImage:kGetImage(@"sortIconNomer") forState:UIControlStateNormal];
        
    }
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text length] == 0) {
        
        [HUDManager showStateHud:@"输入框不能为空" state:HUDStateTypeFail];
        
        return NO;
    }
    
    self.keyword = textField.text;
    
    
    [textField resignFirstResponder];
    
    [self.tableView.mj_header beginRefreshing];

    return YES;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;

}


@end


