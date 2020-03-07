//
//  HJChangePasswordViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/20.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJChangePasswordViewController.h"
#import "HJTexfLineImageTableViewCell.h"
@interface HJChangePasswordViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 数组 */
@property (nonatomic,strong) NSArray *dataArray;



@end

@implementation HJChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.customNavBar.title = @"支付密码";
    
    
    if ([self.type integerValue] == 0) {
        
        
        self.dataArray = @[@{@"alert":@"新密码",@"placehodel":@"请输入新密码",@"text":@""}.mutableCopy,@{@"alert":@"确认密码",@"placehodel":@"确认密码",@"text":@""}.mutableCopy];

        
        
    }else
    {
        self.dataArray = @[@{@"alert":@"原密码",@"placehodel":@"请输入原密码",@"text":@""}.mutableCopy,@{@"alert":@"新密码",@"placehodel":@"请输入新密码",@"text":@""}.mutableCopy,@{@"alert":@"确认密码",@"placehodel":@"确认密码",@"text":@""}.mutableCopy];

    }
    
    
    [self.view addSubview:self.tableView];
    
}

-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        
        UIButton *changePasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([self.type integerValue] == 0) {
            
            [changePasswordBtn setTitle:@"设置密码" forState:UIControlStateNormal];

        }else
        {
            [changePasswordBtn setTitle:@"密码修改" forState:UIControlStateNormal];

        }
        changePasswordBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [changePasswordBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF5243"]];
        [changePasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [changePasswordBtn addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:changePasswordBtn];
        [changePasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-15);
            make.height.offset(45);
            make.centerY.offset(0);
        }];
        changePasswordBtn.layer.cornerRadius = 5.0f;
        changePasswordBtn.layer.masksToBounds = YES;
        
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
    
    HJTexfLineImageTableViewCell *texfCell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!texfCell) {
        
        texfCell = [[HJTexfLineImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    [texfCell.texf mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
    }];
    
    texfCell.leftAlertBtn.size = CGSizeMake(100, 60);
    [texfCell.leftAlertBtn setTitle:self.dataArray[indexPath.row][@"alert"] forState:UIControlStateNormal];
    
    texfCell.texf.placeholder = self.dataArray[indexPath.row][@"placehodel"];
    
    __weak typeof(self)weakself = self;
    texfCell.changeBlock = ^(UITextField * _Nonnull texf) {
      
        [weakself.dataArray[indexPath.row] setObject:texf.text forKey:@"text"];
    };
    
    
    return texfCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


-(void)changeClick
{
    if ([self.type integerValue] == 0) {
        
        if ([self.dataArray[0][@"text"] length] == 6 && [self.dataArray[1][@"text"] length] == 6) {
            
            if (![self.dataArray[0][@"text"] isEqualToString:self.dataArray[1][@"text"]]) {
                
                [HUDManager showStateHud:@"密码输入不一致" state:HUDStateTypeFail];
                
                return;
            }
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"userid"] = userDefaultGet(userid);
            params[@"pass"] = self.dataArray[0][@"text"];
            [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/setPaypass" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
                if (result.isSucess) {
                  
                    [HUDManager showStateHud:@"设置成功" state:HUDStateTypeSuccess];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
            } Faild:^(NSError * _Nonnull error) {
                
            }];

        }else
        {
            [HUDManager showStateHud:@"支付密码为6位数字" state:HUDStateTypeFail];
        }
        
        
        
    }else
    {
        if ([self.dataArray[0][@"text"] length] == 6 && [self.dataArray[1][@"text"] length] == 6 && [self.dataArray[2][@"text"] length] == 6) {
            
            HJLog(@"%@,%@",self.dataArray[1][@"text"],self.dataArray[2][@"text"]);
            
            if (![self.dataArray[1][@"text"] isEqualToString:self.dataArray[2][@"text"]]) {
                
                [HUDManager showStateHud:@"密码输入不一致" state:HUDStateTypeFail];
                
                return;
            }
            
            [HUDManager showLoading];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"userid"] = userDefaultGet(userid);
            params[@"oldpass"] = [self.dataArray[0][@"text"] md5String];
            params[@"newpass"] = [self.dataArray[1][@"text"] md5String];
            [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/modPaypass" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
                if (result.isSucess) {
                    
                    [HUDManager showStateHud:@"修改成功" state:HUDStateTypeSuccess];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            } Faild:^(NSError * _Nonnull error) {
                
            }];
            
        }else
        {
            [HUDManager showStateHud:@"支付密码为6位数字" state:HUDStateTypeFail];
        }
    }
}




@end
