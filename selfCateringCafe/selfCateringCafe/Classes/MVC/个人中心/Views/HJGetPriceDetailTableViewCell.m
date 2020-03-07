//
//  HJGetPriceDetailTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2020/1/14.
//  Copyright © 2020 胡俊杰. All rights reserved.
//

#import "HJGetPriceDetailTableViewCell.h"

@implementation HJGetPriceDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    for (NSInteger i = 0; i < 3; i++) {
        
        UILabel *label = [UILabel labelWithFontSize:15 textColor:[UIColor lightGrayColor]];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(i * SCREEN_WIDTH/3);
            make.top.bottom.offset(0);
            make.width.offset(SCREEN_WIDTH/3);
        }];
        
        if (i == 0) {
            
            self.oneLabel = label;
        }else if (i == 1)
        {
            self.twoLabel = label;
        }else if (i == 2)
        {
            self.threeLabel = label;
        }
        
    }
}

@end
