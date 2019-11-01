//
//  HJCourseCatalogueViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/10.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJCourseCatalogueViewController.h"
#import "HJCourseListTableViewCell.h"
@interface HJCourseCatalogueViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HJCourseCatalogueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-351-60) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dic[@"chapter"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    HJCourseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[HJCourseListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.numLabel.text = [NSString stringWithFormat:@"%.2ld",indexPath.row];
    
    cell.nameLabel.text = self.dic[@"chapter"][indexPath.row][@"topic"];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@分钟",self.dic[@"chapter"][indexPath.row][@"time"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.dic[@"isbuy"] integerValue] == 1) {
        
        
        
        
    }else
    {
        [HUDManager showTextHud:@"请购买..."];
        
    }
    
    
}


-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    [self.tableView reloadData];
}

@end
