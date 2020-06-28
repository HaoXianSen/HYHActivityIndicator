# HYHActivityIndicator

**手写一个类似UIActivityIndicatorView的菊花动画控件，这里只是对于实现的思考并未对其性能检测。通过看系统UIActivityIndicatorView的层级关系发现它是一个imageView，所以猜测系统的实现应该是用12张gif分图动画实现（猜测性能方面会比这种不断的重绘渲染要好许多）。**

前提知识
-----------------------------
1. cosin（余弦函数）、sin（正弦函数）
    直角三角形
    cosin（α）= 邻边 / 斜边；
    sin（α） = 对边/ 斜边；
2. iOS 坐标系
   
   <img src="../screenshots/image-20200628194534621.png" alt="image-20200628194534621" style="zoom:30%;" />
    

3. 绘制知识

   iOS 重写view 的-(void)drawRect:(CGRect)rect，通过UIBezierPath 连接两点，形成线段，完成菊花的绘制。

主要思路和中心代码解释
---------------------------------

1. 通过重写drawRect：方法绘制菊花，更具偏移量_start， 取出存储的alpha值，绘制每条线

   ```objective-c
   - (void)drawRect:(CGRect)rect {
       
       CGFloat originX = self.bounds.size.width * 0.5;
       CGFloat originY = self.bounds.size.height * 0.5;
       
       CGFloat maxAngle = M_PI * 2;
       CGFloat angle = maxAngle / kMax;
     	// 分别绘制12条线
       for (int i = 0; i < kMax; i++) {
         	// -angle 是为了逆时针渲染，顺时针旋转
           CGFloat cosin = cos(-angle * i);
           CGFloat sin = sinf(-angle * i);
           
         	// 内圈的x = 斜边（innerRadius）* cosin + 大圆半径
         	// 内圈的y = 斜边 (innerRadius) * sin + 大圆半径
           // 外圈圈的x = 斜边（outRadius）* cosin + 大圆半径
         	// 内圈的y = 斜边 (outRadius) * sin + 大圆半径
           CGFloat minX = originX + kInnerRadius * cosin;
           CGFloat minY = originY + kInnerRadius * sin;
           CGFloat maxX = originX + kOutRadius * cosin;
           CGFloat maxY = originY + kOutRadius * sin;
           
           UIBezierPath *path = [UIBezierPath bezierPath];
           [path moveToPoint:CGPointMake(minX, minY)];
           [path addLineToPoint:CGPointMake(maxX, maxY)];
           path.lineWidth = 3;
           path.lineCapStyle = kCGLineCapRound;
           
         	// 保证index 在区间【0 ~ kmax-1】
           NSInteger index = (i + _start) % kMax;
           UIColor *color = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:[_capacity[index] floatValue]];
           [color setStroke];
           
           [path stroke];
       }
       
       // 0..11
       _start = ++_start % kMax;
   }
   ```

   

2. 通过NSTimer 间隔0.04s调用[view setNeedDisplay],调用此方法会使系统调用drawRect重回界面

```objective-c
- (void)startAnimation {
    
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(draw) userInfo:nil repeats:YES];
}

- (void)draw {
    [self setNeedsDisplay];
}

```









