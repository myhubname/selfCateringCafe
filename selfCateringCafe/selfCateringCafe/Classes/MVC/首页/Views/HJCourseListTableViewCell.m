//
//  HJCourseListTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/30.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJCourseListTableViewCell.h"

@implementation HJCourseListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UILabel *numLabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.offset(0);
    }];
    self.numLabel = numLabel;
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numLabel.mas_right).offset(10);
        make.centerY.equalTo(numLabel.mas_centerY);
    }];
    
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.offset(0);
    }];
    self.timeLabel = timeLabel;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
}


@end
