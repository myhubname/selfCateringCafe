//
//  FanRingModel.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/2.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "FanRingModel.h"

@implementation FanRingModel



- (void)_layoutPics{
    _picSize = CGSizeZero;
    _picHeight = 0;
    if (_cover.count == 0) return;
    
    CGSize picSize = CGSizeZero;
    CGFloat picHeight = 0;
    
    CGFloat len1_3 = (kWBCellContentWidth + kWBCellPaddingPic) / 3 - kWBCellPaddingPic;
    len1_3 = CGFloatPixelRound(len1_3);
    switch (_cover.count) {
        case 1: {
            picSize = CGSizeMake(184, 185);
            picHeight = picSize.height;
        } break;
        case 2: case 3: {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3;
        } break;
        case 4: case 5: case 6: {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 2 + kWBCellPaddingPic;
        } break;
        default: { // 7, 8, 9
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 3 + kWBCellPaddingPic * 2;
        } break;
    }
    
    _picSize = picSize;
    _picHeight = picHeight;
}

- (void)_layoutText {
    
    _textHeight = [_intro heightForFont:[UIFont systemFontOfSize:15] width:SCREEN_WIDTH-95];
    
}

-(CGFloat)height
{
    
    _titleHeight = 0;
    
    _userHeight = 65;
    
    _textHeight = 0;
    
    _picHeight = 0;
    
    _toolbarHeight = 50;
    
    [self _layoutText];
    
    [self _layoutPics];
    
    _height = 0;
    
    _height += _userHeight;
    
    _height += _textHeight;
    
    if (_picHeight > 0) {
        
        _height += _picHeight;
    }
    
    _height += _toolbarHeight;

    _height += 30;
    
    return _height;
}

@end
