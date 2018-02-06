//
//  RMScrollView.h
//  wzdai
//
//  Created by Raymon on 2018/1/26.
//  Copyright © 2018年 wzdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMScrollView : UIScrollView

- (void)createScorllWithMinValue:(int)min
                        maxValue:(int)max
                   intervalValue:(int)intervalValue;


@end
