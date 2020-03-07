//
//  WelfareViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "WelfareViewController.h"
#import "WelfareHeader.h"
#import "WelfareInviteFrend.h"
#import "HJVipinterests.h"
@interface WelfareViewController ()

/** 列表 */
@property (nonatomic,strong) UIScrollView *scrollerView;

/** 头部视图 */
@property (nonatomic,strong) WelfareHeader *Header;

/** WelfareInviteFrend */
@property (nonatomic,strong) WelfareInviteFrend *frendView;

/** giftICon  */
@property (nonatomic,strong) UIImageView *giftImageView;

/** HJVipinterests */
@property (nonatomic,strong) HJVipinterests *vipView;



@end

@implementation WelfareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.hidden = YES;
    
    if (@available(iOS 11.0,*)) {
        self.scrollerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        //automaticallyAdjustsScrollViewIn，关闭自动偏移的系统优化
        self.automaticallyAdjustsScrollViewInsets = NO;;
    }

    
    [self.view addSubview:self.scrollerView];
    
    [self.scrollerView addSubview:self.Header];

    [self.scrollerView addSubview:self.frendView];

    [self.scrollerView addSubview:self.giftImageView];
    
    [self.scrollerView addSubview:self.vipView];
}

-(WelfareHeader *)Header
{
    if (!_Header) {
        
        _Header = [[WelfareHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    }
    return _Header;
}
-(UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        _scrollerView.backgroundColor = [UIColor colorWithHexString:@"#ff663a"];
        
        _scrollerView.contentSize = CGSizeMake(0, SCREENH_HEIGHT + (self.vipView.top+self.vipView.height-SCREENH_HEIGHT)+TabBarHeight+15);
    }
    return _scrollerView;
}

-(UIImageView *)giftImageView
{
    if (!_giftImageView) {
        
        _giftImageView = [[UIImageView alloc] init];
        _giftImageView.image = kGetImage(@"giftIcon");
        _giftImageView.frame = CGRectMake(SCREEN_WIDTH-159, self.Header.top+self.Header.height-148, 144, 148);
    }
    return _giftImageView;
}

-(WelfareInviteFrend *)frendView
{
    if (!_frendView) {

        _frendView = [[WelfareInviteFrend alloc] initWithFrame:CGRectMake(15, self.giftImageView.top+self.giftImageView.height-30, SCREEN_WIDTH-30, 350)];
    }
    return _frendView;
}

-(HJVipinterests *)vipView
{
    if (!_vipView) {
        
        _vipView = [[HJVipinterests alloc] initWithFrame:CGRectMake(15, self.frendView.height+self.frendView.top+30, SCREEN_WIDTH-30, 350)];
        
        _vipView.vipArray = @[@{@"image":@"sharedIcon",@"name":@"人脉资源共享",@"des":@"知识、经验分享"},@{@"image":@"MemberBillingIcon",@"name":@"直接会员出单",@"des":@"享30%奖励分佣"},@{@"image":@"indirectIcon",@"name":@"间接会员出单",@"des":@"享极差奖励分佣"},@{@"image":@"CoursegiftIcon",@"name":@"获赠系统课程",@"des":@"玩赚抖音实操营"},@{@"image":@"LearningMaterialsIcon",@"name":@"内部学习资料",@"des":@"不定期更新"},@{@"image":@"PromotionIcon",@"name":@"运营能力提升",@"des":@"抖音大咖干货"}];
    }
    return _vipView;
}



@end
