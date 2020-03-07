//
//  ShowCateView.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/6.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "ShowCateView.h"
#import "UICollectionViewLeftAlignedLayout.h"
@interface ShowCateView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UIControl * coverView;

@property (nonatomic,copy) selectBlock resultBlock;

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

/** 数组 */
@property (nonatomic,strong) NSMutableArray *dataSource;

/** frame */
@property (nonatomic,assign) CGRect rect;

/** 选中状态 */
@property (nonatomic,copy) NSString *selectedId;


@end

@implementation ShowCateView
static NSString *const identifer = @"identifer";

+(void)showCateRect:(CGRect)rect dataSource:(NSMutableArray *)dataSource selectedId:(NSString *)selectedId selectedBlock:(selectBlock)resultBlock
{
    ShowCateView *cateView = [[ShowCateView alloc] init];

    cateView.dataSource = dataSource;
    
    cateView.rect = rect;
    
    cateView.selectedId = selectedId;
    
    cateView.resultBlock = resultBlock;
    
    [cateView showWithAnimation:YES];
}

-(instancetype)init
{
    if (self = [super init]) {
        
        self.frame = [[UIScreen mainScreen] bounds];
        
        [self addSubview:self.coverView];
    }
    return self;
}

- (UIControl *)coverView
{
    if (!_coverView) {
        _coverView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        [_coverView addTarget:self action:@selector(removeMain) forControlEvents:UIControlEventTouchUpInside];

        [_coverView addSubview:self.collectionView];
    }
    return _coverView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
    
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[cateCollectionViewCell class] forCellWithReuseIdentifier:identifer];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    cateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    cell.label.text = self.dataSource[indexPath.item][@"topic"];
    
    if ([self.selectedId integerValue] == [self.dataSource[indexPath.item][@"Id"] integerValue]) {
        
        
        cell.label.textColor = [UIColor colorWithHexString:@"#E47464"];
        
    }else
    {
        cell.label.textColor = [UIColor colorWithHexString:@"#959595"];
    }
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *attributeDic = self.dataSource[indexPath.row];
    
    NSString *topic = attributeDic[@"topic"];
    
    CGFloat width = (topic.length + 2) * 15;
    
    return CGSizeMake(width, 35);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.resultBlock) {
        
        self.resultBlock(self.dataSource[indexPath.row]);
    }
    
    [self removeMain];
}

#pragma mark-移除内部容器
-(void)removeMain
{
    [UIView animateWithDuration:0.3 animations:^{
        self.coverView.backgroundColor             = [UIColor colorWithWhite:0 alpha:0.0];
        CGRect rect = self.collectionView.frame;
        rect.size.height = 0;
        self.collectionView.frame = rect;
    } completion:^(BOOL finished) {
        [self.collectionView removeFromSuperview];
        [self.coverView removeFromSuperview];
        [self removeFromSuperview];
        self.collectionView = nil;
        self.coverView = nil;
    }];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.collectionView.frame;
        rect.size.height = 0;
        self.collectionView.frame = rect;
        self.coverView.frame  = CGRectMake(0, self.rect.origin.y+self.rect.size.height, SCREEN_WIDTH, SCREENH_HEIGHT);
        [UIView animateWithDuration:0.3 animations:^{
            self.coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            CGRect rect = self.collectionView.frame;
            rect.size.height = 120;
            self.collectionView.frame = rect;
        } completion:^(BOOL finished) {
            [self.collectionView reloadData];
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeMain];
}

@end

@implementation cateCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    
    UILabel *label = [UILabel labelWithFontSize:15 textColor:[UIColor colorWithHexString:@"#959595"]];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.label = label;
}




@end
