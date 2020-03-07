//
//  HJShopSubmitOrderViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/14.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJShopSubmitOrderViewController.h"
#import "HJAddressViewController.h"
#import "UIViewController+HJAlertController.h"
@interface HJShopSubmitOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 列表  */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 数组 */
@property (nonatomic,copy) NSArray *dataArray;

/** 字典 */
@property (nonatomic,copy) NSDictionary *dic;


/** change */
@property (nonatomic,strong) UIButton *changeBtn;

/** 地址模型 */
@property (nonatomic,strong) HJAddressModel *model;



@end

@implementation HJShopSubmitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"我要兑换";
    
    self.dataArray = @[@"商品名称:",@"所需积分:",@"我的积分"];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.changeBtn];
    
    [self getData];
}
#pragma mark-获取数据
-(void)getData
{
    [HUDManager showLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.goodsId;
    params[@"userid"] = userDefaultGet(userid);
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/Convert/toconvert" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            self.dic = result.data;
            
            self.model = [HJAddressModel modelWithJSON:result.data[@"useraddress"]];
            
            [self.tableView reloadData];
        }
        
    } Faild:^(NSError * _Nonnull error) {
        
    }];
    
}


-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.offset(0);
            make.height.offset(1);
        }];
        
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if (self.dic == nil) {
    }else{
     
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"商品名称: %@",self.dic[@"cvtdata"][@"productname"]];
            
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
            
            NSRange range = [cell.textLabel.text rangeOfString:self.dic[@"cvtdata"][@"productname"]];
            
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            cell.textLabel.attributedText = attribute;
            
            
        }else if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"所需积分: %@ 分",self.dic[@"cvtdata"][@"integral"]];
            
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
            
            NSRange range = [cell.textLabel.text rangeOfString:self.dic[@"cvtdata"][@"integral"]];
            
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            cell.textLabel.attributedText = attribute;

            
        }else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"我的积分: %@ 分",self.dic[@"userdata"][@"integral"]];
            
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
            
            NSRange range = [cell.textLabel.text rangeOfString:self.dic[@"userdata"][@"integral"]];
            
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            cell.textLabel.attributedText = attribute;
            
        }
        
    }
  
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",self.model.pname,self.model.cname,self.model.rname,self.model.address];
    
    return [address heightForFont:[UIFont systemFontOfSize:15] width:SCREEN_WIDTH-30] + 75;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(-15);
    }];
    
    __weak typeof(self)weakself = self;
    [bgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       
        HJAddressViewController *addreeVc = [[HJAddressViewController alloc] init];
        
        addreeVc.choseAddres = ^(HJAddressModel * _Nonnull model) {
          
            weakself.model = model;
            
            [weakself.tableView reloadData];
            
        };
        
        [self.navigationController pushViewController:addreeVc animated:YES];
        
    }];
       
    UILabel *centerLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    centerLabel.text = @"添加收获地址";
    [bgView addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
    }];
    
    UILabel *userLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
       [bgView addSubview:userLabel];
       [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.offset(15);
           make.top.offset(15);
       }];
       
       userLabel.text = [NSString stringWithFormat:@"收货人：%@",self.model.user];
       
       
       
       UILabel *phoneLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
       [bgView addSubview:phoneLabel];
       [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.offset(-30);
           make.centerY.equalTo(userLabel.mas_centerY);
       }];
       
       phoneLabel.text = [NSString stringWithFormat:@"手机号：%@",self.model.phone];
       
       
       UILabel *addressLabel = [UILabel labelWithFontSize:15 textColor:[UIColor lightGrayColor]];
       [bgView addSubview:addressLabel];
       [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(userLabel.mas_bottom).offset(15);
           make.left.offset(15);
           make.right.offset(-15);
       }];
       addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.model.pname,self.model.cname,self.model.rname,self.model.address];
       
       UIImageView *rightArrow = [[UIImageView alloc] init];
       [rightArrow setImage:kGetImage(@"rightArrowIcon")];
       [bgView addSubview:rightArrow];
       [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.offset(-15);
           make.width.offset(12);
           make.height.offset(20);
           make.centerY.offset(0);
       }];
    
    
    if (self.model == nil) {
        
        centerLabel.hidden = NO;
        
        rightArrow.hidden = YES;
        
        addressLabel.hidden = YES;

        phoneLabel.hidden = YES;
 
        userLabel.hidden = YES;
        
        addressLabel.hidden = YES;
    }else
    {
        centerLabel.hidden = YES;
        

       rightArrow.hidden = NO;
       
       addressLabel.hidden = NO;

       phoneLabel.hidden = NO;

       userLabel.hidden = NO;
       
       addressLabel.hidden = NO;
    }
    
    
    return headerView;
}


-(UIButton *)changeBtn
{
    if (!_changeBtn) {
        
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeBtn setTitle:@"我要兑换" forState:UIControlStateNormal];
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_changeBtn setBackgroundColor:[UIColor colorWithHexString:@"#FF5243"]];
        [_changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_changeBtn addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
        _changeBtn.frame = CGRectMake(0, SCREENH_HEIGHT-TabBarHeight, SCREEN_WIDTH, TabBarHeight);
    }
    return _changeBtn;
    
}

-(void)changeClick
{
 
    [self alertVcTitle:@"系统提示" message:@"您确定要兑换此礼品吗?" leftTitle:@"取消" leftTitleColor:[UIColor redColor] leftClick:^(id leftClick) {
        
    } rightTitle:@"确定" righttextColor:[UIColor blackColor] andRightClick:^(id rightClick) {
        
        [HUDManager showLoadingHud:@"正在兑换..."];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"proid"]  =  self.dic[@"cvtdata"][@"Id"];
        params[@"userid"] = userDefaultGet(userid);
        params[@"addressId"] = self.model.Id;
        [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/doConvert" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
            
            if (result.isSucess) {
                
                [HUDManager showStateHud:@"兑换成功" state:HUDStateTypeSuccess];
            
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        } Faild:^(NSError * _Nonnull error) {
            
        }];
        
    }];
    
}



@end
