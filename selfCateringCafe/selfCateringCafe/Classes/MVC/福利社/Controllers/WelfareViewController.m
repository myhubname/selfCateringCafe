//
//  WelfareViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "WelfareViewController.h"
#import "WelfareHeader.h"

@interface WelfareViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 头部视图 */
@property (nonatomic,strong) WelfareHeader *Header;


@end

@implementation WelfareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.hidden = YES;
    
    [self.view addSubview:self.tableView];
}

-(WelfareHeader *)Header
{
    if (!_Header) {
        
        _Header = [[WelfareHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    }
    return _Header;
}


-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#ff663a"];
        _tableView.tableHeaderView = self.Header;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    return cell;
}




@end
