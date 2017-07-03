//
//  ViewController.m
//  画线
//
//  Created by 李志权 on 16/7/13.
//  Copyright © 2016年 李志权. All rights reserved.
//
/**动画参考链接http://blog.csdn.net/wildfireli/article/details/23086847*/
#import "ViewController.h"
#import "UIBeziePathView.h"
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define  PROGREESS_WIDTH 80 //圆直径
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度
@interface ViewController ()
{
    CAShapeLayer *_shapeLayer;
    CAShapeLayer *_progressLayer;

}
@end
/*使用CAShapeLayer与UIBezierPath可以实现不在view的drawRect方法中就画出一些想要的图形 。
 
 1：UIBezierPath： UIBezierPath是在 UIKit 中的一个类，继承于NSObject,可以创建基于矢量的路径.此类是Core Graphics框架关于path的一个OC封装。使用此类可以定义常见的圆形、多边形等形状 。我们使用直线、弧（arc）来创建复杂的曲线形状。每一个直线段或者曲线段的结束的地方是下一个的开始的地方。每一个连接的直线或者曲线段的集合成为subpath。一个UIBezierPath对象定义一个完整的路径包括一个或者多个subpaths。
 
 2：CAShapeLayer： CAShapeLayer顾名思义，继承于CALayer。 每个CAShapeLayer对象都代表着将要被渲染到屏幕上的一个任意的形状(shape)。具体的形状由其path(类型为CGPathRef)属性指定。 普通的CALayer是矩形，所以需要frame属性。CAShapeLayer初始化时也需要指定frame值，但 它本身没有形状，它的形状来源于其属性path 。CAShapeLayer有不同于CALayer的属性，它从CALayer继承而来的属性在绘制时是不起作用的。*/
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self fiveAnimation];
    // Do any additional setup after loading the view, typically from a nib.
}
//画一个圆形
- (void)circular
{
    
    /*Stroke:用笔画的意思
    
    在这里就是起始笔和结束笔的位置
    
    Stroke为1的话就是一整圈，0.5就是半圈，0.25就是1/4圈。以此类推
    
    如果我们把起点设为0，终点设为0.75
    
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0;
    
    self.shapeLayer.strokeEnd = 0.75;*/
    
    CAShapeLayer *shapeLater =[CAShapeLayer layer];//初始化
    shapeLater.frame = CGRectMake((self.view.frame.size.width-200)/2, 100, 200, 200);
//    shapeLater.position = self.view.center;//中心位置
    shapeLater.fillColor = [UIColor greenColor].CGColor;//圈内填充颜色为ClearColor
    //设置线条的宽度和颜色
    shapeLater.lineWidth = 10.0f;
    shapeLater.strokeColor = [UIColor redColor].CGColor;
    //创建出圆形贝塞尔曲线
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    //让贝塞尔曲线与CAShapeLayer产生联系
    shapeLater.path = bezierPath.CGPath;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    
    ani. fromValue = @0 ;
    
    ani. toValue = @1 ;
    
    ani. duration = 5 ;
    
    [shapeLater addAnimation :ani forKey : NSStringFromSelector ( @selector (strokeEnd))];
    
    //添加并显示
    [self.view.layer addSublayer:shapeLater];
    
}
//画两个圆形，其中一个圆形标示进度
//画两个圆形
-(void)createBezierPath:(CGRect)mybound
{
    //外圆 固定写法
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:(mybound.size.width - 0.7)/ 2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *tarckLayer = [CAShapeLayer layer];//初始化
    //添加并显示
    [self.view.layer addSublayer:tarckLayer];
    //圈内填充颜色为ClearColor(nil为透明)
    tarckLayer.fillColor=nil;
    //让贝塞尔曲线与CAShapeLayer产生联系
    tarckLayer.path=trackPath.CGPath;
    //设置线条的宽度和颜色
    tarckLayer.lineWidth=5;
    tarckLayer.strokeColor = [UIColor grayColor].CGColor;
    
    tarckLayer.frame = mybound;
    
    //内圆
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:(mybound.size.width-0.7)/2 startAngle:-M_PI_2 endAngle:(M_PI*2)*0.7-M_PI_2 clockwise:YES];
    
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    [self.view.layer addSublayer:progressLayer];
    progressLayer.fillColor = nil;
    progressLayer.strokeColor = [UIColor purpleColor].CGColor;
    progressLayer.lineCap = kCALineCapRound;
    progressLayer.path = progressPath.CGPath;
    progressLayer.lineWidth = tarckLayer.lineWidth;
    progressLayer.frame = tarckLayer.frame;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//创建一个转动的圆
