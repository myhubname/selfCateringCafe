//
//  HJAddAddressController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJAddAddressController.h"
#import "HJTexfLineImageTableViewCell.h"
#import "HJPlaceHodelTextView.h"
#import <BRAddressPickerView.h>
@interface HJAddAddressController()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;

/** 输入框 */
@property (nonatomic,strong) HJPlaceHodelTextView *textView;

/** 数组 */
@property (nonatomic,strong) NSMutableArray *addressArray;

/** 提交 */
@property (nonatomic,strong) UIButton *submitBtn;



@end

@implementation HJAddAddressController

-(NSMutableArray *)addressArray
{
    if (!_addressArray) {
        
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.customNavBar.title isEqualToString:@"添加收获地址"]) {
        
        self.dataArray = @[@{@"alert":@"收货人",@"placeHodel":@"请输入收获人姓名",@"text":@""}.mutableCopy,@{@"alert":@"手机号码",@"placeHodel":@"请输入收获人手机号",@"text":@""}.mutableCopy,@{@"alert":@"所在地区",@"placeHodel":@"请选择所在地区",@"text":@""}.mutableCopy];

        
    }else
    {
        
        self.dataArray = @[@{@"alert":@"收货人",@"placeHodel":@"请输入收获人姓名",@"text":self.model.user}.mutableCopy,@{@"alert":@"手机号码",@"placeHodel":@"请输入收获人手机号",@"text":self.model.phone}.mutableCopy,@{@"alert":@"所在地区",@"placeHodel":@"请选择所在地区",@"text":[NSString stringWithFormat:@"%@ %@ %@",self.model.pname,self.model.cname,self.model.rname]}.mutableCopy];

        self.textView.text = self.model.address;
        
    }
    
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.submitBtn];
}
#pragma mark-列表
-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TabBarHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#eae9e9"];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifer = @"identifer";
    
    HJTexfLineImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        
        cell = [[HJTexfLineImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.leftAlertBtn.size = CGSizeMake(100, 60);
    [cell.leftAlertBtn setTitle:self.dataArray[indexPath.row][@"alert"] forState:UIControlStateNormal];
    
    [cell.texf mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
    }];
    
    cell.texf.tag = indexPath.row;
    
    cell.texf.delegate = self;
    
    if (indexPath.row == 2) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.line.hidden = YES;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    __weak typeof(self)weakself = self;
    cell.changeBlock = ^(UITextField * _Nonnull texf) {
      
        [weakself.dataArray[indexPath.row] setObject:texf.text forKey:@"text"];
        
    };
    
    cell.texf.text = self.dataArray[indexPath.row][@"text"];

    cell.texf.placeholder = self.dataArray[indexPath.row][@"placeHodel"];
    

    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#eae9e9"];
    [footerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.top.offset(0);
    }];
    
    UILabel *alertLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    alertLabel.text = @"详细地址:";
    [footerView addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
    }];
    
    [footerView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertLabel.mas_right).offset(5);
        make.right.offset(-10);
        make.top.offset(15);
        make.bottom.offset(0);
    }];
    
    
    return footerView;
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2) {
        
        __weak typeof(self)weakself = self;
        [BRAddressPickerView showAddressPickerWithDefaultSelected:[textField.text componentsSeparatedByString:@" "] resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
           
            textField.text = [NSString stringWithFormat:@"%@ %@ %@",province.name,city.name,area.name];
            
            [weakself.dataArray[textField.tag] setObject:textField.text forKey:@"text"];
            
        }];

        
        return NO;
    }else{
        
        return YES;
    }
    
}

-(HJPlaceHodelTextView *)textView
{
    if (!_textView) {
        
        _textView = [[HJPlaceHodelTextView alloc] init];
        _textView.placeholder = @"请输入详细地址";
    }
    return _textView;
}

-(UIButton *)submitBtn
{
    if (!_submitBtn) {
        
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_submitBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF5243"]];
        
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        _submitBtn.frame = CGRectMake(0, SCREENH_HEIGHT-TabBarHeight, SCREEN_WIDTH, TabBarHeight);
        
        [_submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _submitBtn;
}

#pragma mark-提交
-(void)submitClick
{
    if ([[self.dataArray firstObject][@"text"] length] == 0) {
        
        [HUDManager showTextHud:@"请输入收获人姓名"];
        
        return;
    }
    
    if ([self.dataArray[1][@"text"] length] == 0) {
        
        [HUDManager showTextHud:@"请输入收获人电话"];
        
        return;
    }
    
    if ([self.dataArray[2][@"text"] length] == 0) {
        
        [HUDManager showTextHud:@"请选择地区"];
        
        return;
    }
    
    if ([self.textView.text length] == 0) {
        
        [HUDManager showTextHud:@"请输入详细地址"];
        
        return;
    }
    
    if ([self.customNavBar.title isEqualToString:@"添加收获地址"]) {
        
        [HUDManager showLoading];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userid"] = userDefaultGet(userid);
        params[@"phone"]  = self.dataArray[1][@"text"];
        params[@"name"] = self.dataArray[0][@"text"];
        params[@"pname"] = [self.dataArray[2][@"text"] componentsSeparatedByString:@" "][0];
        params[@"cname"] = [self.dataArray[2][@"text"] componentsSeparatedByString:@" "][1];
        params[@"rname"] = [self.dataArray[2][@"text"] componentsSeparatedByString:@" "][2];
        params[@"address"] = self.textView.text;
        [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/AddressAdd" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
            if (result.isSucess) {
                
                if (self.addAddressBlock) {
                    
                    self.addAddressBlock();
                }
                
                [HUDManager showStateHud:@"添加成功" state:HUDStateTypeSuccess];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        } Faild:^(NSError * _Nonnull error) {
            
        }];
        
    }else
    {
        [HUDManager showLoading];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userid"] = userDefaultGet(userid);
        params[@"phone"]  = self.dataArray[1][@"text"];
        params[@"name"] = self.dataArray[0][@"text"];
        params[@"pname"] = [self.dataArray[2][@"text"] componentsSeparatedByString:@" "][0];
        params[@"cname"] = [self.dataArray[2][@"text"] componentsSeparatedByString:@" "][1];
        params[@"rname"] = [self.dataArray[2][@"text"] componentsSeparatedByString:@" "][2];
        params[@"address"] = self.textView.text;
        params[@"id"] = self.model.Id;
        [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/AddressMod" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
            if (result.isSucess) {
                
                if (self.addAddressBlock) {
                    
                    self.addAddressBlock();
                }
              
                [HUDManager showStateHud:@"修改成功" state:HUDStateTypeSuccess];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        } Faild:^(NSError * _Nonnull error) {
            
        }];
    }
    
}



@end
