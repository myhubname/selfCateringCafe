//
//  NSString+RegexCategory.m
//  Hardware
//
//  Created by 胡俊杰 on 2019/8/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "NSString+RegexCategory.h"

@implementation NSString (RegexCategory)

- (BOOL)isGifImage {
    
    NSString *ext = self.pathExtension.lowercaseString;
    
    if ([ext isEqualToString:@"gif"]) {
        return YES;
    }
    return NO;
}


@end
