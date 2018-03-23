//
//  ZRCircleProgressView.h
//  ZRProgress
//
//  Created by Robin on 2018/3/22.
//  Copyright © 2018年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZRCompletionBlock)(void);

@interface ZRCircleProgressView : UIView

@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) CGFloat progressWidth;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy) ZRCompletionBlock completionBlock;

@end
