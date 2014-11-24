//
//  ViewController.m
//  bootUpScreen
//
//  Created by 阿部 竜之介 on 2014/10/23.
//  Copyright (c) 2014年 RyunosukeAbe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self time];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(time)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)time{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;
    
    flags = NSWeekdayCalendarUnit |  NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    comps = [calendar components:flags fromDate:now];
    
    NSInteger weekday = comps.weekday;
    NSInteger month = comps.month;
    NSInteger day = comps.day;
    NSInteger hour = comps.hour;
    NSInteger minute = comps.minute;
//    NSString *week;
//    
//    switch (weekday) {
//        case 1:
//            week = @"日";
//            break;
//        case 2:
//            week = @"月";
//            break;
//        case 3:
//            week = @"火";
//            break;
//        case 4:
//            week = @"水";
//            break;
//        case 5:
//            week = @"木";
//            break;
//        case 6:
//            week = @"金";
//            break;
//        case 7:
//            week = @"土";
//            break;
//            
//        default:
//            break;
//    }
    
    NSArray *weekArray = @[@"日",@"月",@"火",@"水",@"木",@"金",@"土"];
    
    time.text = [NSString stringWithFormat:@"%d:%02d",hour,minute];
    date.text = [NSString stringWithFormat:@"%d月%d日(%@曜日)",month,day,weekArray[weekday-1]];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [slide addGestureRecognizer:pan];
    
}

-(void)panAction:(UIPanGestureRecognizer *)sender{
    
    CGPoint st = [sender translationInView:self.view];
    CGPoint movePoint = CGPointMake(slide.center.x + st.x, slide.center.y);
    slide.center = movePoint;
    
    [sender setTranslation:CGPointZero inView:self.view];
    [self.view bringSubviewToFront:slide];
    
    if ([sender state] == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.3 // 4秒かけてアニメーション
                         animations:^
        {
            CGRect frame = slide.frame;
            frame.origin.x = 0; // 右に100移動
            slide.frame = frame;
        }];
    }
}

@end
