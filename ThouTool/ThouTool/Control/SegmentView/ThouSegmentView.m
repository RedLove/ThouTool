//
//  ThouSegmentView.m
//  ThouTool
//
//  Created by thou on 16/5/5.
//  Copyright © 2016年 thou. All rights reserved.
//

#import "ThouSegmentView.h"
#import "ThouUnderLineView.h"

#import "UIView+ViewController.h"
#import "ThouHorizonalLiveView.h"

#import "ThouHelper.h"
#import "ViewNormal.h"
#import "PhoneNormal.h"

#define kItemHeight 44
#define kSegmentBackgroundColor thouRGB(242, 242, 242)

@interface ThouSegmentView() <UIScrollViewDelegate>
{
    CGFloat _itemWidth;
    CGFloat _itemHeight;
}
@property (nonatomic) ThouSegmentViewStyle style;

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *btnControlView;

@property (nonatomic,strong) UIView *presentControlView;

@property (nonatomic,strong) UIView *selectTitlesView;

@property (nonatomic,strong) UIScrollView *indicatorScrollView;
@property (nonatomic,strong) NSArray<UIViewController *> *subViewControllers;

@end

@implementation ThouSegmentView

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles 
{
    return [self initWithFrame:frame withTitles:titles andStyle:ThouSegmentViewStyleDefault];
}

- (instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles andStyle:(ThouSegmentViewStyle)style
{
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _style = style;
        self.backgroundColor = kSegmentBackgroundColor;
        [self configParams];
        [self buildViews];
    }
    return self;
}

- (void)buildViews
{
    [self addSubview:self.contentView];
    [self createLabelToView:self.contentView WithColor:thouBlackColor isBold:NO];
    
    [self.contentView addSubview:self.btnControlView];
    [self createControlButtonToView:self.btnControlView];
    
    [self.contentView addSubview:self.presentControlView];
    
    [self.presentControlView addSubview:self.selectTitlesView];
    [self createLabelToView:self.selectTitlesView WithColor:thouRedColor isBold:YES];
    
    [self addSubview:self.indicatorScrollView];
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _contentView;
}

- (UIView *)btnControlView
{
    if (!_btnControlView) {
        _btnControlView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    }
    return _btnControlView;
}

- (UIView *)presentControlView
{
    if (!_presentControlView) {
        CGRect frame = CGRectMake(0, 0, _itemWidth, _itemHeight);
        _presentControlView = [[[self getUnderLineByStyle] alloc] initWithFrame:frame];
        _presentControlView.clipsToBounds = YES;
    }
    return _presentControlView;
}

- (UIView *)selectTitlesView
{
    if (!_selectTitlesView) {
        CGRect frame = CGRectMake(0, 0, self.bounds.size.width, _itemHeight);
        _selectTitlesView = [[UIView alloc] initWithFrame:frame];
        _selectTitlesView.userInteractionEnabled = NO;
        _selectTitlesView.backgroundColor = [UIColor clearColor];
    }
    return _selectTitlesView;
}

- (UIScrollView *)indicatorScrollView
{
    if (!_indicatorScrollView) {
        CGRect frame = CGRectMake(0, 0, self.bounds.size.width, 0);
        _indicatorScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _indicatorScrollView.pagingEnabled = YES;
        _indicatorScrollView.showsHorizontalScrollIndicator = NO;
        _indicatorScrollView.showsVerticalScrollIndicator = NO;
        _indicatorScrollView.contentSize = self.bounds.size;
        _indicatorScrollView.bounces = NO;
        _indicatorScrollView.delegate = self;
    }
    return _indicatorScrollView;
}

