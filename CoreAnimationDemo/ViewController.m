//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by 曾国锐 on 2017/3/14.
//  Copyright © 2017年 曾国锐. All rights reserved.
//

#define WIDTH          ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT         ([UIScreen mainScreen].bounds.size.height)

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self animationPushTransition];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UIKit动画

/*
 a.常规动画属性设置（可以同时选择多个进行设置）
 
 UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
 
 UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
 
 UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
 
 UIViewAnimationOptionRepeat：重复运行动画。
 
 UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
 
 UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
 
 UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
 
 UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
 
 UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
 
 UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
 
 
 
 b.动画速度控制（可从其中选择一个设置）
 
 UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
 
 UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
 
 UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
 
 UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
 
 
 
 c.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
 
 UIViewAnimationOptionTransitionNone：没有转场动画效果。
 
 UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
 
 UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
 
 UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。
 
 UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。
 
 UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
 
 UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。
 
 UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。
 */

//坐标移大小变化
- (void)animationOfUIKit{
    
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    //开始动画
    [UIView beginAnimations:@"test1" context:nil];
    //动画时长
    [UIView setAnimationDuration:1];
    /*
     *要进行动画设置的地方
     */
    
    redView.backgroundColor=[UIColor blueColor];
    redView.frame=CGRectMake(WIDTH/2-100, HEIGHT/2-100, 200, 200);
    redView.alpha=0.5;
    
    //动画结束
    [UIView commitAnimations];
}
//坐标移大小变化
-(void)animationOfBlock
{
    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    [UIView animateWithDuration:1 //时长
                          delay:0 //延迟时间
                        options:UIViewAnimationOptionTransitionFlipFromLeft//动画效果
                     animations:^{
                         //动画设置区域
                         redView.backgroundColor=[UIColor blueColor];
                         redView.frame=CGRectMake(WIDTH/2-100, HEIGHT/2-100, 200, 200);
                         redView.alpha=0.5;
                         
                     } completion:^(BOOL finish){
                         //动画结束时调用
                         NSLog(@"我结束了");
                     }];
}

#pragma mark - CABasicAnimation(基本动画)

/*
 属性说明:
 
 keyPath ：要改变的属性名称（传字符串）
 
 fromValue：keyPath相应属性的初始值
 
 toValue：keyPath相应属性的结束值
 
 
 
 动画过程说明：
 
 随着动画的进行，在长度为duration的持续时间内，keyPath相应属性的值从fromValue渐渐地变为toValue
 
 keyPath内容是CALayer的动画Animatable属性
 
 animationWithKeyPath的值：
 
 - #define angle2Radian(angle) ((angle)/180.0*M_PI)
 
 transform.rotation.x 围绕x轴翻转 参数：角度 angle2Radian(4)
 
 transform.rotation.y 围绕y轴翻转 参数：同上
 
 transform.rotation.z 围绕z轴翻转 参数：同上
 
 transform.rotation 默认围绕z轴
 
 transform.scale.x x方向缩放 参数：缩放比例 1.5
 
 transform.scale.y y方向缩放 参数：同上
 
 transform.scale.z z方向缩放 参数：同上
 
 transform.scale 所有方向缩放 参数：同上
 
 transform.translation.x x方向移动 参数：x轴上的坐标 100
 
 transform.translation.y x方向移动 参数：y轴上的坐标
 
 transform.translation.z x方向移动 参数：z轴上的坐标
 
 transform.translation 移动 参数：移动到的点 （100，100）
 
 opacity 透明度 参数：透明度 0.5
 
 backgroundColor 背景颜色 参数：颜色 (id)[[UIColor redColor] CGColor]
 
 cornerRadius 圆角 参数：圆角半径 5
 
 borderWidth 边框宽度 参数：边框宽度 5
 
 bounds 大小 参数：CGRect
 
 contents 内容 参数：CGImage
 
 contentsRect 可视内容 参数：CGRect 值是0～1之间的小数
 
 hidden 是否隐藏
 
 position
 
 shadowColor
 
 shadowOffset
 
 shadowOpacity
 
 shadowRadius
 */

//缩放变化
-(void)animationMyView
{
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pulse.duration = 0.5 + (rand() % 10) * 0.05;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:.8];
    pulse.toValue = [NSNumber numberWithFloat:1.2];
    [redView.layer addAnimation:pulse forKey:nil];
}

//大小变化
-(void)animatioBoundView
{
    
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds"];
    anim.duration = 1.f;
    anim.fromValue=[NSValue valueWithCGRect:CGRectMake(WIDTH/2-25, HEIGHT/2-25,50,50)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(10,10,200,200)];
    anim.byValue  = [NSValue valueWithCGRect:redView.bounds];
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.repeatCount = 1;
    anim.autoreverses = YES;
    
    [redView.layer addAnimation:anim forKey:nil];
}

