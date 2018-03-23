//
//  ZPUploadProgressView.m
//  11111
//
//  Created by Robin on 2018/3/21.
//  Copyright © 2018年 Robin. All rights reserved.
//

#import "ZRUploadProgressView.h"

@interface ZRUploadProgressView ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *imageLayer;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIBezierPath *progressPath;

@end

@implementation ZRUploadProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self drawArcProgressView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self drawArcProgressView];
    }
    return self;
}

- (void)drawArcProgressView {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = width/2.0;
    
    self.imageLayer = [CAShapeLayer layer];
    self.imageLayer.frame = self.bounds;
    [self.layer addSublayer:self.imageLayer];
    
    CGPoint center = CGPointMake(width/2, height/2);
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:center radius:(width)/ 2 startAngle:- M_PI_2 endAngle: -M_PI*5/2 clockwise:NO];
    self.trackLayer = [CAShapeLayer layer];
    self.trackLayer.frame = CGRectMake(0, 0, width, height);
    self.trackLayer.fillColor = [UIColor clearColor].CGColor;
    self.trackLayer.strokeColor = [UIColor orangeColor].CGColor;
    self.trackLayer.lineWidth = width;
    self.trackLayer.path = progressPath.CGPath;
    self.trackLayer.strokeEnd = 1;
    [self.layer addSublayer:self.trackLayer];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.center = center;
    self.titleLabel.hidden = YES;
    self.titleLabel.textColor = [UIColor yellowColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
}

- (void)setProgressColor:(UIColor *)progressColor {
    self.trackLayer.strokeColor = progressColor.CGColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor =  titleColor;
}

- (void)setImageName:(NSString *)imageName {
    [self.imageLayer setContents:(id)[UIImage imageNamed:imageName].CGImage];
}

- (void)setProgress:(CGFloat)progress {
    _progress = MIN(1, MAX(0, progress));
    self.trackLayer.strokeEnd = _progress;
    NSString *progressStr = [NSString stringWithFormat:@"%.1f%%",100.0-_progress * 100];
    self.titleLabel.text = progressStr;
    if (_progress <= 0) {
        if (self.completionBlock) {
            self.completionBlock();
            self.completionBlock = nil;
        }
    } else {
        self.titleLabel.hidden = NO;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
