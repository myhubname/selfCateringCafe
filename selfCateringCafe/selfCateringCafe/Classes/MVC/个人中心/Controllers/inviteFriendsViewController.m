//
//  inviteFriendsViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/5.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "inviteFriendsViewController.h"
#import <RFLayout.h>
#import "inviteFriendsCollectionViewCell.h"
#import "inviteFriendsBottom.h"
#import "HJRecommendAlertView.h"

@interface inviteFriendsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

/** 数组 */
@property (nonatomic,copy) NSDictionary *dataDic;

/** inviteFriendsBottom */
@property (nonatomic,strong) inviteFriendsBottom *bottomView;



@end

@implementation inviteFriendsViewController
static NSString *const identifer = @"identifer";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"邀请好友";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.bottomView];

    [self getData];
}
#pragma mark-获取数据
-(void)getData
{
    [HUDManager showLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/getPoster" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
         
            [HUDManager hidenHud];
            
            self.dataDic = result.data;
            
            self.bottomView.inviteNumLabel.text = result.data[@"usernumber"];
         
            [self.collectionView reloadData];
        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
    
}

-(inviteFriendsBottom *)bottomView
{
    if (!_bottomView) {
        
        _bottomView = [[inviteFriendsBottom alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT-150, SCREEN_WIDTH, 150)];
        
        __weak typeof(self)weakself = self;
        _bottomView.ShareBlock = ^(NSInteger tag) {
            [weakself shareClick:tag];
        };
        
    }
    return _bottomView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        RFLayout *flowLayout = [[RFLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(250, 444);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREENH_HEIGHT-TopHeight-150) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[inviteFriendsCollectionViewCell class] forCellWithReuseIdentifier:identifer];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataDic[@"poster"] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    inviteFriendsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
 
    [cell.bgImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,self.dataDic[@"poster"][indexPath.item]]] placeholder:kGetImage(@"")];
    
    return cell;
}

-(void)shareClick:(NSInteger)tag
{
    __weak typeof(self)weakself = self;
    [HJRecommendAlertView showShareView:@[@{@"name":@"微信",@"image":@"icon_WeChat"},@{@"name":@"微信朋友圈",@"image":@"icon_ChatFrend"},@{@"name":@"QQ",@"image":@"icon_QQ"},@{@"name":@"QQ空间",@"image":@"icon_zone"}] AndSelectedItem:^(NSDictionary *selectedDic) {
       
        
        if ([selectedDic[@"name"] isEqualToString:@"微信"]) {
            
            WXMediaMessage *message = [WXMediaMessage message];
            
            message.title = @"以恒";
            message.description = [NSString stringWithFormat:@"邀请码：%@",self.dataDic[@"usernumber"]];
            [message setThumbImage:[self getImageFromURL:[NSString stringWithFormat:@"%@%@",ApiImagefix,self.dataDic[@"logo"]]]];
            
            WXWebpageObject *webpageObject = [WXWebpageObject object];
            webpageObject.webpageUrl = @"www.baidu.com";
            message.mediaObject = webpageObject;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = 0;
            [WXApi sendReq:req completion:^(BOOL success) {
                if (success == NO) {
                    
                    [HUDManager showTextHud:@"分享失败"];
                }
                
            }];
            
        }
        
        
    }];
    
}
-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
}



@end
