//
//  HJUseTutorialTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJUseTutorialTableViewCell.h"

@interface HJUseTutorialTableViewCell()

/** 图片 */
@property (nonatomic,weak) UIImageView *iconImageView;

/** 标题 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 时间 */
@property (nonatomic,weak) UILabel *timeLabel;

/** 描述 */
@property (nonatomic,weak) UILabel *desLabel;

@end

@implementation HJUseTutorialTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
        make.width.height.offset(100);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(10);
        make.top.equalTo(iconImageView.mas_top).offset(10);
    }];
    self.nameLabel = nameLabel;

    UILabel *timeLabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(nameLabel.mas_centerY).offset(0);
    }];
    self.timeLabel = timeLabel;

    UILabel *desLabel = [UILabel labelWithFontSize:14 textColor:[UIColor lightGrayColor]];
    desLabel.numberOfLines = 2;
    [self.contentView addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(15);
        make.right.offset(-10);
    }];
    self.desLabel = desLabel;
    
}

-(void)setModel:(UseTutorialModel *)model
{
    _model = model;
    
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,model.pic]] placeholder:kGetImage(squarePlaceholder)];
    
    
    self.nameLabel.text = model.topic;
    
    
    self.timeLabel.text = model.date;
    
    self.desLabel.text = model.intro;
    
}



@end
