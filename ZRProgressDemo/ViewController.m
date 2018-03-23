//
//  ViewController.m
//  ZRProgressDemo
//
//  Created by Robin on 2018/3/22.
//  Copyright © 2018年 Robin. All rights reserved.
//

#import "ViewController.h"
#import "ZRUploadProgressView.h"
#import "ZRCircleProgressView.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) ZRUploadProgressView *uploadView;
@property (nonatomic, strong) ZRCircleProgressView *circleView;
@property (nonatomic, strong) ZRCircleProgressView *circleView1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress = 1.0;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = (screenWidth-80)/3;
    CGFloat orgY = [UIScreen mainScreen].bounds.size.height/2 - width/2;
    
    self.uploadView = [[ZRUploadProgressView alloc] initWithFrame:CGRectMake(20, orgY, width, width)];
    self.uploadView.progressColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.uploadView.imageName = @"1.jpeg";
    self.uploadView.backgroundColor = [UIColor clearColor];
    self.uploadView.completionBlock = ^{
        NSLog(@"uploadView - completion");
    };
    [self.view addSubview:self.uploadView];
    
    self.circleView = [[ZRCircleProgressView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.uploadView.frame) + 20, orgY, width, width)];
    self.circleView.backgroundColor = [UIColor cyanColor];
    self.circleView.progressWidth = width/2;
    self.circleView.completionBlock = ^{
        NSLog(@"circleView - completion");
    };
    [self.view addSubview:self.circleView];
    
    self.circleView1 = [[ZRCircleProgressView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.circleView.frame) + 20, orgY, width, width)];
    self.circleView1.backgroundColor = [UIColor blueColor];
    self.circleView1.progressWidth = 10;
    self.circleView1.completionBlock = ^{
        NSLog(@"circleView1 - completion");
    };
    [self.view addSubview:self.circleView1];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)makeTimer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)startTimer {
    
    CGFloat progressRandom =  (arc4random()%100)/10000.0;
    self.progress -= progressRandom;
    if (self.progress < 0) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.uploadView.progress = self.progress;
    self.circleView.progress = 1-self.progress;
    self.circleView1.progress = 1-self.progress;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 模拟下载动作
    [self makeTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
