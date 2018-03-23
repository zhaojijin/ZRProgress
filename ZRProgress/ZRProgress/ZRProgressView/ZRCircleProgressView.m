//
//  ZRCircleProgressView.m
//  ZRProgress
//
//  Created by Robin on 2018/3/22.
//  Copyright © 2018年 Robin. All rights reserved.
//

#import "ZRCircleProgressView.h"

@interface ZRCircleProgressView()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation ZRCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = width/2.0;
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.frame = self.bounds;
    self.circleLayer.strokeEnd = 0;
    self.circleLayer.lineWidth = 3;
    self.circleLayer.strokeColor = [UIColor orangeColor].CGColor;
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    CGPoint center = CGPointMake(width/2, height/2);
    [self.layer addSublayer:self.circleLayer];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.center = center;
    self.titleLabel.hidden = YES;
    self.titleLabel.textColor = [UIColor yellowColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor =  titleColor;
}

- (void)setProgressColor:(UIColor *)progressColor {
    self.circleLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgress:(CGFloat)progress {
    _progress = MIN(1, MAX(0, progress));
    self.circleLayer.strokeEnd = _progress;
    NSString *progressStr = [NSString stringWithFormat:@"%.1f%%",_progress * 100];
    self.titleLabel.text = progressStr;
    if (_progress >= 1) {
        if (self.completionBlock) {
            self.completionBlock();
            self.completionBlock = nil;
        }
    } else {
        self.titleLabel.hidden = NO;
    }
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    if (!_path) {
        CGFloat width = self.frame.size.width;
        CGPoint center = CGPointMake(width/2, width/2);
        _path = [UIBezierPath bezierPathWithArcCenter:center radius:(width/2 - progressWidth/2) startAngle:-M_PI_2 endAngle:3*M_PI/2 clockwise:YES];
        self.circleLayer.path = _path.CGPath;
    }
    self.circleLayer.lineWidth = progressWidth;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
