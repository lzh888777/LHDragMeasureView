//
//  LHScrollMeasureView.m
//  AbsWorkout_iOS
//
//  Created by liuzhihua on 2018/12/25.
//  Copyright © 2018 TouchPal. All rights reserved.
//

#import "LHScrollMeasureView.h"
#import "Masonry.h"
#import "Macro.h"

typedef void(^LHCapsuleButtonTabChangeBlock)(LHScrollMeasureViewTabIndex index);

#define kHalfCicleBtnWidth 50
#define kHalfCicleBtnHeight 32
static CGFloat const cellWidth = 6.5;
static NSString * const LHCollectionHeader = @"LHCollectionHeader";
static NSString * const LHCollectionFooter = @"LHCollectionFooter";

@interface LHCapsuleButton : UIView
@property (nonatomic,strong) UIButton *leftTabButton;
@property (nonatomic,strong) UIButton *rightTabButton;
@property (nonatomic,   copy) NSString *leftTitle;
@property (nonatomic,   copy) NSString *rightTitle;
@property (nonatomic,weak) UIButton *selectedBtn;
@property (nonatomic,assign) LHScrollMeasureViewTabIndex curIndex;
@property (nonatomic,copy) LHCapsuleButtonTabChangeBlock selectedChangeBlock;
- (instancetype)initWithLeftTitle:(NSString *)title rightTitle:(NSString *)rightTitle curInde:(LHScrollMeasureViewTabIndex)index;
@end


@implementation LHCapsuleButton

- (instancetype)initWithLeftTitle:(NSString *)title rightTitle:(NSString *)rightTitle curInde:(LHScrollMeasureViewTabIndex)index{
    if (self = [super init]) {
        self.leftTitle = title;
        self.clipsToBounds = YES;
        self.rightTitle = rightTitle;
        self.curIndex = index;
        [self createViews];
    }
    return self;
}

- (void)createViews{
    [self addSubview:self.leftTabButton];
    if (self.rightTitle) {
        [self addSubview:self.rightTabButton];
        [self.leftTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kHalfCicleBtnWidth, kHalfCicleBtnHeight));
            make.top.left.bottom.equalTo(self);
        }];
        
        [self.rightTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kHalfCicleBtnWidth, kHalfCicleBtnHeight));
            make.top.bottom.equalTo(self.leftTabButton);
            make.left.equalTo(self.leftTabButton.mas_right);
            make.right.equalTo(self);
        }];
        
        if (self.curIndex == LHScrollMeasureViewTabIndexLeft) {
            _selectedBtn = self.leftTabButton;
        }else{
            _selectedBtn = self.rightTabButton;
        }
    }else{
        [self.leftTabButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kHalfCicleBtnWidth * 2, kHalfCicleBtnHeight));
            make.top.left.bottom.right.equalTo(self);
            _selectedBtn = self.leftTabButton;
        }];
    }

}

- (void)btnClick:(UIButton *)btn{
    if (![self.selectedBtn isEqual:btn]) {
        if (_selectedBtn) {
            _selectedBtn.backgroundColor = LHColorFromRGB(0xf2f2f2);
            [_selectedBtn setTitleColor:LHColorFromRGB(0x202a3b) forState:UIControlStateNormal];
        }
        _selectedBtn = btn;
        _selectedBtn.backgroundColor = LHColorFromRGB(0xfa526e);
        [_selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (self.selectedChangeBlock) {
            self.selectedChangeBlock([btn isEqual:self.leftTabButton] ? LHScrollMeasureViewTabIndexLeft: LHScrollMeasureViewTabIndexRight);
        }
        
    }
}

- (UIButton *)leftTabButton{
    if (_leftTabButton == nil) {
        
        _leftTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftTabButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftTabButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_leftTabButton setTitleColor:LHColorFromRGB(0x202a3b) forState:UIControlStateNormal];
        _leftTabButton.backgroundColor = LHColorFromRGB(0xf2f2f2);
        [_leftTabButton setTitle:self.leftTitle forState:UIControlStateNormal];
        [_leftTabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (self.rightTitle) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kHalfCicleBtnWidth, kHalfCicleBtnHeight)
                                                           byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft
                                                                 cornerRadii:CGSizeMake(kHalfCicleBtnHeight/2.0 , kHalfCicleBtnHeight/2.0 )];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            
            maskLayer.frame = CGRectMake(0, 0, kHalfCicleBtnWidth, kHalfCicleBtnHeight);
            
            maskLayer.path = maskPath.CGPath;
            
            _leftTabButton.layer.mask = maskLayer;
            
        }else{
            _leftTabButton.layer.cornerRadius = kHalfCicleBtnHeight * 0.5;
        }
        if (self.curIndex == LHScrollMeasureViewTabIndexLeft) {
            _leftTabButton.backgroundColor = LHColorFromRGB(0xfa526e);
            [_leftTabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
    }
    return _leftTabButton;
}

