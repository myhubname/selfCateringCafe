//
//  HomePageHeader.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HomePageHeader.h"
#import <SDCycleScrollView.h>
#import "LMJVerticalScrollText.h"
@interface HomePageHeader()<SDCycleScrollViewDelegate,LMJVerticalScrollTextDelegate>

/** 轮播图 */
@property (nonatomic,strong) SDCycleScrollView *sdcyScrollView;



@end
@implementation HomePageHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = kGetImage(@"HompageHeaderBGIcon");
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(155);
    }];
    
    [self addSubview:self.sdcyScrollView];
    
    UIImageView *alertImageView = [[UIImageView alloc] init];
    alertImageView.image = kGetImage(@"newTopic");
    [self addSubview:alertImageView];
    [alertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(self.sdcyScrollView.mas_bottom).offset(15);
        make.height.offset(13);
        make.width.offset(53);
    }];

    LMJVerticalScrollText * verticalScrollText = [[LMJVerticalScrollText alloc] initWithFrame:CGRectMake(83, 0, SCREEN_WIDTH-103, 20)];
    verticalScrollText.delegate        = self;
    verticalScrollText.backgroundColor = [UIColor whiteColor];
    verticalScrollText.textColor       = [UIColor blackColor];
    verticalScrollText.textFont        = [UIFont systemFontOfSize:12.f];
    verticalScrollText.textDataArr     = @[@"这是一条数据：000000",@"这是一条数据：111111",@"这是一条数据：222222",@"这是一条数据：333333",@"这是一条数据：444444",@"这是一条数据：555555"];
    [verticalScrollText startScrollBottomToTopWithNoSpace];
    [self addSubview:verticalScrollText];
    [verticalScrollText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertImageView.mas_right).offset(10);
        make.height.offset(20);
        make.right.offset(-20);
        make.centerY.equalTo(alertImageView.mas_centerY);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(1);
    }];
    
}

-(SDCycleScrollView *)sdcyScrollView
{
    if (!_sdcyScrollView) {
        
        _sdcyScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(20, 77.5, SCREEN_WIDTH-40, 143) delegate:self placeholderImage:kGetImage(@"sdcyScrollerBg")];
        _sdcyScrollView.backgroundColor = [UIColor clearColor];
    }
    return _sdcyScrollView;
}


@end
