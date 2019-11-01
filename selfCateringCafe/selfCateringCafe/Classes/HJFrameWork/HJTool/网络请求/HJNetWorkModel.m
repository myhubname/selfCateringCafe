//
//  HJNetWorkModel.m
//  Hardware
//
//  Created by 胡俊杰 on 2019/8/20.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJNetWorkModel.h"

@implementation HJNetWorkModel

-(BOOL)isSucess
{
    if ([_retCode integerValue] == 200) {
        
        return YES;
    }else
    {
        return NO;
    }
}

@end