- (UIButton *)rightTabButton{
    if (_rightTabButton == nil) {
        _rightTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightTabButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightTabButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightTabButton setTitleColor:LHColorFromRGB(0x202a3b) forState:UIControlStateNormal];
        [_rightTabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightTabButton.backgroundColor = LHColorFromRGB(0xf2f2f2);
        [_rightTabButton setTitle:self.rightTitle forState:UIControlStateNormal];
        [_rightTabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        CGSizeMake(kHalfCicleBtnHeight, kHalfCicleBtnHeight);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kHalfCicleBtnWidth, kHalfCicleBtnHeight)
                                                       byRoundingCorners:UIRectCornerBottomRight|UIRectCornerTopRight
                                                             cornerRadii:CGSizeMake(kHalfCicleBtnHeight/2.0 , kHalfCicleBtnHeight/2.0 )];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = CGRectMake(0, 0, kHalfCicleBtnWidth, kHalfCicleBtnHeight);
        
        maskLayer.path = maskPath.CGPath;
        
        _rightTabButton.layer.mask = maskLayer;
        if (self.curIndex == LHScrollMeasureViewTabIndexRight) {
            _rightTabButton.backgroundColor = LHColorFromRGB(0xfa526e);
            [_rightTabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    return _rightTabButton;
}

@end


@interface LHDegreeCell : UICollectionViewCell
@end
@interface LHDegreeCell ()
@property (nonatomic, strong) UIView * line;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UIColor *highLightColor;
@end
@implementation LHDegreeCell
+(NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = LHColorFromRGB(0xB4BBC5);
    [self addSubview:self.line];
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(-15, 41, 30, 19)];
    self.numLabel.font = [UIFont systemFontOfSize:16.0];
    self.numLabel.textColor = LHColorFromRGB(0x4A586F);
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.numLabel];
}

- (void)updateCellWithHightLight:(BOOL)select{
    if (select) {
        self.numLabel.textColor = self.highLightColor;
    }else{
        self.numLabel.textColor = [UIColor blackColor];
    }
}


@end


@interface LHScrollMeasureView()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic,strong) UILabel *valueLabel;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,assign) int leftTotalCellCount;

@property (nonatomic,assign) int rightTotalCellCount;

@property (nonatomic,strong) NSIndexPath *lastIndexPath;

@property (nonatomic,assign) CGFloat curLeftValue;

@property (nonatomic,assign) CGFloat curRightValue;

@property (nonatomic,assign) BOOL hasViewScrolled;

//@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@end

@implementation LHScrollMeasureView

- (instancetype)initWithModel:(LHScrollMeasureModel *)model currentValue:(CGFloat)value{
    if (self = [super init]) {
        self.model = model;
        self.curValue = value;
        self.curIndex = LHScrollMeasureViewTabIndexLeft;
        self.leftTotalCellCount = (model.maxValue - model.minValue)/model.oneDegreeValue + 1;
        [self createViews];
    }
    return self;
}

