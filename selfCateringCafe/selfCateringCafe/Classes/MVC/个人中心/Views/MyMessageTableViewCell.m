//
//  MyMessageTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/18.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "MyMessageTableViewCell.h"

@interface MyMessageTableViewCell()

/** 商品图片 */
@property (nonatomic,weak) UIImageView *goodsImageView;

/** 商品n名称 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 描述 */
@property (nonatomic,weak) UILabel *detailLabel;

/** a提示 */
@property (nonatomic,weak) UIView *alertView;

@end

@implementation MyMessageTableViewCell

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
    
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
        make.width.height.offset(80);
    }];
    self.goodsImageView = goodsImageView;
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImageView.mas_right).offset(10);
        make.top.equalTo(goodsImageView.mas_top);
        make.right.offset(-100);
    }];
    self.nameLabel = nameLabel;
    
    
    UILabel *detailLabel = [UILabel labelWithFontSize:12 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.bottom.equalTo(goodsImageView.mas_bottom);
    }];
    
    self.detailLabel = detailLabel;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.width.height.offset(8);
        make.centerY.equalTo(detailLabel.mas_centerY).offset(0);
    }];
    
    redView.layer.cornerRadius = 4.0f;
    redView.layer.masksToBounds = YES;
    self.alertView = redView;
    
}


-(void)setModel:(HJMessageModel *)model
{
    _model = model;
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,model.pic]] placeholder:kGetImage(squarePlaceholder)];
    
    self.nameLabel.text = model.topic;
    
    self.detailLabel.text = model.msg;
    
    
    if ([model.isread integerValue] == 1) {
        
        self.alertView.hidden = YES;
    }else{
        
        self.alertView.hidden = NO;
    }
    
}


@end