- (void)createLabelToView:(UIView *)view WithColor:(UIColor *)color isBold:(BOOL)bold{
    for (int i = 0; i < [self.titles count]; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(i*_itemWidth, 0, _itemWidth, _itemHeight)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:self.titles[i]];
        if (bold) {
            [label setFont:kFontBold(kETitleSize)];
            label.shadowColor = kSegmentBackgroundColor;
        }else{
            [label setFont:kFont(kETitleSize)];
            CGFloat lineWidth = 1;
            if (i != self.titles.count -1 ) {
                [fn drawLineWithSuperView:label Color:thouRGB(201, 201, 201) Frame:CGRectMake(_itemWidth - lineWidth, 5 , lineWidth , _itemHeight - 5 * 2)];
            }
        }
        [label setTextColor:color];
        [view addSubview:label];
    }
}

- (void)createControlButtonToView:(UIView *)view{
    for (int i = 0; i < [self.titles count]; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*_itemWidth, 0, _itemWidth, _itemHeight)];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        [view addSubview:btn];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.indicatorScrollView) {
        [UIView animateWithDuration:0.5 animations:^{
            CGFloat distance = self.bounds.size.width;
            CGRect frame = (CGRect){(CGPoint){scrollView.contentOffset.x / distance * _itemWidth,0},self.presentControlView.frame.size};
            self.presentControlView.frame = frame;
            frame = (CGRect){(CGPoint){-scrollView.contentOffset.x / distance * _itemWidth,0},self.selectTitlesView.frame.size};
            self.selectTitlesView.frame = frame;
        }];
    }
}

#pragma mark - action
- (void)btnClick:(UIButton *)sender{
    CGFloat distance = self.bounds.size.width;
    [self.indicatorScrollView setContentOffset:CGPointMake(sender.tag * distance, 0) animated:YES];
    //    [self.delegate didSelectIndex:sender.tag];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result) {
        CGPoint p = [self convertPoint:point toView:self.indicatorScrollView];
        result = [self.indicatorScrollView pointInside:p withEvent:event];
    }
    return result;
}

#pragma mark - 数据配置
- (void)configParams
{
    _itemWidth =  self.bounds.size.width / self.titles.count;
    _itemHeight =  self.bounds.size.height;
}

- (void)setSubViewControllers:(NSArray<UIViewController *> *)subViewControllers
{
    // 控制器个数需要和标题个数对应
    NSAssert(subViewControllers.count == self.titles.count, @"Error:The count of subViewControllers is not equal the titles'.");
    
    _subViewControllers = subViewControllers;
    // 如果滚动视图没有设置大小，那么给一个从segment底部开始到屏幕底部范围的空间
    if (self.indicatorScrollView.frame.size.height == 0) {
        [self setDefaultScrollArea];
    }
    
    NSInteger count = self.titles.count;
    NSInteger vcWidth = self.indicatorScrollView.bounds.size.width;
    NSInteger vcHeight = self.indicatorScrollView.bounds.size.height;
    
    CGRect frame = CGRectZero;
    UIViewController *subVC;
    for (NSInteger i = 0; i < count; i++) {
        subVC = subViewControllers[i];
        [self.viewController addChildViewController:subVC];
        
        frame = CGRectMake(self.indicatorScrollView.frame.size.width * i, 0, vcWidth, vcHeight);
        subVC.view.frame = frame;
        [self.indicatorScrollView addSubview:subVC.view];
    }
}

- (void)setDefaultScrollArea
{
    CGFloat navHeight = kTabBarNavigationHeight;
    CGRect frame = CGRectMake(0,self.bounds.size.height,self.bounds.size.width, self.superview.bounds.size.height - CGRectGetMaxY(self.frame) - navHeight);
    [self setSubViewControllerSize:frame];
}

- (void)setSubViewControllerSize:(CGRect)frame
{
    self.indicatorScrollView.frame = frame;
    
    CGSize size = frame.size;
    CGSize contentSize = CGSizeMake(size.width * self.subViewControllers.count, size.height);
    self.indicatorScrollView.contentSize = contentSize;
}

- (Class)getUnderLineByStyle
{
    Class clz = [ThouUnderLineView class];
    switch (self.style) {
        case ThouSegmentViewStyleHorizonalLine:
            clz = [ThouHorizonalLiveView class];
            break;
        default:
            break;
    }
    return clz;
}

@end