- (instancetype)initWithLeftTabModel:(LHScrollMeasureModel *)model rightTabModel:(LHScrollMeasureModel *)rightModel leftToRightRatio:(CGFloat)ratio currentValue:(CGFloat)value currentIndex:(LHScrollMeasureViewTabIndex)index{
    if (self = [super init]) {
        self.model = model;
        self.curValue = value;
        self.curIndex = index;
        self.rightModel = rightModel;
        self.leftTabToRightTabRatio = ratio;
        if (self.leftTabToRightTabRatio) {
            self.rightModel.minValue = roundf(self.model.minValue * self.leftTabToRightTabRatio);
            self.rightModel.maxValue = roundf(self.model.maxValue * self.leftTabToRightTabRatio);
        }
        self.rightTotalCellCount = (rightModel.maxValue - rightModel.minValue)/rightModel.oneDegreeValue + 1;
        self.leftTotalCellCount = (model.maxValue - model.minValue)/model.oneDegreeValue + 1;
        [self createViews];
    }
    return self;
}

- (void)createViews{
    LHCapsuleButton *btn = [[LHCapsuleButton alloc] initWithLeftTitle:self.model.title rightTitle:self.rightModel.title curInde:self.curIndex];
    [self addSubview:btn];
    WEAK_SELF
    btn.selectedChangeBlock = ^(LHScrollMeasureViewTabIndex index) {
        int step  =0;
        NSString *text = @"";
        if (index == LHScrollMeasureViewTabIndexLeft) {
            CGFloat value = weakSelf.curRightValue / weakSelf.leftTabToRightTabRatio;
            if (weakSelf.hasViewScrolled == NO) {
                value = weakSelf.curLeftValue;
            }
            if (weakSelf.model.oneDegreeValue< 1) {
                text = [NSString stringWithFormat:@"%.1f",value];
                step = roundf((value - weakSelf.model.minValue) / weakSelf.model.oneDegreeValue);
            }else{
                value = roundf(value);
                text = [NSString stringWithFormat:@"%d",(int)(roundf(value))];
                step = roundf((value - weakSelf.model.minValue) / weakSelf.model.oneDegreeValue);
            }
        }else{
            CGFloat value = weakSelf.curLeftValue * weakSelf.leftTabToRightTabRatio;
            if (weakSelf.hasViewScrolled == NO) {
                value = weakSelf.curRightValue;
            }
            if (weakSelf.rightModel.oneDegreeValue < 1) {
                text = [NSString stringWithFormat:@"%.1f",value];
                step = (value - weakSelf.rightModel.minValue) / weakSelf.rightModel.oneDegreeValue;
            }else{
                value = roundf(value);
                text = [NSString stringWithFormat:@"%d",(int)value];
                step = roundf((value - weakSelf.rightModel.minValue) / weakSelf.rightModel.oneDegreeValue);
            }
        }
        weakSelf.valueLabel.text = text;
        weakSelf.curIndex = index;
        weakSelf.lastIndexPath = [NSIndexPath indexPathForRow:step inSection:0];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView setContentOffset:CGPointMake(step * cellWidth, 0)];
        if ([weakSelf.delegate respondsToSelector:@selector(measureView:didChangeTab:)]) {
            [weakSelf.delegate measureView:weakSelf didChangeTab:index];
        }
        weakSelf.hasViewScrolled = NO;
    };
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [self addSubview:self.valueLabel];
    self.valueLabel.text = LHSTR_FORMAT(@"%.1f",self.curValue);
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(22);
        make.centerX.equalTo(btn);
    }];
    
    UIView *triangleView = [UIView new];
    triangleView.backgroundColor = [UIColor whiteColor];
    CAShapeLayer *triangleLayer = [CAShapeLayer layer];
    triangleLayer.strokeColor = LHColorFromRGB(0xfa526e).CGColor;
    triangleLayer.fillColor = LHColorFromRGB(0xfa526e).CGColor;
    triangleLayer.lineWidth = 0.5f;
    
    CGPoint tmpPoint0 = CGPointMake(0, 0);
    CGPoint tmpPoint1 = CGPointMake(7, 10);
    CGPoint tmpPoint2 = CGPointMake(14, 0);;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: tmpPoint0];
    [path addLineToPoint: tmpPoint1];
    [path addLineToPoint: tmpPoint2];
    [path closePath];//闭合曲线
    
    triangleLayer.path = path.CGPath;
    [triangleView.layer addSublayer:triangleLayer];
    [self addSubview:triangleView];
    [triangleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.top.equalTo(self.valueLabel.mas_bottom).offset(6);
        make.size.mas_equalTo(CGSizeMake(14, 10));
    }];
    
    UIView *gradientBackView = [UIView new];
    gradientBackView.layer.masksToBounds = YES;
    gradientBackView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:gradientBackView];
    gradientBackView.alpha = 0.5;

    [gradientBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(triangleView.mas_bottom).offset(10);
        make.height.mas_equalTo(72);
    }];
    

    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(gradientBackView);
    }];
    
    UILabel *degreeLabel = [UILabel new];
    degreeLabel.backgroundColor = self.valueLabel.textColor;
    [self addSubview:degreeLabel];
    [degreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(triangleView);
        make.size.mas_equalTo(CGSizeMake(1.5, 24));
        make.top.equalTo(self.collectionView).offset(7);
    }];
    [self layoutIfNeeded];

    [self.collectionView reloadData];
    NSInteger index = 0;
    
    if (self.curIndex == LHScrollMeasureViewTabIndexLeft) {
        index = roundf((self.curValue - self.model.minValue)/self.model.oneDegreeValue);
    }else{
        index = roundf((self.curValue - self.rightModel.minValue)/self.rightModel.oneDegreeValue);
    }
    
    if (index > 0) {
        self.lastIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView setContentOffset:CGPointMake(index * cellWidth, 0) animated:NO];
        });
    }else{
        if (self.curIndex == LHScrollMeasureViewTabIndexLeft) {
            self.curValue = self.model.minValue;
            self.valueLabel.text = LHSTR_FORMAT(@"%.1f",self.model.minValue);
        }else{
            self.curValue = self.rightModel.minValue;
            self.valueLabel.text = LHSTR_FORMAT(@"%.1f",self.rightModel.minValue);
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    if (self.bounds.size.width > 0 && layout.headerReferenceSize.height == 0) {
        layout.headerReferenceSize = CGSizeMake(self.bounds.size.width/2, 62);
        layout.footerReferenceSize = CGSizeMake(self.bounds.size.width/2 - cellWidth, 62);
    }
}

- (void)updateDataWith:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    int step = roundl(offset.x/cellWidth);
    int maxCount = self.curIndex == LHScrollMeasureViewTabIndexLeft ? self.leftTotalCellCount : self.rightTotalCellCount;
    if (step > maxCount) step = maxCount;
    [self updateCurValueWithStep:step];
    [self.collectionView setContentOffset:CGPointMake(step * cellWidth, 0) animated:YES];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:step inSection:0];
    LHDegreeCell *currentCell = (LHDegreeCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [currentCell updateCellWithHightLight:YES];
    self.lastIndexPath = indexPath;
    
}

