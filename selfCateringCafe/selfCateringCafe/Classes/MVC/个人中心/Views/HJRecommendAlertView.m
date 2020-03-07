//
//  HJRecommendAlertView.m
//  YDPT-OC
//
//  Created by 嘉瑞科技有限公司 on 2018/3/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HJRecommendAlertView.h"
@interface HJRecommendAlertView()<UICollectionViewDelegate,UICollectionViewDataSource>

/*弹出视图*/
@property(nonatomic,strong) UIView *alertView;

// 背景视图
@property (nonatomic, strong) UIView *backgroundView;

/*内容*/
@property(nonatomic,strong) UICollectionView *collectioinView;

/*底部视图*/
@property(nonatomic,strong) UIView *botoomView;

/*按钮*/
@property(nonatomic,strong) UIButton *CancelBtn;

@property(nonatomic,copy) selectedItem itemBlock;

@property(nonatomic,copy) NSArray *items;

/*topVIew*/
@property (nonatomic,strong) UIView *topView;

/*视图高度*/
@property (nonatomic,assign) CGFloat ViewHeight;

@end
@implementation HJRecommendAlertView
static NSString *const identifer = @"shareItem";

+(void)showShareView:(NSArray *)shareItems AndSelectedItem:(selectedItem)itemBlock
{
    HJRecommendAlertView *shareAlertView = [[HJRecommendAlertView alloc] initWithArr:shareItems andItem:itemBlock];
    
    [shareAlertView showWithAnimation:YES];
}


-(instancetype)initWithArr:(NSArray *)shareArr andItem:(selectedItem)itemBlock
{
    if (self = [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;

        self.items = shareArr;
        
        if (shareArr.count > 5) {
            
            self.ViewHeight = [self getCellHeight:shareArr];

        }else
        {
            self.ViewHeight = (SCREEN_WIDTH-60)/5 + 25 + 45;
        }
        
        self.itemBlock = itemBlock;
        
        [self initUI];
        
    }
    return self;
}

#pragma mark - 初始化子视图
-(void)initUI
{
    [self addSubview:self.backgroundView];
    
    [self addSubview:self.alertView];
    
    [self.alertView addSubview:self.topView];
    
    [self.alertView addSubview:self.collectioinView];
    
    [self.alertView addSubview:self.botoomView];
    
    [self.botoomView addSubview:self.CancelBtn];
    [self.CancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.collectioinView.mas_bottom);
        make.bottom.offset(0);
    }];
    

    UILabel *titleLabel = [UILabel labelWithFontSize:17 textColor:[UIColor blackColor]];
    titleLabel.text = @"分享到";
    [self.topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    
}
#pragma mark - 背景遮罩图层
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.20];
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:myTap];
    }
    return _backgroundView;
}

-(UIView *)alertView
{
    if (!_alertView) {
        
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, self.ViewHeight + 45 + 45)];
        _alertView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    }
    return _alertView;
}

-(UICollectionView *)collectioinView
{
    if (!_collectioinView) {
        UICollectionViewFlowLayout *flowyout = [[UICollectionViewFlowLayout alloc] init];
        flowyout.itemSize = CGSizeMake((SCREEN_WIDTH-50)/4, (SCREEN_WIDTH-50)/4 + 25);
        flowyout.minimumLineSpacing = 10;
        flowyout.minimumInteritemSpacing = 10;
        flowyout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectioinView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.topView.height+self.topView.origin.y, SCREEN_WIDTH, self.ViewHeight) collectionViewLayout:flowyout];
        _collectioinView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _collectioinView.delegate = self;
        _collectioinView.dataSource = self;
        [_collectioinView registerClass:[ShareCollectionViewCell class] forCellWithReuseIdentifier:identifer];
            
    }
    return _collectioinView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    cell.shareImageView.image = kGetImage(self.items[indexPath.row][@"image"]);
    
    cell.titleLabel.text = self.items[indexPath.row][@"name"];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemBlock) {
        self.itemBlock(self.items[indexPath.row]);
    }
    [self dismissWithAnimation:YES];
}
-(UIView *)botoomView
{
    if (!_botoomView) {
        
        _botoomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.collectioinView.origin.y+self.collectioinView.height, SCREEN_WIDTH, 45)];
        _botoomView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        
    }
    return _botoomView;
}

-(UIButton *)CancelBtn
{
    if (!_CancelBtn) {
        
        _CancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_CancelBtn setTitle:@"取消" forState:0];
        _CancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_CancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_CancelBtn addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
    }
    return _CancelBtn;
}

-(UIView *)topView
{
    if (!_topView) {
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _topView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    }
    return _topView;
}
#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = SCREENH_HEIGHT;
        self.alertView.frame = rect;
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= self.ViewHeight + 90;
            self.alertView.frame = rect;
        }];
    }
}


#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += self.ViewHeight + 90;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    
    } completion:^(BOOL finished) {
        
        [self.collectioinView removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self.topView removeFromSuperview];
        [self removeFromSuperview];

        self.topView = nil;
        self.collectioinView = nil;
        self.alertView = nil;
        self.backgroundView = nil;

    }];
}

-(void)didTapBackgroundView:(UITapGestureRecognizer *)sender
{
    [self dismissWithAnimation:YES];
}
-(void)dismissAlert
{
    [self dismissWithAnimation:YES];
}

-(CGFloat)getCellHeight:(NSArray *)dataArray
{
    CGFloat CellHeight = 0.0;
    
    CGFloat TotalWidth = dataArray.count * (SCREEN_WIDTH-60)/5 + (dataArray.count + 1) * 10;
    
    int spaceNum = TotalWidth/SCREEN_WIDTH;
    
    CellHeight = ((SCREEN_WIDTH-60)/5 + 25) * (spaceNum + 1) + (spaceNum+2) * 10;
    
    return CellHeight;
}


@end

@implementation ShareCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
        
    }
    return self;
}

-(void)creatUI
{
    UIImageView *shareImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:shareImageView];
    [shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.height.offset(50);
    }];
    self.shareImageView = shareImageView;
    
    UILabel *titLabel = [[UILabel alloc] init];
    titLabel.textColor = [UIColor blackColor];
    titLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:titLabel];
    [titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareImageView.mas_bottom).offset(5);
        make.centerX.offset(0);
    }];
    self.titleLabel = titLabel;
    
}




@end

