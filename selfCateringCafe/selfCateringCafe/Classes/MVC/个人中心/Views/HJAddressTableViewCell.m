//
//  HJAddressTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJAddressTableViewCell.h"

@interface HJAddressTableViewCell()

/** 昵称 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 联系电话 */
@property (nonatomic,weak) UILabel *phoneLabel;

/** 地址 */
@property (nonatomic,weak) UILabel *addressLabel;


@end

@implementation HJAddressTableViewCell

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
    
    UILabel *nameLabel = [UILabel labelWithFontSize:16 textColor:[UIColor blackColor]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
    }];
    self.nameLabel = nameLabel;
    
    
    UILabel *phoneLabel = [UILabel labelWithFontSize:16 textColor:[UIColor blackColor]];
    [self.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(nameLabel.mas_centerY);
    }];
    self.phoneLabel = phoneLabel;
    
   
    UILabel *addressLabel = [UILabel labelWithFontSize:14 textColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(15);
        make.right.offset(-15);
    }];
    self.addressLabel = addressLabel;
    
    
}

-(void)setModel:(HJAddressModel *)model
{
    _model = model;
    
    self.nameLabel.text = [NSString stringWithFormat:@"收货人:%@",model.user];
    
    self.phoneLabel.text = [NSString stringWithFormat:@"联系电话:%@",model.phone];
    
    self.addressLabel.text = [NSString stringWithFormat:@"收获地址:%@%@%@%@",model.pname,model.cname,model.rname,model.address];
    
}




@end
