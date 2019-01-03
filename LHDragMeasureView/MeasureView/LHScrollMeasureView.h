//
//  LHScrollMeasureView.h
//  AbsWorkout_iOS
//
//  Created by liuzhihua on 2018/12/25.
//  Copyright © 2018 liuzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LHScrollMeasureViewTabIndex) {
    LHScrollMeasureViewTabIndexLeft,
    LHScrollMeasureViewTabIndexRight
};


@interface LHScrollMeasureModel : NSObject

//@property (nonatomic,strong) NSString *leftTabTitle;
//
//@property (nonatomic,strong) NSString *rightTabTitle;

@property (nonatomic,strong) NSString *title;

//@property (nonatomic,assign) CGFloat leftOneDegreeValue;
//
//@property (nonatomic,assign) CGFloat rightOneDegreeValue;

@property (nonatomic,assign) CGFloat oneDegreeValue;

//@property (nonatomic,assign) CGFloat leftTabMinValue;
//
//@property (nonatomic,assign) CGFloat leftTabMaxValue;

@property (nonatomic,assign) CGFloat maxValue;

//@property (nonatomic,assign) CGFloat rightTabMinValue;

//@property (nonatomic,assign) CGFloat rightTabMaxValue;

@property (nonatomic,assign) CGFloat minValue;

//@property (nonatomic,assign) CGFloat leftTabToRightConvertRatio;

//@property (nonatomic,assign) LHScrollMeasureViewTabIndex curIndex;

@end


@class LHScrollMeasureView;

@protocol LHScrollMeasureViewDelegate <NSObject>

@optional
- (void)measureView:(LHScrollMeasureView *)view didChangeValue:(CGFloat)currentValue atIndex:(LHScrollMeasureViewTabIndex)index;
- (void)measureView:(LHScrollMeasureView *)view didChangeTab:(LHScrollMeasureViewTabIndex)index;

@end

@interface LHScrollMeasureView : UIView

@property (nonatomic,strong) LHScrollMeasureModel *model;

@property (nonatomic,strong) LHScrollMeasureModel *rightModel;

@property (nonatomic,assign) CGFloat curValue;

@property (nonatomic,assign) CGFloat leftTabToRightTabRatio;

@property (nonatomic,assign) LHScrollMeasureViewTabIndex curIndex;

@property (nonatomic,weak) id<LHScrollMeasureViewDelegate> delegate;

- (instancetype)initWithModel:(LHScrollMeasureModel *)model currentValue:(CGFloat)value;

- (instancetype)initWithLeftTabModel:(LHScrollMeasureModel *)model rightTabModel:(LHScrollMeasureModel *)rightModel leftToRightRatio:(CGFloat)ratio currentValue:(CGFloat)value currentIndex:(LHScrollMeasureViewTabIndex)index;

@end

NS_ASSUME_NONNULL_END
