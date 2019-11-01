//
//  inviteFriendsCollectionViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/5.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "inviteFriendsCollectionViewCell.h"

@implementation inviteFriendsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{

    UIImageView *bgImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.bgImageView = bgImageView;
    
}



@end
