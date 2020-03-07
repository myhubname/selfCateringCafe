//
//  HJProgressView.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/29.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJProgressView.h"

@interface HJProgressView()

/** 图片  */
@property (nonatomic,strong) UIImageView *progressImageView;

@end

@implementation HJProgressView

-(instancetype)init
{
    if (self = [super init]) {
     
        self.backgroundColor = [UIColor colorWithHexString:@"#ffe5ec"];
        
        self.progressImageView.frame = CGRectMake(0, 0, 0, 15);
        
        [self addSubview:self.progressImageView];

    }
    return self;
}

-(UIImageView *)progressImageView
{
    if (!_progressImageView) {
        
        _progressImageView = [[UIImageView alloc] initWithImage:kGetImage(@"progressIcon")];
    }
    return _progressImageView;
}


-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    self.progressImageView.width = (SCREEN_WIDTH-120) * progress;

}




@end