- (void)circleBezierPath
{
     //创建出CAShapeLayer
    _shapeLayer = [CAShapeLayer layer];//初始化
    _shapeLayer.frame = CGRectMake(0, 10, 200, 200);
    _shapeLayer.position = self.view.center;
    //设置线条的宽度和颜色
    _shapeLayer.lineWidth = 2;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    //设置画笔的起始点
    _shapeLayer.strokeStart=0;
    _shapeLayer.strokeEnd=0;
    //创建出圆形贝塞尔曲线
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
     //让贝塞尔曲线与CAShapeLayer产生联系
    _shapeLayer.path = bezierPath.CGPath;
    //添加显示
    [self.view.layer addSublayer:_shapeLayer];
}
- (void)circleAnimationTypeOne
{
    if (_shapeLayer.strokeEnd>1 && _shapeLayer.strokeStart<1) {
        _shapeLayer.strokeStart +=0.1;//开始加大线收短
    }else if (_shapeLayer.strokeStart==0){
        _shapeLayer.strokeEnd += 0.1;//结束加大线拉长
    }
    
    if (_shapeLayer.strokeEnd == 0) {
        _shapeLayer.strokeStart = 0;
    }
    
    if (_shapeLayer.strokeStart == _shapeLayer.strokeEnd) {
        _shapeLayer.strokeEnd = 0;
    }
}
- (void)circleAnimationTypeTwo
{
    CGFloat valueOne = arc4random() % 100 / 100.0f;
    CGFloat valueTwo = arc4random() % 100 / 100.0f;
    
    _shapeLayer.strokeStart = valueOne < valueTwo ? valueOne : valueTwo;
    _shapeLayer.strokeEnd = valueTwo > valueOne ? valueTwo : valueOne;
}

//实例4：通过点画线组成一个五边线
-(void)fiveAnimation
{
    UIBezierPath *bezierPath =[UIBezierPath bezierPath];
    //开始点从上左下右的点
    [bezierPath moveToPoint:CGPointMake(100, 100)];
    //划线点,每一个直线段或者曲线段的结束的地方是下一个的开始的地方。
    
    [bezierPath addLineToPoint:CGPointMake(60, 140)];
    [bezierPath addLineToPoint:CGPointMake(60, 240)];
    [bezierPath addLineToPoint:CGPointMake(160, 240)];
    [bezierPath addLineToPoint:CGPointMake(160, 140)];
    [bezierPath closePath];
    
    //设置定点是个5*5的小圆形（自己加的）
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100-5/2, 0, 5, 5)];
    [bezierPath appendPath:path];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 20;
    //设置边框颜色
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    //设置填充颜色如果只要边可以把里面设置成[UIColor ClearColor]或者nil
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
     //就是这句话在关联彼此（UIBezierPath和CAShapeLayer）：
    shapeLayer.path = bezierPath.CGPath;
    [self.view.layer addSublayer:shapeLayer];
}
//画一条曲线
- ( void ) curve
{
    UIBezierPath *curveBezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 100, 0, 0)];
    
//    [curveBezier addLineToPoint:CGPointMake(60, 60)];
//    [curveBezier addLineToPoint:CGPointMake(70, 120)];
//    [curveBezier addLineToPoint:CGPointMake(120, 100)];
//    [curveBezier addLineToPoint:CGPointMake(200, 170)];
//    [curveBezier addLineToPoint:CGPointMake(310, 130)];
    
    CAShapeLayer *ShapeLayer = [CAShapeLayer layer];
    ShapeLayer.fillColor = nil;
    ShapeLayer.strokeColor = [UIColor greenColor].CGColor;
    ShapeLayer.path = curveBezier.CGPath;
    [self.view.layer addSublayer:ShapeLayer];
    //动画画出来
//    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath: NSStringFromSelector (@selector(strokeEnd))];
//    basicAnimation.fromValue = @0;
//    basicAnimation.toValue = @1;
//    basicAnimation.duration = 2;
//    [ShapeLayer addAnimation:basicAnimation forKey:NSStringFromSelector(@selector(strokeEnd))];
//    //动画隐藏
//    CABasicAnimation *basicAnimation1 = [CABasicAnimation animationWithKeyPath: NSStringFromSelector (@selector(strokeStart))];
//    basicAnimation1.fromValue = @0;
//    basicAnimation1.toValue = @1;
//    basicAnimation1.duration = 7;
//    [ShapeLayer addAnimation:basicAnimation1 forKey:NSStringFromSelector(@selector(strokeStart))];
}
//画虚线
-(void)createDottedLine
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = self.view.bounds;
    shapeLayer.position = self.view.center;
    shapeLayer.fillColor = nil;
    //设置虚线颜色
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    //设置虚线的大小
    shapeLayer.lineWidth = 1;
    shapeLayer.lineJoin=kCALineJoinRound;
    
    //3=线的宽度 1=每条线的间距
    shapeLayer.lineDashPattern=@[@3,@1];
    
//    UIBezierPath *bezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 100, 200, 200)];
//    shapeLayer.path = bezier.CGPath;
    
