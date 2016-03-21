//
//  Addtion+LinaChart.m
//  miaozhuan
//
//  Created by abyss on 14/11/10.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "Addtion+LinaChart.h"

@implementation LCLineChartData (LineChart_CR)

- (instancetype)initWithColor:(UIColor *)color
{
    self = [super init];
    if (self)
    {
        self.drawsDataPoints = YES;
        self.xMin = 0;
        self.xMax = 6;
        self.color = color;
        self.itemCount = 7;
    }
    return self;
}

- (void)addDataArray:(NSArray *)array forKey:(NSString *)key
{
    self.getData = ^(NSUInteger item)
    {
        NSNumber *i = [array[item] objectForKey:key];
        return [LineChartDataItem dataItemWithX:item y:i.intValue xLabel:nil dataLabel:[NSString stringWithFormat:@"%d",i.intValue]];
    };
}

@end

@implementation LCLineChartView (LineChart_CR)

- (void)setYaxesFrom:(CGFloat)beginNum to:(CGFloat)endNum
{
    int unit_b = 0;
    int unit_e = 0;
    int unit_s = 0;
    
    double begin;
    double end;
    double step;
    
    while (beginNum > 10)
    {
        beginNum /= 10;
        unit_b++;
    }
    while (endNum > 10)
    {
        endNum /= 10;
        unit_e++;
    }
    
    {
        begin   = floor(beginNum)   *pow(10, unit_b);
        end     = ceil(endNum)      *pow(10, unit_e);
        step    = (end - begin)/5;
        
        while (step > 10)
        {
            step /= 10;
            unit_s++;
        }
        
        step = ceil(step)           *pow(10, unit_s);
    }
    
    self.yMin = begin;
    self.yMax = step*5;
    self.ySteps = [NSArray getStepViewFrom:begin to:step];
}

@end


@implementation NSArray (LineChart_CR)

+ (NSArray *)getStepViewFrom:(double)beginNum to:(double)endNum
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 6; i++)
    {
        double num;
        if (i == 0) num = beginNum;
        else        num = endNum*i;
        [array addObject:@(num).stringValue];
    }
    return array;
}

@end