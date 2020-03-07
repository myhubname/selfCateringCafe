//
//  HJCourseDetailViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/9.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "HJCourseDetailViewController.h"
#import "CourseVideoDetailHeader.h"
#import "HJCourseWebDetailViewController.h"
#import "HJCourseCatalogueViewController.h"
#import "CoursePayBottom.h"
#import "HJLoginThirdGuideViewController.h"
#import "HJBaseNavViewController.h"
#import <JPVideoPlayer.h>
#import <JPVideoPlayerKit.h>
#import "HJUpgradeViewController.h"
@interface HJCourseDetailViewController ()<UIScrollViewDelegate,JPVideoPlayerDelegate>

/** 头部图片 */
@property (nonatomic,strong) CourseVideoDetailHeader *headerImageView;

/*顶部视图*/
@property (nonatomic,strong) UIView *topView;

/*选中按钮*/
@property (nonatomic,strong) UIButton *selectedBtn;

/**横线 */
@property (nonatomic,weak)UIView *line;

/**底部容器*/
@property (nonatomic,strong)UIScrollView *scrollerView;

/** 付钱 */
@property (nonatomic,strong) CoursePayBottom *bottomView;

/** HJCourseWebDetailViewController */
@property (nonatomic,weak) HJCourseWebDetailViewController *webDetailVc;

/** 课程列表 */
@property (nonatomic,weak) HJCourseCatalogueViewController *courseListVc;

/** 字典 */
@property (nonatomic,copy) NSDictionary *dic;

/** videoPath */
@property (nonatomic,copy) NSString *videoPath;


@end

@implementation HJCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.customNavBar wr_setLeftButtonWithImage:kGetImage(@"returnIcon")];

    [self.customNavBar wr_setBackgroundAlpha:0];
    
    [self.customNavBar wr_setBottomLineHidden:YES];
    
    [self.customNavBar wr_setRightButtonWithImage:kGetImage(@"moreIcon")];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.headerImageView];
    
    [self.view insertSubview:self.customNavBar aboveSubview:self.headerImageView];

   
    [self setUpChildVc];
    
    [self creatTopView];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.top+self.topView.height, SCREEN_WIDTH, 1.0)];
    topLine.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [self.view addSubview:topLine];

    [self setUpContentview];
 
    [self.view addSubview:self.bottomView];
    
    
    [self getData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideo:) name:@"playVideo" object:nil];
    
}

-(void)playVideo:(NSNotification *)noti
{
    self.videoPath = noti.object;
    
    
    [self playClick];
    
}

#pragma mark-获取数据
-(void)getData
{
    [HUDManager showLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.courseDetail_Id;
    params[@"userid"] = userDefaultGet(userid);
    [[HJNetWorkManager shareManager] AFGetDataUrl:@"Api/Course/Item" params:params sucessBlock:^(HJNetWorkModel * _Nonnull result) {
        if (result.isSucess) {
            
            [HUDManager hidenHud];
            
            self.dic = result.data;
            
            [self.headerImageView.headerImageView setImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ApiImagefix,result.data[@"pic"]]]];
            
            self.bottomView.priceLabel.text = [NSString stringWithFormat:@"¥%@元",result.data[@"price"]];
            
            
            self.videoPath = [NSString stringWithFormat:@"%@%@",ApiVideoFix,[result.data[@"chapter"] firstObject][@"video"]];
            
            self.webDetailVc.webUrl = result.data[@"uri"];
            
            if ([self.dic[@"isbuy"] integerValue] == 0) {
                
                self.bottomView.priceLabel.hidden = NO;
                [self.bottomView.buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.offset(SCREEN_WIDTH/2-30);
                }];
                [self.bottomView.buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
                
            }else
            {
                
                [self.bottomView.buyButton setTitle:@"继续播放" forState:UIControlStateNormal];
                
                [self.bottomView.buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.offset(SCREEN_WIDTH);
                }];
                
                self.bottomView.priceLabel.hidden = YES;
                
            }

        }
    } Faild:^(NSError * _Nonnull error) {
        
    }];
}

