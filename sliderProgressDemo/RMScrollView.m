//
//  RMScrollView.m
//  wzdai
//
//  Created by Raymon on 2018/1/26.
//  Copyright © 2018年 wzdai. All rights reserved.
//

#import "RMScrollView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@implementation RMScrollView
{
    CGFloat _kScrollWidth;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _kScrollWidth = SCREEN_WIDTH;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)createScorllWithMinValue:(int)min
                        maxValue:(int)max
                   intervalValue:(int)intervalValue{
    //max为最大值， intervalValue为间隔，lineSpace为间隔之间的宽度，10为间隔数
    for (int i = min, j = 0; i <= max; i+=intervalValue, j++) {
        CGFloat lineSpace = 10;
        _kScrollWidth += lineSpace;
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + lineSpace * j, 40, 1, 10)];
        lable.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lable];
        
        if (i % (intervalValue * 10) == 0 || i == min) {
            lable.frame = CGRectMake(SCREEN_WIDTH/2 +lineSpace * j, 30, 1, 20);
            UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(lable.frame.origin.x - 20, lable.frame.origin.y - 20, 50, 20)];
            numberLable.font = [UIFont systemFontOfSize:12];
            numberLable.textAlignment = NSTextAlignmentCenter;
            numberLable.textColor = [UIColor grayColor];
            numberLable.text = [NSString stringWithFormat:@"%d",i];
            [self addSubview:numberLable];
        }
    }
    self.contentSize = CGSizeMake(_kScrollWidth, 50);
    NSLog(@"%f",self.contentOffset.x);
    self.contentOffset = CGPointMake(200, 0);
}

@end
