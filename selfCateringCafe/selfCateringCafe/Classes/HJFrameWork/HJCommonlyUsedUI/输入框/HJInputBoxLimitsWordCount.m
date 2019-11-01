//
//  HJInputBoxLimitsWordCount.m
//  lawyer
//
//  Created by 胡俊杰 on 2019/1/5.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import "HJInputBoxLimitsWordCount.h"
@interface HJInputBoxLimitsWordCount()<UITextViewDelegate>

/**输入框*/
@property (nonatomic,strong) HJPlaceHodelTextView *textView;

/**数量*/
@property (nonatomic,strong)UILabel *numLabel;

/**最大数量*/
@property (nonatomic,assign)NSInteger maxFontCount;

@end

@implementation HJInputBoxLimitsWordCount

-(instancetype)initWithCount:(NSInteger)Count andPlaceHodel:(NSString *)placeHodel
{
    if (self = [super init]) {
    
        self.maxFontCount = Count;

        self.textView.placeholder = placeHodel;
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(-10);
            make.top.offset(10);
            make.bottom.offset(-30);
        }];
        self.numLabel.text = [NSString stringWithFormat:@"0/%ld",(long)Count];
        [self addSubview:self.numLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.top.equalTo(self.textView.mas_bottom);
            make.bottom.offset(0);
        }];
        
    }
    return self;
}

#pragma mark-输入框
-(HJPlaceHodelTextView *)textView
{
    if (!_textView) {
        
        _textView = [[HJPlaceHodelTextView alloc] init];
        _textView.delegate = self;
    }
    return _textView;
}


#pragma mark-提示数字
-(UILabel *)numLabel
{
    if (!_numLabel) {
        
        _numLabel = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor]];
    }
    return _numLabel;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < self.maxFontCount) {
            
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = self.maxFontCount - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx++;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            self.numLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)self.maxFontCount];
        }
        return NO;
    }
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.changeBlock) {
        
        self.changeBlock(textView);
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > self.maxFontCount)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:self.maxFontCount];
        
        [textView setText:s];
    }
    
    //不让显示负数 口口日
    self.numLabel.text = [NSString stringWithFormat:@"%ld/%ld", existTextNum,(long)self.maxFontCount];
}
@end
