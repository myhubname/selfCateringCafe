//
//  HJTexfLineImageTableViewCell.m
//  lawyer
//
//  Created by 胡俊杰 on 2019/1/1.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import "HJTexfLineImageTableViewCell.h"

@implementation HJTexfLineImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.texf];
        [self.texf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(30);
            make.right.offset(-30);
            make.top.offset(10);
            make.bottom.offset(-1);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithHexString:@"#eae9e9"];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.texf);
            make.height.offset(1);
            make.bottom.offset(0);
        }];
        self.line = line;
    }
    return self;
}

-(UITextField *)texf
{
    if (!_texf) {
        
        _texf = [[UITextField alloc] init];
        _texf.font = [UIFont systemFontOfSize:15];
        _texf.textColor = [UIColor blackColor];
        [_texf setTintColor:[UIColor colorWithHexString:@"#f65a5c"]];
        [_texf addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        leftBtn.size = CGSizeMake(50, 50);
        self.leftAlertBtn = leftBtn;
        _texf.leftView = leftBtn;
        _texf.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return _texf;
}

#pragma mark-输入监听
-(void)changeValue:(UITextField *)texf
{
    if (self.changeBlock) {
        
        self.changeBlock(texf);
    }
}

@end
