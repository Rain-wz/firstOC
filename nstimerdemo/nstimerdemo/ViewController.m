//
//  ViewController.m
//  nstimerdemo
//
//  Created by Rain on 2017/4/12.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import "ViewController.h"
#import "RtouchidValidation.h"
@interface ViewController ()
{
    UIButton *btn;
    UIActivityIndicatorView *activity;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self Initialize];
    
    //    [self timer];
    
//    [self activityIndicatorView];
//    [self touchIdTest];
}
-(void)Initialize
{
    if (!btn) {
        btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [btn setFrame:CGRectMake(self.view.frame.size.width/2, 100, 100, 100)];
        [btn addTarget:self action:@selector(touchIdTest) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
-(void)timer{
    
    //    NSObject *object = [[NSObject alloc] init];
    //添加到默认主线程 自动开启
    //一次
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction:) userInfo:nil repeats:NO];
    //周期性
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    //
    /*
     runloop是事件接收和分发机制的一个实现。
     Run loops是线程的基础架构部分。一个run loop就是一个事件处理循环，用来不停的调配工作以及处理输入事件。使用run loop的目的是使你的线程在有工作的时候工作，没有的时候休眠。
     */
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1] interval:5 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [loop addTimer:timer forMode:NSDefaultRunLoopMode];
    [loop run];
    
    /*
     在iOS多线程中，每一个线程都有一个Runloop，但是只有主线程的Runloop默认是打开的，其他子线程也就是我们创建的线程的Runloop默认是关闭的，需要我们手动运行。我们可以通过[NSRunLoop currentRunLoop]来获得当前线程的Runloop，并且调用[runloop addTimer:timer forMode:NSDefaultRunLoopMode]方法将定时器添加到Runloop中，最后一定不要忘记调用Runloop的run方法将当前Runloop开启，否则NSTimer永远也不会运行。
     */
}
-(void)timerAction:(id)str{
    
    NSLog(@"%@",str);
}

-(void)activityIndicatorView{
   activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 200, 30, 30)];//指定进度轮的大小
    
    [activity setCenter:CGPointMake(160, 140)];//指定进度轮中心点
    
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];//设置进度轮显示类型
    
    [self.view addSubview:activity];
}
//button点击所触发的方法。 启动或关闭进度轮。

- (void)startOrStop:(id)sender{
    
    if([activity isAnimating]){
        
        [activity stopAnimating];
        
    }
   
    else
    {
        [activity startAnimating];
    }
    
}



-(void)touchIdTest{
    [RtouchidValidation touchIdValidationresult];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
