//
//  HJCourseTopView.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/4.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJCourseTopView.h"

@implementation HJCourseTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    
    HJLayoutBtn *classBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [classBtn setImage:kGetImage(@"downArrow") forState:UIControlStateNormal];
    [classBtn setTitle:@"课程分类" forState:UIControlStateNormal];
    [classBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    classBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    classBtn.HJ_Style = HJLaoutBtnStyleImageRight;
    [self addSubview:classBtn];
    [classBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(0);
        make.width.offset(SCREEN_WIDTH/4);
    }];
    
    HJLayoutBtn *sellBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [sellBtn setTitle:@"销量" forState:UIControlStateNormal];
    sellBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sellBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    [sellBtn setImage:kGetImage(@"sortIconNomer") forState:UIControlStateNormal];
    sellBtn.HJ_Style = HJLaoutBtnStyleImageRight;
    [self addSubview:sellBtn];
    [sellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(classBtn.mas_right).offset(0);
        make.width.offset(SCREEN_WIDTH/4);
    }];
    
 
    HJLayoutBtn *priceBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    priceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [priceBtn setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    [priceBtn setImage:kGetImage(@"sortIconNomer") forState:UIControlStateNormal];
    priceBtn.HJ_Style = HJLaoutBtnStyleImageRight;
    [self addSubview:priceBtn];
    [priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(sellBtn.mas_right).offset(0);
        make.width.offset(SCREEN_WIDTH/4);
    }];
    
    
    HJLayoutBtn *timeSort = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [timeSort setTitle:@"时间" forState:UIControlStateNormal];
    timeSort.titleLabel.font = [UIFont systemFontOfSize:15];
    [timeSort setTitleColor:[UIColor colorWithHexString:@"#555555"] forState:UIControlStateNormal];
    [timeSort setImage:kGetImage(@"timeSort") forState:UIControlStateNormal];
    timeSort.HJ_Style = HJLaoutBtnStyleImageRight;
    [self addSubview:timeSort];
    [timeSort mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(priceBtn.mas_right).offset(0);
        make.width.offset(SCREEN_WIDTH/4);
    }];

    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
}


@end
