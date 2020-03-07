//
//  SeverViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/4.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "SeverViewController.h"

@interface SeverViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** wechat */
@property (nonatomic,strong) UITextField *wechatView;

/** qq */
@property (nonatomic,strong) UITextField *qqTexfiled;

/** texfile */
@property (nonatomic,strong) UITextField *lastTexf;



@end

@implementation SeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"联系我们";
    
    [self.view addSubview:self.tableView];
}

-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIImageView *headerImageView = [[UIImageView alloc] initWithImage:kGetImage(@"HeaderBg")];
        
        headerImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        
        _tableView.tableHeaderView = headerImageView;
        
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *const identifer = @"identifer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        [cell.contentView addSubview:self.wechatView];
        [self.wechatView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);
            make.height.offset(35);
            make.width.offset(SCREEN_WIDTH-120);
        }];
    }else if (indexPath.section == 1)
    {
        [cell.contentView addSubview:self.qqTexfiled];
        [self.qqTexfiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);
            make.height.offset(35);
            make.width.offset(SCREEN_WIDTH-120);
        }];
    }else
    {
        [cell.contentView addSubview:self.lastTexf];
        [self.lastTexf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.offset(0);
            make.height.offset(35);
            make.width.offset(SCREEN_WIDTH-120);
        }];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    
    HJLayoutBtn *btn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
    }];
    
    if (section == 0) {
        
        [btn setImage:kGetImage(@"weiChatIcon") forState:UIControlStateNormal];
        [btn setTitle:@"客服微信号" forState:UIControlStateNormal];
        
    }else if (section == 1)
    {
        [btn setImage:kGetImage(@"qqIcon") forState:UIControlStateNormal];
        [btn setTitle:@"客服QQ号" forState:UIControlStateNormal];
    }else
    {
        [btn setTitle:@"联合创始人升级请微信联系" forState:UIControlStateNormal];
    }
    
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


-(UITextField *)wechatView
{
    if (!_wechatView) {
        
        _wechatView = [[UITextField alloc] init];
        _wechatView.font = [UIFont systemFontOfSize:15];
        _wechatView.layer.cornerRadius = 5.0f;
        _wechatView.layer.masksToBounds = YES;
        _wechatView.textColor = [UIColor blackColor];
        _wechatView.backgroundColor = [UIColor whiteColor];
        _wechatView.text = @"mxgg116";
        _wechatView.textAlignment = NSTextAlignmentCenter;
        _wechatView.delegate = self;
        
        UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [copyBtn setBackgroundColor:[UIColor colorWithHexString:@"#2ebe80"]];
        copyBtn.size = CGSizeMake(100, 35);
        [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
        copyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [copyBtn addTarget:self action:@selector(copyClick) forControlEvents:UIControlEventTouchUpInside];
        _wechatView.rightView = copyBtn;
        _wechatView.rightViewMode = UITextFieldViewModeAlways;
        
    }
    return _wechatView;
}

-(UITextField *)qqTexfiled
{
    if (!_qqTexfiled) {
        
        _qqTexfiled = [[UITextField alloc] init];
        _qqTexfiled.font = [UIFont systemFontOfSize:15];
        _qqTexfiled.layer.cornerRadius = 5.0f;
        _qqTexfiled.layer.masksToBounds = YES;
        _qqTexfiled.textColor = [UIColor blackColor];
        _qqTexfiled.backgroundColor = [UIColor whiteColor];
        _qqTexfiled.text = @"2748188477";
        _qqTexfiled.textAlignment = NSTextAlignmentCenter;
        _qqTexfiled.delegate = self;

        UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [copyBtn setBackgroundColor:[UIColor colorWithHexString:@"#41a4f9"]];
        copyBtn.size = CGSizeMake(100, 35);
        [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
        copyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [copyBtn addTarget:self action:@selector(qqCopyClick) forControlEvents:UIControlEventTouchUpInside];
        _qqTexfiled.rightView = copyBtn;
        _qqTexfiled.rightViewMode = UITextFieldViewModeAlways;
        
    }
    return _qqTexfiled;
}

-(UITextField *)lastTexf
{
    if (!_lastTexf) {
        
        _lastTexf = [[UITextField alloc] init];
        _lastTexf.font = [UIFont systemFontOfSize:15];
        _lastTexf.layer.cornerRadius = 5.0f;
        _lastTexf.layer.masksToBounds = YES;
        _lastTexf.textColor = [UIColor blackColor];
        _lastTexf.backgroundColor = [UIColor whiteColor];
        _lastTexf.text = @"2748188477";
        _lastTexf.textAlignment = NSTextAlignmentCenter;
        _lastTexf.delegate = self;
        
        UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [copyBtn setBackgroundColor:[UIColor colorWithHexString:@"#fa5654"]];
        copyBtn.size = CGSizeMake(100, 35);
        [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
        copyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [copyBtn addTarget:self action:@selector(lastCopyClick) forControlEvents:UIControlEventTouchUpInside];
        _lastTexf.rightView = copyBtn;
        _lastTexf.rightViewMode = UITextFieldViewModeAlways;


    }
    return _lastTexf;
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    self.wechatView.text = dic[@"weixin"];
    
    self.qqTexfiled.text = dic[@"qq"];
    
    self.lastTexf.text = dic[@"weixin2"];
}

-(void)copyClick
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.dic[@"weixin"];

    [HUDManager showTextHud:@"复制成功"];
}

-(void)qqCopyClick
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.dic[@"qq"];
    [HUDManager showTextHud:@"复制成功"];
}

-(void)lastCopyClick
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.dic[@"weixin2"];
    [HUDManager showTextHud:@"复制成功"];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}


@end
