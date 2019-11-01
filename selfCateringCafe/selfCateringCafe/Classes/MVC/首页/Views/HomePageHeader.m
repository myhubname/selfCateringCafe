//
//  HomePageHeader.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HomePageHeader.h"
#import "LMJVerticalScrollText.h"
@interface HomePageHeader()<SDCycleScrollViewDelegate,LMJVerticalScrollTextDelegate>

/** 跑马灯 */
@property (nonatomic,weak) LMJVerticalScrollText *scrollerText;


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
        make.height.offset(200);
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
    [verticalScrollText startScrollBottomToTopWithNoSpace];
    [self addSubview:verticalScrollText];
    [verticalScrollText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertImageView.mas_right).offset(10);
        make.height.offset(20);
        make.right.offset(-20);
        make.centerY.equalTo(alertImageView.mas_centerY);
    }];
    self.scrollerText = verticalScrollText;
    
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
        
        _sdcyScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(20, 95, SCREEN_WIDTH-40, 150) delegate:self placeholderImage:kGetImage(@"sdcyScrollerBg")];
        _sdcyScrollView.backgroundColor = [UIColor clearColor];
    }
    return _sdcyScrollView;
}


-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    
    NSMutableArray *scrollorArray = [NSMutableArray array];
    [dic[@"newslist"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [scrollorArray addObject:obj[@"topic"]];
    }];
    
    self.scrollerText.textDataArr = scrollorArray;
    

}

- (void)verticalScrollText:(LMJVerticalScrollText *)scrollText clickIndex:(NSInteger)index content:(NSString *)content
{
    
    if (self.scroTextClick) {
        
        self.scroTextClick(self.dic[@"newslist"][index][@"url"]);
    }
    
}

@end
