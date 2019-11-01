//
//  FanRingTableViewCell.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/2.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "FanRingTableViewCell.h"
#import "YYControl.h"
@interface FanRingTableViewCell()


/** 头像 */
@property (nonatomic,weak) UIImageView *iconImageView;

/** 昵称 */
@property (nonatomic,weak) UILabel *nameLabel;

/** 内容 */
@property (nonatomic,weak) UILabel *connentLabel;

@property (nonatomic, strong) fanBottomView *toolbarView; // 工具栏

@end
@implementation FanRingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = kGetImage(@"userIcon");
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(15);
        make.width.height.offset(50);
    }];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#ff4137"]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(10);
        make.top.equalTo(iconImageView.mas_top).offset(5);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *connentLabel = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#494949"]];
    connentLabel.numberOfLines = 0;
    [self.contentView addSubview:connentLabel];
    [connentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(iconImageView.mas_bottom).offset(-15);
        make.right.offset(-10);
    }];
    self.connentLabel = connentLabel;
    @weakify(self);
    NSMutableArray *picViews = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        YYControl *imageView = [YYControl new];
        imageView.size = CGSizeMake(100, 100);
        imageView.hidden = YES;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = UIColorHex(f0f0f0);
        imageView.exclusiveTouch = YES;
        
        imageView.touchBlock = ^(YYControl *view, YYGestureRecognizerState state, NSSet *touches, UIEvent *event) {
            if (![weak_self.delegate respondsToSelector:@selector(cell:didClickImageAtIndex:)]) return;
            if (state == YYGestureRecognizerStateEnded) {
                UITouch *touch = touches.anyObject;
                CGPoint p = [touch locationInView:view];
                if (CGRectContainsPoint(view.bounds, p)) {
                    [weak_self.delegate cell:weak_self didClickImageAtIndex:i];
                }
            }
        };
    
        [picViews addObject:imageView];
        [self.contentView addSubview:imageView];
    }
    _picViews = picViews;
    
    
    _toolbarView = [fanBottomView new];
    [self.contentView addSubview:_toolbarView];

}

-(void)setModel:(FanRingModel *)model
{
    _model = model;
    CGFloat top = 0;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,model.pic]] placeholder:kGetImage(squarePlaceholder)];
    
    self.nameLabel.text = model.author;
    
    top += model.userHeight;

    
    self.connentLabel.top = top;
    self.connentLabel.height = model.textHeight;
    self.connentLabel.text = model.intro;

    top += model.textHeight;

    
    if (model.picHeight > 0) {
        
        [self _setImageViewWithTop:top];
    }
    
    self.toolbarView.bottom = model.height - 10;
    self.toolbarView.model = model;
    self.toolbarView.cell = self;

}
- (void)_setImageViewWithTop:(CGFloat)imageTop {
    CGSize picSize =  self.model.picSize;
    NSArray *pics =  self.model.cover;
    int picsCount = (int)pics.count;
    
    for (int i = 0; i < 9; i++) {
        UIView *imageView = _picViews[i];
        if (i >= picsCount) {
            [imageView.layer cancelCurrentImageRequest];
            imageView.hidden = YES;
        } else {
            CGPoint origin = {0};
            switch (picsCount) {
                case 1: {
                    origin.x = kWBCellPadding;
                    origin.y = imageTop;
                } break;
                case 4: {
                    origin.x = kWBCellPadding + (i % 2) * (picSize.width + kWBCellPaddingPic);
                    origin.y = imageTop + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                } break;
                default: {
                    origin.x = kWBCellPadding + (i % 3) * (picSize.width + kWBCellPaddingPic);
                    origin.y = imageTop + (int)(i / 3) * (picSize.height + kWBCellPaddingPic);
                } break;
            }
            imageView.frame = (CGRect){.origin = origin, .size = picSize};
            imageView.hidden = NO;
            [imageView.layer removeAnimationForKey:@"contents"];
            NSString *imageUrl = pics[i];
            @weakify(imageView);
            [imageView.layer setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,imageUrl]]
                                 placeholder:nil
                                     options:YYWebImageOptionAvoidSetImage
                                  completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                                      @strongify(imageView);
                                      if (!imageView) return;
                                      if (image && stage == YYWebImageStageFinished) {
                                          int width = image.size.width;
                                          int height = image.size.height;
                                          CGFloat scale = (height / width) / (imageView.height / imageView.width);
                                          if (scale < 0.99 || isnan(scale)) { // 宽图把左右两边裁掉
                                              imageView.contentMode = UIViewContentModeScaleAspectFill;
                                              imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
                                          } else { // 高图只保留顶部
                                              imageView.contentMode = UIViewContentModeScaleToFill;
                                              imageView.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
                                          }
                                          ((YYControl *)imageView).image = image;
                                          if (from != YYWebImageFromMemoryCacheFast) {
                                              CATransition *transition = [CATransition animation];
                                              transition.duration = 0.15;
                                              transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                                              transition.type = kCATransitionFade;
                                              [imageView.layer addAnimation:transition forKey:@"contents"];
                                          }
                                      }
                                  }];
        }
    }
}


-(void)setFrame:(CGRect)frame
{
    frame.origin.y += 10;
    
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
}


@end
@implementation fanBottomView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 50;
    }
    self = [super initWithFrame:frame];
    self.exclusiveTouch = YES;

    [self creatUI];
    
    
    return self;
}

-(void)creatUI
{
    
    HJLayoutBtn *savePhotoBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [savePhotoBtn setImage:kGetImage(@"saveIcon") forState:UIControlStateNormal];
    [savePhotoBtn setTitle:@"保存图片" forState:UIControlStateNormal];
    savePhotoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    savePhotoBtn.HJ_Style = HJLaoutBtnStyleImageLeft;
    [savePhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [savePhotoBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:savePhotoBtn];
    [savePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.bottom.offset(0);
        make.width.offset((SCREEN_WIDTH-0.5)/2);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(savePhotoBtn.mas_right).offset(0);
        make.width.offset(1);
        make.top.offset(15);
        make.bottom.offset(-15);
    }];
    
    HJLayoutBtn *downBtn = [HJLayoutBtn buttonWithType:UIButtonTypeCustom];
    [downBtn setImage:kGetImage(@"ForwardIcon") forState:UIControlStateNormal];
    [downBtn setTitle:@"一键转发" forState:UIControlStateNormal];
    downBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [downBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    downBtn.HJ_Style = HJLaoutBtnStyleImageLeft;
    [downBtn addTarget:self action:@selector(downClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:downBtn];
    [downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).offset(0);
        make.right.offset(0);
        make.top.bottom.offset(0);
    }];
    
    
    UIView *Hline = [[UIView alloc] init];
    Hline.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
    [self addSubview:Hline];
    [Hline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(1);
    }];
}

-(void)saveClick
{
    [HUDManager showLoadingHud:@"正在保存图片..."];
    [self.model.cover enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
   
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,obj]]];
        
        UIImage *image = [UIImage imageWithData:data];
        
        UIImageWriteToSavedPhotosAlbum(image,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
        
    }];
    
    
}

//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        [HUDManager showStateHud:@"图片保存失败" state:HUDStateTypeFail];
    }
    else  // No errors
    {
        [HUDManager showStateHud:@"图片保存成功" state:HUDStateTypeSuccess];

    }
}
-(void)downClick
{
    if ([self.cell.delegate respondsToSelector:@selector(cellDidClickRepost:)]) {
        
        [self.cell.delegate cellDidClickRepost:self.cell];
    }
    
}

@end