- (void)updateCurValueWithStep:(CGFloat)step{
    NSString *text = @"";
    self.valueLabel.text = text;
    self.hasViewScrolled = YES;
    CGFloat value = 0;
    if (self.curIndex == LHScrollMeasureViewTabIndexLeft) {
        self.curLeftValue = self.model.minValue + step * self.model.oneDegreeValue;
        value = self.curLeftValue;
        if (self.model.oneDegreeValue < 1) {
            text = [NSString stringWithFormat:@"%.1f",self.curLeftValue];
        }else{
            text = [NSString stringWithFormat:@"%d",(int)(roundf(self.curLeftValue))];
        }
        self.curValue = self.curLeftValue;
    }else{
        self.curRightValue = self.rightModel.minValue + step * self.rightModel.oneDegreeValue;
        value = self.curRightValue;
        if (self.rightModel.oneDegreeValue< 1) {
            text = [NSString stringWithFormat:@"%.1f",self.curRightValue];
        }else{
            text = [NSString stringWithFormat:@"%d",(int)(roundf(self.curRightValue))];
        }
        self.curValue = self.curRightValue;
    }
    if ([self.delegate respondsToSelector:@selector(measureView:didChangeValue:atIndex:)]) {
        [self.delegate measureView:self didChangeValue:value atIndex:self.curIndex];
    }
    self.valueLabel.text = text;
}


- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = [UIFont boldSystemFontOfSize:32];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.textColor = LHColorFromRGB(0xfa526e);
    }
    return _valueLabel;
}

- (NSInteger)valueWithIndexPath:(NSIndexPath *)indexPath{
    if (self.curIndex == LHScrollMeasureViewTabIndexLeft) {
        NSInteger step = indexPath.row + self.model.minValue / self.model.oneDegreeValue;
        return step;
    }else{
        NSInteger step = indexPath.row + self.rightModel.minValue / self.rightModel.oneDegreeValue;
        return step;
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSInteger count = self.curIndex == LHScrollMeasureViewTabIndexLeft ? self.leftTotalCellCount : self.rightTotalCellCount;
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHDegreeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LHDegreeCell reuseIdentifier] forIndexPath:indexPath];
    cell.highLightColor = self.valueLabel.textColor;
    if (indexPath.row == self.lastIndexPath.row) {
        [cell updateCellWithHightLight:YES];
    }else{
        [cell updateCellWithHightLight:NO];
    }
    NSInteger value = [self valueWithIndexPath:indexPath];
    CGFloat oneDegreeValue = self.rightModel.oneDegreeValue;
    if (self.curIndex == LHScrollMeasureViewTabIndexLeft) {
        oneDegreeValue = self.model.oneDegreeValue;
    }
    if (value % 10 == 0) {
        cell.numLabel.text = [NSString stringWithFormat:@"%ld", (long)(value * oneDegreeValue)];
        cell.line.frame = CGRectMake(0, 2, 1.5, 24);
    }else if (value % 5 == 0) {
        cell.numLabel.text = @"";
        cell.line.frame = CGRectMake(0, 2, 1.5, 18);
    }else {
        cell.numLabel.text = @"";
        cell.line.frame = CGRectMake(0, 2, 1.5, 14);
    }
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LHCollectionHeader forIndexPath:indexPath];
        return headerView;
    }else {
        UICollectionReusableView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:LHCollectionFooter forIndexPath:indexPath];
        return footerView;
    }
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    LHDegreeCell *lastCell = (LHDegreeCell *)[self.collectionView cellForItemAtIndexPath:self.lastIndexPath];
    [lastCell updateCellWithHightLight:NO];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateDataWith:scrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    NSInteger step = roundf(offset.x/cellWidth);
    NSInteger maxCount = self.curIndex == LHScrollMeasureViewTabIndexLeft ? self.leftTotalCellCount : self.rightTotalCellCount;
    if (step > maxCount) step = maxCount;
    if (step <= 0) step = 0;
//    self.currentValue = [self conversionInternationaluUit:step];
//    [self setValueLabelTextWith:step];
    [self updateCurValueWithStep:step];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self updateDataWith:scrollView];
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(cellWidth, 62);
//        self.layout = layout;
//        layout.headerReferenceSize = CGSizeMake(LHScreenWidth/2 - 10, 62);
//        layout.footerReferenceSize = CGSizeMake(LHScreenWidth/2 - 3 * cellWidth, 62);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.bounces = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[LHDegreeCell class] forCellWithReuseIdentifier:[LHDegreeCell reuseIdentifier]];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LHCollectionHeader];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:LHCollectionFooter];
    }
    return _collectionView;
}

@end

@implementation LHScrollMeasureModel

@end