-(CourseVideoDetailHeader *)headerImageView
{
    if (!_headerImageView) {
        
        _headerImageView = [[CourseVideoDetailHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        
        _headerImageView.headerImageView.jp_videoPlayerDelegate = self;
        
        
        [_headerImageView.playButton addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerImageView;
}

#pragma mark-初始化子控制器
-(void)setUpChildVc
{
    HJCourseWebDetailViewController *allVc = [[HJCourseWebDetailViewController alloc] init];
    allVc.title = @"详情";
    [self addChildViewController:allVc];
    self.webDetailVc = allVc;
    
    HJCourseCatalogueViewController *courseVc = [[HJCourseCatalogueViewController alloc] init];
    courseVc.title = @"课程目录";
    [self addChildViewController:courseVc];
}
#pragma mark-创建顶部栏
-(void)creatTopView
{
    UIView *topView = [[UIView alloc] init];
    topView.top = self.headerImageView.top+self.headerImageView.height;
    topView.height = 50;
    topView.width = self.view.width;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    self.topView = topView;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#f7594d"];
    line.height = 2;
    line.top = topView.height - line.height;
    line.width = SCREEN_WIDTH/2 - 80;
    self.line = line;
    
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.height = topView.height;
        button.width = SCREEN_WIDTH/self.childViewControllers.count;
        button.left = i * button.width;
        button.tag = i;
        UIViewController *Vctitle = self.childViewControllers[i];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:Vctitle.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#f7594d"] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleclick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:button];
        if (i == 0) {
            
            button.enabled = NO;
            self.selectedBtn  = button;
            line.centerX=button.centerX;
        }
    }
    
    [topView addSubview:line];
    
}

#pragma mark-选中按钮
-(void)titleclick:(UIButton *)sender
{
    self.selectedBtn.enabled = YES;
    sender.enabled = NO;
    self.selectedBtn = sender;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.line.centerX = sender.centerX;
    }];
    //滚动
    CGPoint offset=self.scrollerView.contentOffset;
    offset.x=sender.tag*self.scrollerView.width;
    [self.scrollerView setContentOffset:offset animated:YES];
    
}
#pragma mark-设置底部容器
-(void)setUpContentview
{
    //不要自动调整inset
    UIScrollView *Myscoller=[[UIScrollView alloc]init];
    Myscoller.frame = CGRectMake(0,self.topView.height+self.topView.top+1, SCREEN_WIDTH, SCREENH_HEIGHT-self.topView.height-self.topView.top-60-1);
    Myscoller.pagingEnabled=YES;
    Myscoller.delegate = self;
    Myscoller.showsHorizontalScrollIndicator = NO;
    Myscoller.backgroundColor = [UIColor whiteColor];
    Myscoller.contentSize=CGSizeMake(Myscoller.width*self.childViewControllers.count, 0);
    [self.view insertSubview:Myscoller atIndex:0];
    self.scrollerView = Myscoller;
    //    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:self.scrollerView];
    
}
#pragma mark-<UIScrollerviewdelegate>
// 动画结束
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //当前索引值
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    //取出子控制器
    UIViewController *vc=self.childViewControllers[index];
    
    vc.view.left = scrollView.contentOffset.x;
    vc.view.height=scrollView.height;
    vc.view.top=0;//设置控制器view的y（默认20）
    
    if ([vc isKindOfClass:[HJCourseCatalogueViewController class]]) {
        
      HJCourseCatalogueViewController *listVc = (HJCourseCatalogueViewController *)vc;
    
        listVc.dic = self.dic;
        
    }
    
    [scrollView addSubview:vc.view];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    [self titleclick:self.topView.subviews[index]];
}

-(CoursePayBottom *)bottomView
{
    if (!_bottomView) {
        
        _bottomView = [[CoursePayBottom alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT-60, SCREEN_WIDTH, 60)];
        
        __weak typeof(self)weakself = self;
        _bottomView.buyBlock = ^{
            
            HJLog(@"购买:%@",weakself);

            if (userDefaultGet(userid) == nil) {
                
                HJLoginThirdGuideViewController *thirdLogin = [[HJLoginThirdGuideViewController alloc] init];
                
                HJBaseNavViewController *nav = [[HJBaseNavViewController alloc] initWithRootViewController:thirdLogin];
                
                [weakself presentViewController:nav animated:YES completion:nil];
                
                
            }else
            {
                if ([weakself.bottomView.buyButton.titleLabel.text isEqualToString:@"继续播放"]) {
                    
                    [weakself playClick];
                    
                }else
                {
                    
                    
                    HJUpgradeViewController *upgradeVc = [[HJUpgradeViewController alloc] init];
                    upgradeVc.courseId = weakself.dic[@"Id"];
                    [weakself.navigationController pushViewController:upgradeVc animated:YES];
                    
                }
                
            }
        };
    }
    return _bottomView;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.headerImageView.headerImageView jp_stopPlay];
}

#pragma mark-jpvideoplayer
- (BOOL)shouldShowBlackBackgroundWhenPlaybackStart {
    return YES;
}
- (BOOL)shouldShowBlackBackgroundBeforePlaybackStart {
    return YES;
}
- (BOOL)shouldAutoHideControlContainerViewWhenUserTapping {
    return YES;
}
- (BOOL)shouldShowDefaultControlAndIndicatorViews {
    return NO;
}
-(BOOL)shouldAutoReplayForURL:(NSURL *)videoURL
{
    return NO;
}

-(void)playClick
{
    if (userDefaultGet(userid) == nil) {
       
        
        HJLoginThirdGuideViewController *thirdLogin = [[HJLoginThirdGuideViewController alloc] init];
        
        HJBaseNavViewController *nav = [[HJBaseNavViewController alloc] initWithRootViewController:thirdLogin];
        
        [self presentViewController:nav animated:YES completion:nil];

        
    }else
    {
        if ([self.dic[@"isbuy"] integerValue] == 0) {
            
            [HUDManager showTextHud:@"请购买..."];
            
        }else
        {
            
            if (self.headerImageView.headerImageView.jp_playerStatus == JPVideoPlayerStatusPause) {
                
                [self.headerImageView.headerImageView jp_resume];
                
                
            }else
            {
                [self.headerImageView.headerImageView jp_stopPlay];
                
                [self.headerImageView.headerImageView jp_playVideoWithURL:[NSURL URLWithString:self.videoPath] bufferingIndicator:[JPVideoPlayerBufferingIndicator new] controlView:[[JPVideoPlayerControlView alloc] initWithControlBar:nil blurImage:nil] progressView:nil configuration:nil];
                
            }
        }
        
    }
}


-(void)playerStatusDidChanged:(JPVideoPlayerStatus)playerStatus
{
    if (playerStatus == JPVideoPlayerStatusPlaying || playerStatus == JPVideoPlayerStatusReadyToPlay || playerStatus == JPVideoPlayerStatusBuffering) {
        
        HJLog(@"正在播放");
        
        
        self.headerImageView.playButton.hidden = YES;
        
        
    }else if (playerStatus == JPVideoPlayerStatusPause)
    {
        
        self.headerImageView.playButton.hidden = NO;
        
    }else if (playerStatus == JPVideoPlayerStatusStop)
    {
        
        self.headerImageView.playButton.hidden = NO;

    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
