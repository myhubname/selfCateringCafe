//
//  WelfareHeader.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/8/30.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "WelfareHeader.h"

@implementation WelfareHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#ff422a"];
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = kGetImage(@"Headerbg");
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(120);
    }];
    
    UIImageView *svgmoban = [[UIImageView alloc] init];
    svgmoban.image = kGetImage(@"svgmoban");
    [self addSubview:svgmoban];
    [svgmoban mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.centerY.offset(0);
    }];
    
    
}





@end
