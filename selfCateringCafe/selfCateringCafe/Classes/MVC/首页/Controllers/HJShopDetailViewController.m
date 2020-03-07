//
//  HJShopDetailViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/13.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJShopDetailViewController.h"
#import <SDCycleScrollView.h>
#import <WebKit/WebKit.h>
#import "HJShopSubmitOrderViewController.h"
#import "HJLoginThirdGuideViewController.h"
#import "HJBaseNavViewController.h"
@interface HJShopDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,WKUIDelegate,WKNavigationDelegate>

/** 列表 */
@property (nonatomic,strong) HJBaseTableview *tableView;

/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView *sdcycleHeader;

/** 字典 */
@property (nonatomic,copy) NSDictionary *dic;


@property (nonatomic,strong) WKWebView *webView;

/*高度*/
@property (nonatomic,assign) CGFloat webHeight;

/** 按钮 */
@property (nonatomic,strong) UIButton *buyButton;



@end

@implementation HJShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"商品详情";
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.buyButton];
    
    [self getData];
}
#pragma mark-获取数据
-(void)getData
{
    [HUDManager showLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.detailId;
    [[HJNetWorkManager shareManager] AFGetDataUrl:@"Api/Convert/Item" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
         
            [HUDManager hidenHud];
            
            self.dic = result.data[@"data"];
            
            NSMutableArray *sdImageArray = [NSMutableArray array];
            
            [result.data[@"data"][@"anglepic"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                [sdImageArray addObject:[NSString stringWithFormat:@"%@%@",ApiImagefix,obj]];
            }];
            
            self.sdcycleHeader.imageURLStringsGroup = sdImageArray;
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.dic[@"url"]]]];
            
            [self.tableView reloadData];
            
        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark-轮播图
-(SDCycleScrollView *)sdcycleHeader
{
    if (!_sdcycleHeader) {
        
        _sdcycleHeader = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) delegate:self placeholderImage:kGetImage(squarePlaceholder)];
    }
    return _sdcycleHeader;
}

#pragma mark-创建列表
-(HJBaseTableview *)tableView
{
    if (!_tableView) {
        
        _tableView = [[HJBaseTableview alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight-TabBarHeight) style:UITableViewStyleGrouped andVc:self];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.sdcycleHeader;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1||indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        
        static NSString *const identifer = @"first";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.section == 0) {
            
            cell.textLabel.text = self.dic[@"productname"];
            
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            
            cell.textLabel.textColor = [UIColor blackColor];
        }else if (indexPath.section == 1)
        {
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            cell.textLabel.text = [NSString stringWithFormat:@"兑换需：%@ 积分",self.dic[@"integral"]];
            
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
            
            NSRange range = [cell.textLabel.text rangeOfString:[NSString stringWithFormat:@"%@",self.dic[@"integral"]]];
            
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            cell.textLabel.attributedText = attribute;
        }else if (indexPath.section == 2)
        {
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15];

            cell.textLabel.text = [NSString stringWithFormat:@"商品原价：%@ 元",self.dic[@"webprice"]];
            
        }else if (indexPath.section == 3)
        {
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15];

            cell.textLabel.text = [NSString stringWithFormat:@"已兑换：%@ 件",self.dic[@"convertnum"]];
            
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
            
            NSRange range = [cell.textLabel.text rangeOfString:[NSString stringWithFormat:@"%@",self.dic[@"convertnum"]]];
            
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            cell.textLabel.attributedText = attribute;

        }else if (indexPath.section == 4)
        {
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            cell.textLabel.text = [NSString stringWithFormat:@"还剩：%@ 件",self.dic[@"stock"]];
            
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:cell.textLabel.text];
            
            NSRange range = [cell.textLabel.text rangeOfString:[NSString stringWithFormat:@"%@",self.dic[@"stock"]]];
            
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            
            cell.textLabel.attributedText = attribute;
        }
        
        
        return cell;
        
    }else{
        
        static NSString *const identifer = @"identifer";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell.contentView addSubview:self.webView];
        
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
        return cell;
    }
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        
        CGFloat height = [self.dic[@"intro"] heightForFont:[UIFont systemFontOfSize:14] width:SCREEN_WIDTH-30];

        return height + 50;
    }else
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        
        UIView *footerView = [[UIView alloc] init];
        
        footerView.backgroundColor = [UIColor whiteColor];
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [footerView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-15);
            make.top.offset(5);
            make.bottom.offset(-5);
        }];
        
        UILabel *alertLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
        alertLabel.text = @"兑换说明:";
        [bgView addSubview:alertLabel];
        [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(10);
        }];
        
        UILabel *desLabel = [UILabel labelWithFontSize:14 textColor:[UIColor redColor]];
        desLabel.text = self.dic[@"intro"];
        desLabel.numberOfLines = 0;
        [bgView addSubview:desLabel];
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertLabel.mas_bottom).offset(5);
            make.right.offset(-10);
            make.left.offset(10);
        }];
        
        
        
        return footerView;
    }else
    {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CGFloat height = [self.dic[@"productname"] heightForFont:[UIFont systemFontOfSize:18] width:SCREEN_WIDTH-30];
        
        return height + 20;
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 ||indexPath.section == 4 )
    {
        return 30;
    }
    else
        return self.webHeight;
    
}
#pragma mark-创建网页
-(WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *confifg = [[WKWebViewConfiguration alloc] init];
        confifg.selectionGranularity = WKSelectionGranularityCharacter;
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        confifg.userContentController = wkUController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:confifg];
        _webView.scrollView.scrollEnabled = NO;
        _webView.userInteractionEnabled = NO;
        _webView.opaque = NO;
        _webView.scrollView.bounces = NO;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.decelerationRate=UIScrollViewDecelerationRateNormal;
    }
    return _webView;
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        CGFloat lastHeight  = [result doubleValue];
        webView.frame = CGRectMake(10, 0, SCREEN_WIDTH, lastHeight);
        self.webHeight = lastHeight;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }];
}

#pragma mark-购买按钮
-(UIButton *)buyButton{
    
    if (!_buyButton) {
        
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.frame = CGRectMake(0, SCREENH_HEIGHT-TabBarHeight, SCREEN_WIDTH, TabBarHeight);
        [_buyButton setBackgroundColor:[UIColor colorWithHexString:@"#F15A49"]];
        [_buyButton setTitle:@"我要兑换" forState:UIControlStateNormal];
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_buyButton addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _buyButton;
}

#pragma mark-购买
-(void)buyClick
{
    if (userDefaultGet(userid)) {
        
        HJShopSubmitOrderViewController *submitVc = [[HJShopSubmitOrderViewController alloc] init];
          submitVc.goodsId = self.dic[@"Id"];
          [self.navigationController pushViewController:submitVc animated:YES];
        
    }else
    {
        HJLoginThirdGuideViewController *thirdLogin = [[HJLoginThirdGuideViewController alloc] init];
        
        HJBaseNavViewController *nav = [[HJBaseNavViewController alloc] initWithRootViewController:thirdLogin];
        
        [self presentViewController:nav animated:YES completion:nil];

    }
    
  
    
}

@end

