//
//  MyCoursesViewController.m
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/19.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import "MyCoursesViewController.h"
#import "CourseChildViewController.h"
@interface MyCoursesViewController ()<UIScrollViewDelegate>

/**选中按钮 */
@property (nonatomic,weak)UIButton *selectedBtn;
/**横线 */
@property (nonatomic,weak)UIView *line;
/**底部容器*/
@property (nonatomic,weak)UIScrollView *scrollerView;
/**顶部视图 */
@property (nonatomic,weak)UIView *topView;

@end

@implementation MyCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"我的课程";
    
    [self setUpChildVc];
    
    [self creatTopView];
    
    [self setupcontentview];
}

#pragma mark-初始化子控制器
-(void)setUpChildVc
{
    CourseChildViewController *allVc = [[CourseChildViewController alloc] init];
    allVc.title = @"已购买";
    [self addChildViewController:allVc];
    
    CourseChildViewController *finishVc = [[CourseChildViewController alloc] init];
    finishVc.title = @"待付款";
    [self addChildViewController:finishVc];
    
}

#pragma mark-创建顶部栏
-(void)creatTopView
{
    UIView *topView = [[UIView alloc] init];
    topView.top = TopHeight;
    topView.height = 50;
    topView.width = self.view.width;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    self.topView = topView;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"#fd5b48"];
    line.height = 2;
    line.top = topView.height - line.height;
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
        [button setTitleColor:[UIColor colorWithHexString:@"#fd5b48"] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleclick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:button];
        if (i == 0) {
            
            button.enabled = NO;
            self.selectedBtn  = button;
            [button.titleLabel sizeToFit];
            line.width=button.titleLabel.width;
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
        
        self.line.width = sender.titleLabel.width;
        self.line.centerX = sender.centerX;
    }];
    //滚动
    CGPoint offset=self.scrollerView.contentOffset;
    offset.x=sender.tag*self.scrollerView.width;
    [self.scrollerView setContentOffset:offset animated:YES];
    
}

-(void)setupcontentview
{
    //不要自动调整inset
    UIScrollView *Myscoller=[[UIScrollView alloc]init];
    Myscoller.frame = CGRectMake(0,self.topView.height+self.topView.top, SCREEN_WIDTH, SCREENH_HEIGHT-self.topView.height-self.topView.top);
    Myscoller.pagingEnabled=YES;
    Myscoller.delegate = self;
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
    
    vc.view.left=scrollView.contentOffset.x;
    vc.view.height=scrollView.height;
    vc.view.top=0;//设置控制器view的y（默认20）
    [scrollView addSubview:vc.view];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    [self titleclick:self.topView.subviews[index]];
}


@end
