//
//  BreakdownTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/19.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "BreakdownTableViewCell.h"

@implementation BreakdownTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    for (NSInteger i = 0; i < 4; i++) {
        
        UILabel *label = [UILabel labelWithFontSize:15 textColor:[UIColor lightGrayColor]];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"1";
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(i * SCREEN_WIDTH/4);
            make.top.bottom.offset(0);
            make.width.offset(SCREEN_WIDTH/4);
        }];
    }
    
    
}




@end
