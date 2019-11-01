//
//  HJMyTeamOneTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/17.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJMyTeamOneTableViewCell.h"

@implementation HJMyTeamOneTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    
    for (NSInteger i = 0; i<4; i++) {
        
        UILabel *label = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#5b595a"]];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SCREEN_WIDTH/4 * i);
            make.width.offset(SCREEN_WIDTH/4);
            make.top.bottom.offset(0);
        }];
        
        if (i == 0) {
            self.oneLabel = label;
        }else if (i == 1)
        {
            self.twoLabel = label;
        }else if (i == 2)
        {
            self.threeLabel = label;
        }else if (i == 3)
        {
            self.fourLabel = label;
        }
    }
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
    self.line = line;
    
}





@end
