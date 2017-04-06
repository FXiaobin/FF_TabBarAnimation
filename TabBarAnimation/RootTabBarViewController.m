//
//  RootTabBarViewController.m
//  TabBarAnimation
//
//  Created by fanxiaobin on 2017/4/6.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface RootTabBarViewController ()

@property (nonatomic) NSInteger indexFlag;

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.indexFlag = 0;
    
    [self setupViewControllers];
}


- (void)setupViewControllers {
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_selected_os7"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    [firstNavigationController setTabBarItem:tabBarItem];
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    [secondNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"同城" image:[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_selected_os7"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]];
    
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:thirdViewController];
    [thirdNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_selected_os7"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]];
    
    
    NSArray *viewControllers = @[
                                           firstNavigationController,
                                           secondNavigationController,
                                           thirdNavigationController
                                           ];
    self.viewControllers = viewControllers;
    
    self.tabBar.tintColor = [UIColor orangeColor];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor purpleColor]} forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]} forState:UIControlStateSelected];
    
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (self.indexFlag != index) {
        [self animationWithIndex:index];
    }
    
}
// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    UIView *animationView = tabbarbuttonArray[index];
    
    
    //放大
    //    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    pulse.duration = 0.08;
    //    pulse.repeatCount= 1;
    //    pulse.autoreverses= YES;
    //    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    //    pulse.toValue= [NSNumber numberWithFloat:1.3];
    //    [animationView.layer addAnimation:pulse forKey:nil];
    
    
    
    UIImageView *imageView;
    for (UIView *sub in animationView.subviews) {
        if ([sub isKindOfClass:[UIImageView class]]) {
            
            imageView = (UIImageView *)sub;
        }
    }
    
    //缩放
    [self scaleAnimationWithImageView:imageView];
    
    //抖动
    //[self shakeImageWithImageView:imageView];
    
    self.indexFlag = index;
    
}

- (void)shakeImageWithImageView:(UIImageView *)imageView {
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置属性，周期时长
    [animation setDuration:0.1];
    
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，1次
    animation.repeatCount = 2;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [imageView.layer addAnimation:animation forKey:@"rotation"];
}

//缩放
- (void)scaleAnimationWithImageView:(UIImageView *)imageView{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [imageView.layer addAnimation:animation forKey:@"transform.scale"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
