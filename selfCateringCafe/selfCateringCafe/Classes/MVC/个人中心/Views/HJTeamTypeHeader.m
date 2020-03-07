//
//  HJTeamTypeHeader.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/17.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJTeamTypeHeader.h"

@interface HJTeamTypeHeader()

/** line */
@property (nonatomic,weak) UIView *line;

/** 选中按钮 */
@property (nonatomic,weak) UIButton *selectedBtn;

/** bgView */
@property (nonatomic,weak) UIView *bgView;

@end

@implementation HJTeamTypeHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 60-11);
    [self.contentView addSubview:bgView];
    self.bgView = bgView;
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#fd5b48"];
    line.height = 2;
    line.top = 58;
    self.line = line;

    NSArray *dataArray = @[@"直属会员",@"直属会员下级",@"直邀VIP"];

    for (NSInteger i = 0; i < dataArray.count; i++) {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.top = 0;
        button.height = 50;
        button.width = SCREEN_WIDTH/dataArray.count;
        button.left = i * button.width;
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:dataArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titleclick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
        if (i == 0) {

            button.enabled = NO;
            self.selectedBtn  = button;
            [button.titleLabel sizeToFit];
            line.width=button.titleLabel.width;
            line.centerX=button.centerX;
        }
    }

    [self addSubview:line];

}


#pragma mark-选中按钮
-(void)titleclick:(UIButton *)sender
{
    self.selectedBtn.enabled = YES;
    sender.enabled = NO;
    self.selectedBtn = sender;

    [UIView animateWithDuration:0.25 animations:^{

        self.line.width = sender.titleLabel.width;
        self.line.centerX = sender.centerX;
    }];
    
    if (self.teamBlock) {
        
        self.teamBlock(sender.tag+1);
    }
    
}


-(void)setType:(NSInteger)type
{
    _type = type;
    
    self.selectedBtn.enabled = YES;
    UIButton *btn = self.bgView.subviews[type-1];
    btn.enabled = NO;
    self.selectedBtn = btn;
    [btn.titleLabel sizeToFit];
    self.line.width=btn.titleLabel.width;
    self.line.centerX=btn.centerX;

    
}


@end
