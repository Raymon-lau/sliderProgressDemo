//
//  ViewController.m
//  sliderProgressDemo
//
//  Created by Raymon on 2018/1/29.
//  Copyright © 2018年 Raymon. All rights reserved.
//

#import "ViewController.h"
#import "RMScrollView.h"

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UILabel *flagLabel;
@property (nonatomic, strong)UIView  *dashLineView;
@property (nonatomic, assign)CGFloat indexFlagValue;
@property (nonatomic, assign)int maxValue;
@property (nonatomic, assign)CGFloat intervalValue;
@property (nonatomic, strong)RMScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _indexFlagValue = 10000;
    _maxValue = 50000;
    _intervalValue = 500;
    
    // 文字
    self.flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_W, 40)];
    self.flagLabel.textAlignment = NSTextAlignmentCenter;
    self.flagLabel.textColor = [UIColor redColor];
    self.flagLabel.font = [UIFont systemFontOfSize:30];
    self.flagLabel.text = [NSString stringWithFormat:@"%f",_indexFlagValue];
    [self.view addSubview:self.flagLabel];
    
    // 文字下划线
    CGFloat textWidth = [self getWidthforString:[NSString stringWithFormat:@"%f",_indexFlagValue] labelHeight:40 stringFont:[UIFont systemFontOfSize:30]];
    self.dashLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.flagLabel.frame), textWidth, 1)];
    [self.view addSubview:self.dashLineView];
    
    [self drawLineOfDashByCAShapeLayer:self.dashLineView lineLength:3 lineSpacing:1 lineColor:[UIColor lightGrayColor] lineDirection:YES];
    
    // 刻度尺
    self.scrollView = [[RMScrollView alloc] initWithFrame:CGRectMake(0, 141, SCREEN_W, 100)];
    self.scrollView.delegate = self;
    [self.scrollView createScorllWithMinValue:0 maxValue:_maxValue intervalValue:_intervalValue];
    [self.view addSubview:self.scrollView];
    
    // 居中判别线段
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W/2, 150, 1, 40)];
    lineLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:lineLabel];
    
    // 刻度尺底部线条
    UILabel *lineBottom = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, SCREEN_W, 1)];
    lineBottom.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineBottom];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSString *str = [NSString stringWithFormat:@"%.2f",scrollView.contentOffset.x];
    CGFloat number = [str floatValue];
    int currentValue = (number - _indexFlagValue/_intervalValue * 10)/2;
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    moneyFormatter.positiveFormat = @"###,##0";
    NSString *formatString = [moneyFormatter stringFromNumber:[NSNumber numberWithInteger:(currentValue * 100) + _indexFlagValue]];
    self.flagLabel.text = formatString;
    CGFloat textWidth = [self getWidthforString:formatString labelHeight:40 stringFont:[UIFont systemFontOfSize:30]];
    self.dashLineView.frame = CGRectMake(SCREEN_W/2 - textWidth/2, 40, textWidth, 1);
    [self.dashLineView.layer.sublayers.lastObject removeFromSuperlayer];
    [self drawLineOfDashByCAShapeLayer:self.dashLineView lineLength:3 lineSpacing:1 lineColor:[UIColor lightGrayColor] lineDirection:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 获取当前字符串所占宽度*/
- (CGFloat)getWidthforString:(NSString *)string
                 labelHeight:(CGFloat)height
                  stringFont:(UIFont *)font{
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.width;
}

- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