//背景色变化
-(void)animationBgColorView
{
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anim.duration = 3.f;
    anim.toValue = (id)[UIColor greenColor].CGColor;
    anim.fromValue =  (id)[UIColor redColor].CGColor;
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.repeatCount = CGFLOAT_MAX;
    
    [redView.layer addAnimation:anim forKey:nil];
}

//y轴移动
-(void)animationYView
{
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue=@150;
    animation.duration=2;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [redView.layer addAnimation:animation forKey:nil];
}

#pragma mark - CAKeyframeAnimation(关键帧动画)
/*
 CABasicAnimation只能从一个数值（fromValue）变到另一个数值（toValue），而CAKeyframeAnimation会使用一个NSArray保存这些数值
 
 
 
 属性说明：
 
 values：上述的NSArray对象。里面的元素称为“关键帧”(keyframe)。动画对象会在指定的时间（duration）内，依次显示values数组中的每一个关键帧
 
 path：可以设置一个CGPathRef、CGMutablePathRef，让图层按照路径轨迹移动。path只对CALayer的anchorPoint和position起作用。如果设置了path，那么values将被忽略
 
 keyTimes：可以为对应的关键帧指定对应的时间点，其取值范围为0到1.0，keyTimes中的每一个时间值都对应values中的每一帧。如果没有设置keyTimes，各个关键帧的时间是平分的，CABasicAnimation可看做是只有2个关键帧的CAKeyframeAnimation
 */

//values方式
-(void)animationValues
{
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    animation.values=@[value1,value2,value3,value4,value5];
    animation.repeatCount=MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 4.0f;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate=self;
    [redView.layer addAnimation:animation forKey:nil];
}

//path方式
-(void)animationPath
{
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    animation.path=path;
    CGPathRelease(path);
    animation.repeatCount=MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 4.0f;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate=self;
    [redView.layer addAnimation:animation forKey:nil];
}

#pragma mark - CAAnimationGroup(动画组)
/*
 动画组，是CAAnimation的子类，可以保存一组动画对象，将CAAnimationGroup对象加入层后，组中所有动画对象可以同时并发运行
 
 属性说明：
 
 animations：用来保存一组动画对象的NSArray
 
 默认情况下，一组动画对象是同时运行的，也可以通过设置动画对象的beginTime属性来更改动画的开始时间
 */
-(void)animationGroup
{
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    //贝塞尔曲线路径
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(10.0, 10.0)];
    [movePath addQuadCurveToPoint:CGPointMake(100, 300) controlPoint:CGPointMake(300, 100)];
    
    //关键帧动画（位置）
    CAKeyframeAnimation * posAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    posAnim.path = movePath.CGPath;
    posAnim.removedOnCompletion = YES;
    
    //缩放动画
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明动画
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:posAnim, scaleAnim, opacityAnim, nil];
    animGroup.duration = 5;
    
    [redView.layer addAnimation:animGroup forKey:nil];
}

#pragma mark - CATransition(转场动画)
/*
 动画属性:
 
 type：动画过渡类型
 
 subtype：动画过渡方向
 
 startProgress：动画起点(在整体动画的百分比)
 
 endProgress：动画终点(在整体动画的百分比)

 subtype：动画过渡方向(默认为nil,如果指定了filter，那么该属性无效,kCATransitionFromRight,kCATransitionFromLeft,kCATransitionFromTop,kCATransitionFromBottom;分别表示：过渡从右边、左边、顶部、底部 开始)

 转场动画的类型（NSString *type),还有很多私有API类型
 
 fade : 交叉淡化过渡
 
 push : 新视图把旧视图推出去
 
 moveIn: 新视图移到旧视图上面
 
 reveal: 将旧视图移开,显示下面的新视图
 
 cube : 立方体翻滚效果
 
 oglFlip : 上下左右翻转效果
 
 suckEffect : 收缩效果，如一块布被抽走
 
 rippleEffect: 水滴效果
 
 pageCurl : 向上翻页效果
 
 pageUnCurl : 向下翻页效果
 
 cameraIrisHollowOpen : 相机镜头打开效果
 
 cameraIrisHollowClos : 相机镜头关闭效果
 */

//从下往上运动
-(void)animationTransition
{
    //y点就是当要运动后到的Y值
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
    //添加动画
    [redView.layer addAnimation:animation forKey:nil];
}


//从上往下运动
-(void)animationPushTransition
{
    //y点就是当要运动后到的Y值
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, HEIGHT/2-50, 100, 100)];
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.4f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    
    //添加动画
    [redView.layer addAnimation:animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
