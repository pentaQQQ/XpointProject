//
//  customLabel.m
//  测试
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 雷晏. All rights reserved.
//

#import "customLabel.h"
typedef enum{
    timeTypeHour = 0,
    timeTypeMinute,
    timeTypeSecond
}timeType;

static NSInteger  hourCount;
static NSInteger  minuteCount;
static NSInteger  secondCount;


@interface customLabel()
{
    NSString *hour_one;
    NSString *hour_two;
    
    NSString *minute_one;
    NSString *minute_two;
    
    NSString *second_one;
    NSString *second_two;
    
    NSTimer *timer;
    
    CGRect _frame;

}
@property (nonatomic,assign) timeType type;

@property (nonatomic,strong) NSMutableArray *array;

@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger hour;
@property (nonatomic,assign) NSInteger minute;

@property (nonatomic,copy) NSString *currentDateString;

@property (nonatomic,strong) NSMutableArray *timeLabelArry;

@end

@implementation customLabel



-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        //
        self.backgroundColor = [UIColor clearColor];
        
        _frame = frame;
    }
    return self;
}

-(void)setString:(NSString *)string
{
    [self date];

    [_array removeAllObjects];
    [_timeLabelArry removeAllObjects];
    
    _string = string;
  
    
    if(string.length > 7){
        [self hour:string];
    }else if (string.length < 7 && string.length > 2){
        [self minute:string];
    }else{
        [self second:string];
    }
    
    switch (self.type) {
        case timeTypeHour:
            [self realTimeType:_array];
            break;
        case timeTypeMinute:
            [self realTimeType:_array];
            break;
        case timeTypeSecond:
            [self realTimeType:_array];
            break;
        default:
            break;
    }
    
    if(timer == nil){
    
        hourCount = [[NSString stringWithFormat:@"%@%@",hour_one,hour_two] integerValue];
        minuteCount = [[NSString stringWithFormat:@"%@%@",minute_one,minute_two] integerValue];
        secondCount = [[NSString stringWithFormat:@"%@%@",second_one,second_two] integerValue];

    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
}

-(NSMutableArray *)timeLabelArry
{
    if(_timeLabelArry == nil){
        _timeLabelArry = [NSMutableArray array];
    }
    return _timeLabelArry;
}
-(NSMutableArray *)array{
    if(_array == nil){
        _array = [NSMutableArray array];
    }
    return _array;
}

-(void)realTimeType:(NSMutableArray *)array
{

    NSInteger count = 0;
    if(array.count == 4){//minute
        count = array.count + 1;
    }
    else if(array.count == 6){//hour
        count = array.count + 2;
    }
    else{
        count = array.count;
    }
    
    
    CGFloat width = _frame.size.width / count ;
    CGFloat height = _frame.size.height;
    CGFloat spaceing = 1;
    
    for(int i = 0 ; i < count ; i++){
        UILabel *label ;
        
        if(i == 2 || i == 5){
            label  = [[UILabel alloc]initWithFrame:CGRectMake(i * width ,
                                                              0,
                                                              width, height)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor orangeColor];
            label.text = @":";
        }else{
            
            label  = [[UILabel alloc]initWithFrame:CGRectMake(i * width ,
                                                              0,
                                                              width - spaceing, height)];
            label.backgroundColor = [UIColor orangeColor];
            label.textColor = [UIColor whiteColor];
            [self.timeLabelArry addObject:label];
        }
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
    }
    
    
    
    if(timer != nil){
    for(int i = 0 ; i < self.timeLabelArry.count ; i++)
    {
        UILabel *label = self.timeLabelArry[i];
        label.text = array[i];
    }
    }

}


-(void)hour:(NSString *)string
{
    
        //截取小时
        hour_one = [string substringToIndex:1];
        hour_two = [string  substringWithRange:NSMakeRange(1, 1.5)];
    
        [self.array addObject:hour_one];
        [self.array addObject:hour_two];
    
        //分钟
        minute_one = [string substringWithRange:NSMakeRange(2, 2.5)];
        minute_one = [minute_one substringFromIndex:1];
        minute_two = [string substringWithRange:NSMakeRange(2.5, 3)];
        minute_two = [minute_two substringFromIndex:2];
        
        [self.array addObject:minute_one];
        [self.array addObject:minute_two];
    
        //秒
        second_one = [string substringFromIndex:string.length - 2];
        second_one = [second_one substringToIndex:1];
        second_two = [string substringFromIndex:string.length - 1];
        
        [self.array addObject:second_one];
        [self.array addObject:second_two];

        self.type = timeTypeHour;

}

-(void)minute:(NSString *)string
{
    //分钟
    minute_one = [string substringToIndex:1];
    minute_two = [string substringWithRange:NSMakeRange(1, 1.5)];
    
    [self.array addObject:minute_one];
    [self.array addObject:minute_two];
    
    //秒
    second_one = [string substringFromIndex:string.length - 2];
    second_one = [second_one substringToIndex:1];
    second_two = [string substringFromIndex:string.length - 1];
    
    [self.array addObject:second_one];
    [self.array addObject:second_two];
    
    self.type = timeTypeMinute;

}

-(void)second:(NSString *)string
{
    //秒
    second_one = [string substringToIndex:1];
    second_two = [string substringWithRange:NSMakeRange(1, 1.5)];
    
    [self.array addObject:second_one];
    [self.array addObject:second_two];
    
    self.type = timeTypeSecond;

}

-(void)countDown
{
    for(UILabel *label in self.subviews){
        [label removeFromSuperview];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    
    [components setYear:self.year];
    [components setMonth:self.month];
    [components setDay:self.day];
//    [components setHour:02];
//    [components setMinute:00];
//    [components setSecond:00];

    if(hourCount != 0){
        [components setHour:hourCount];
    }else{
        [components setHour:self.hour];
    }
    
    if(minuteCount != 0){
        [components setMinute:minuteCount];
    }else{
        [components setMinute:self.minute];
    }
    
    [components setSecond:secondCount];
    
    NSDate *toDate = [calendar dateFromComponents:components];
    NSDate *today  = [NSDate date];
    
    NSString *second;
    NSString *mimute;
    NSString *hour;
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *countDown = [calendar components:unitFlags fromDate:today toDate:toDate options:NSCalendarWrapComponents];
    if ([countDown year]>0 || [countDown month]>0 || [countDown day]>0 || [countDown hour]>0 || [countDown minute]>0 || [countDown second]>0) {
        if([countDown hour] == 0){
            if([countDown minute] == 0){
                second = [NSString stringWithFormat:@"%ld",(long)[countDown second]];
                
                if(second.length < 2){
                    second = [NSString stringWithFormat:@"0%ld",(long)[countDown second]];
                }
                
                self.string = second;

                }else{
                    
                    mimute = [NSString stringWithFormat:@"%ld",(long)[countDown minute]];
                    second = [NSString stringWithFormat:@"%ld",(long)[countDown second]];
                    
                    if(mimute.length < 2){
                        mimute = [NSString stringWithFormat:@"0%ld",(long)[countDown minute]];
                    }
                    if(second.length < 2){
                        second = [NSString stringWithFormat:@"0%ld",(long)[countDown second]];
                    }
                    self.string = [NSString stringWithFormat:@"%@:%@",mimute,second];
            }

        }else{
            hour = [NSString stringWithFormat:@"%ld",(long)[countDown hour]];

            if(hour.length < 2){
                hour = [NSString stringWithFormat:@"0%ld",(long)[countDown hour]];
            }
            
            mimute = [NSString stringWithFormat:@"%ld",(long)[countDown minute]];
            second = [NSString stringWithFormat:@"%ld",(long)[countDown second]];
            
            if(mimute.length < 2){
                mimute = [NSString stringWithFormat:@"0%ld",(long)[countDown minute]];
            }
            if(second.length < 2){
                second = [NSString stringWithFormat:@"0%ld",(long)[countDown second]];
            }

            self.string = [NSString stringWithFormat:@"%@:%@:%@", hour, mimute,second];
        }
        
        
    }else{
//        label.text = @"活动已结束";
        [timer invalidate];//停止计时器 释放NSTimer
    }

}


-(void)date{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"YYYY:MM:dd hh:mm:ss"];
    _currentDateString = [dateFormatter stringFromDate:date];
}


-(NSInteger)year
{
    NSString *str = [_currentDateString substringToIndex:4];
    _year = [str integerValue];
    return _year;
}

-(NSInteger)month
{
    NSString *str = [_currentDateString substringWithRange:NSMakeRange(5, 2)];
    _month = [str integerValue];
    return _month;
}

-(NSInteger)day
{
    NSString *str = [_currentDateString substringWithRange:NSMakeRange(8, 2)];
    _day = [str integerValue];

    return _day;
}
-(NSInteger)hour
{
    NSString *str = [_currentDateString substringWithRange:NSMakeRange(11, 2)];
    _hour = [str integerValue];
    return _hour;
}
-(NSInteger)minute
{
    NSString *str = [_currentDateString substringWithRange:NSMakeRange(14, 2)];
    _minute = [str integerValue];
    return _minute;
}

@end
