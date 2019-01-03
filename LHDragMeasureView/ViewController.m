//
//  ViewController.m
//  LHDragMeasureView
//
//  Created by liuzhihua on 2019/1/2.
//  Copyright © 2019 TouchPal. All rights reserved.
//

#import "ViewController.h"
#import "LHScrollMeasureView.h"
#import "Masonry.h"


@interface ViewController ()<LHScrollMeasureViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LHScrollMeasureModel *mModel = [[LHScrollMeasureModel alloc] init];
    LHScrollMeasureModel *rModel = [[LHScrollMeasureModel alloc] init];
    mModel.title = @"千克";
    rModel.title = @"英镑";
    mModel.oneDegreeValue = 0.1;
    rModel.oneDegreeValue= 1;
    mModel.maxValue= 100.9;
    mModel.minValue= 40;
    LHScrollMeasureView *view = [[LHScrollMeasureView alloc] initWithLeftTabModel:mModel rightTabModel:rModel leftToRightRatio:2.2046 currentValue:60 currentIndex:LHScrollMeasureViewTabIndexLeft];
//    LHScrollMeasureView *view = [[LHScrollMeasureView alloc] initWithModel:mModel currentValue:60];
    view.delegate = self;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(192);
    }];
}


- (void)measureView:(LHScrollMeasureView *)view didChangeValue:(CGFloat)currentValue atIndex:(LHScrollMeasureViewTabIndex)index{
    NSLog(@"curValue is %f,at index %d",currentValue,index);
}

- (void)measureView:(LHScrollMeasureView *)view didChangeTab:(LHScrollMeasureViewTabIndex)index{
    NSLog(@"curindex is %d",index);
}


@end
