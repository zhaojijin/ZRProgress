//
//  ZPUploadProgressView.h
//  ZRProgress
//
//  Created by Robin on 2018/3/21.
//  Copyright © 2018年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZRCompletionBlock)(void);

@interface ZRUploadProgressView : UIView

@property (nonatomic, strong) UIColor *progressColor;
// 0~1 小数
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, copy) ZRCompletionBlock completionBlock;

@end
