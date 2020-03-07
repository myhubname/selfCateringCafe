//
//  CourseVideoDetailHeader.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/10.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "CourseVideoDetailHeader.h"

@implementation CourseVideoDetailHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    UIImageView *headerIcon = [[UIImageView alloc] init];
    headerIcon.userInteractionEnabled = YES;
    headerIcon.image = kGetImage(@"headerIcon");
    [self addSubview:headerIcon];
    [headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.headerImageView = headerIcon;
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setImage:kGetImage(@"CoursePlayIcon") forState:UIControlStateNormal];
    [self addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.width.height.offset(50);
    }];
    self.playButton = playBtn;
    
}


@end