//    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 89);
    CGPathAddLineToPoint(path, NULL, 160,50);
    CGPathMoveToPoint(path, NULL, 160, 50);
    CGPathAddLineToPoint(path, NULL, 320,89);
    shapeLayer.path = path;
    [self.view.layer addSublayer:shapeLayer];
    
}
//画一个弧线
-(void)createCurvedLine
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 5;
    bezierPath.lineCapStyle = kCGLineCapRound;//线条拐角
    bezierPath.lineJoinStyle = kCGLineCapRound;//终点处理
    [bezierPath moveToPoint:CGPointMake(20, 100)];
    [bezierPath addQuadCurveToPoint:CGPointMake(120, 100) controlPoint:CGPointMake(70, 0)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = nil;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
}
- ( void )drawLine{
    
    
    //view 是曲线的背景 view
    
    UIView *view = [[ UIView alloc ] initWithFrame : CGRectMake ( 10 , 0 , 300 , 300 )];
    
    view. backgroundColor = [ UIColor whiteColor ];
    
    [ self . view addSubview :view];
    
    // 第一、 UIBezierPath 绘制线段
    
    UIBezierPath *firstPath = [ UIBezierPath bezierPathWithOvalInRect : CGRectMake ( 0 , 0 , 5 , 5 )];
    
    
    CGPoint p1 = CGPointMake ( 0 , 0 );
    
    CGPoint p2 = CGPointMake ( 300 , 0 );
    
    [firstPath addLineToPoint :p1];
    
    [firstPath addLineToPoint :p2];
    
    UIBezierPath *lastPath = [ UIBezierPath bezierPathWithOvalInRect : CGRectMake ( 300 , 0 , 0 , 0 )];
    
    [firstPath appendPath :lastPath];
    
    
    // 第二、 UIBezierPath 和 CAShapeLayer 关联
    
    CAShapeLayer *lineLayer2 = [ CAShapeLayer layer ];
    
    lineLayer2. frame = CGRectMake ( 0 , 50 , 320 , 40 );
    
    lineLayer2. fillColor = [ UIColor yellowColor ]. CGColor ;
    
    lineLayer2. path = firstPath. CGPath ;
    
    lineLayer2. strokeColor = [ UIColor redColor ]. CGColor ;
    
    //第三，动画
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    
    ani. fromValue = @0 ;
    
    ani. toValue = @1 ;
    
    ani. duration = 5 ;
    
    [lineLayer2 addAnimation :ani forKey : NSStringFromSelector ( @selector (strokeEnd))];
    
    [view. layer addSublayer :lineLayer2];
    
}
//UIBezierPath通过
//- (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
//可以画出一段弧线。
//看下各个参数的意义：
//center：圆心的坐标
//radius：半径
//startAngle：起始的弧度
//endAngle：圆弧结束的弧度
//clockwise：YES为顺时针，No为逆时针
//方法里面主要是理解startAngle与endAngle，刚开始我搞不清楚一段圆弧从哪算起始和终止，比如弧度为0的话，是从上下左右哪个点开始算
//看了下面这张图就明了了
//渐变http://img.blog.csdn.net/20140409111028859?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbmdnY2g=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast
- (void)gradient
{
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    aView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:aView];
    
    _shapeLayer = [CAShapeLayer layer];//创建一个track shape layer
    _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    _shapeLayer.frame = aView.bounds;
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd=0;
    _shapeLayer.strokeColor = [[UIColor redColor] CGColor];//指定path的渲染颜色
//    _shapeLayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
    _shapeLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _shapeLayer.lineWidth = 10;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(aView.frame.size.width/2, aView.frame.size.height) radius:(aView.frame.size.width-10)/2 startAngle:M_PI endAngle:M_PI*2 clockwise:YES];//上面说明过了用来构建圆形
    _shapeLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    [aView.layer addSublayer:_shapeLayer];
    
   
    
    
    //渐变图层
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = _shapeLayer.frame;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor greenColor] CGColor],(id)[[UIColor yellowColor] CGColor],(id)[[UIColor blueColor] CGColor], nil]];
    [gradientLayer setLocations:@[@0,@0.4,@0.6,@1]];
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 0)];
    
    
    //用progressLayer来截取渐变层 遮罩
    [gradientLayer setMask:_shapeLayer];
    [aView.layer addSublayer:gradientLayer];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(aViewPanGesture:)];
    [aView addGestureRecognizer:panGesture];
    
    //增加动画
//    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 2;
//    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue=[NSNumber numberWithFloat:1.0f];
//    pathAnimation.autoreverses=NO;
//    _shapeLayer.path=path.CGPath;
//    [_shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}
- (void)aViewPanGesture:(UIPanGestureRecognizer *)panGesture
{
    NSLog(@"xxoo---xxoo---xxoo");
    CGPoint point = [panGesture locationInView:panGesture.view];
    NSLog(@"%f,%f",point.x,point.y);
    if (point.x<0) {
        point.x = 0;
    }
    if (point.x>panGesture.view.frame.size.width) {
        point.x = panGesture.view.frame.size.width;
    }
    CGFloat x = point.x /panGesture.view.frame.size.width;
    _shapeLayer.strokeEnd=x;
    
  
    
    
//    panGesture.view.center = CGPointMake(panGesture.view.center.x + point.x, panGesture.view.center.y + point.y);
//    [panGesture setTranslation:CGPointMake(0, 0) inView:panGesture.view];
}
@end
