//
//  HJAddressFooter.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJAddressFooter.h"

@interface HJAddressFooter()

/**  按钮 */
@property (nonatomic,weak) HJLayoutBtn *defaultBtn;

@end

@implementation HJAddressFooter

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
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(1);
        make.bottom.offset(-10);
    }];
    
    HJLayoutBtn *defaultBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [defaultBtn setTitle:@"默认地址" forState:UIControlStateNormal];
    [defaultBtn setImage:kGetImage(@"PayTickNomer") forState:UIControlStateNormal];
    [defaultBtn setImage:kGetImage(@"PayTickSel") forState:UIControlStateSelected];
    [defaultBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [defaultBtn addTarget:self action:@selector(setDefaultClick:) forControlEvents:UIControlEventTouchUpInside];
    defaultBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:defaultBtn];
    [defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.bottom.offset(0);
        make.width.offset((SCREEN_WIDTH-60)/4);
    }];
    self.defaultBtn = defaultBtn;
    
  
    HJLayoutBtn *delBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    delBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [delBtn setImage:kGetImage(@"delIcon") forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(delClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:delBtn];
    [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.width.equalTo(defaultBtn);
        make.top.bottom.offset(0);
    }];
    
    
    HJLayoutBtn *editBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setImage:kGetImage(@"editIcon") forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [editBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(delBtn.mas_left);
        make.width.equalTo(delBtn);
        make.top.bottom.offset(0);
    }];
    
    

    
    
}


-(void)setModel:(HJAddressModel *)model
{
    _model = model;

    if ([model.isdefault integerValue] == 0) {
       
        self.defaultBtn.selected = NO;
    
    }else
    {
        self.defaultBtn.selected = YES;
    }
    
}


-(void)setDefaultClick:(HJLayoutBtn *)sender
{
    [HUDManager showLoading];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    params[@"id"] = self.model.Id;
    
    if (sender.selected == YES) {
        
        params[@"act"] = @"cancel";
    }else{
        
        params[@"act"] = @"";
    }
    
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/SetAddressDefault" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            if (self.setDefaultBlock) {
                
                self.setDefaultBlock();
            }
            
            
        }
        
        
    } Faild:^(NSError * _Nonnull error) {
        
        
    }];
}


-(void)delClick
{
    [HUDManager showLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = userDefaultGet(userid);
    params[@"id"] = self.model.Id;
    [[HJNetWorkManager shareManager] AFPostDataUrl:@"Api/User/AddressDel" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            [HUDManager hidenHud];
            if (self.setDefaultBlock) {
                self.setDefaultBlock();
            }
        }
    } Faild:^(NSError * _Nonnull error) {
    }];
}


-(void)editClick
{
    if (self.editBlock) {
        
        self.editBlock(self.model);
    }
    
}


@end
