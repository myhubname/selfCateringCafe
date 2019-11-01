//
//  UIImageView+initImageView.m
//  MyFrameWork
//
//  Created by HJ_StyleMac on 2018/12/28.
//  Copyright © 2018 HJ_StyleMac. All rights reserved.
//

#import "UIImageView+initImageView.h"

@implementation UIImageView (initImageView)

+(instancetype)initImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
   
    imageView.clipsToBounds = YES;
    
    [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    
    return imageView;
}

@end
