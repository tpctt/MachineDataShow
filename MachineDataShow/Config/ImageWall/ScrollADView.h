//
//  ScrollADView.h
//  Taoqianbao2
//
//  Created by 中联信 on 15-2-26.
//  Copyright (c) 2015年 中联信. All rights reserved.
//

#import <UIKit/UIKit.h>


@class StyledPageControl;
@class ScrollADView;

typedef void(^SelectADBlock )(ScrollADView *adView,NSUInteger adIndex );
typedef void(^ScrollViewDidScrollBlock )(ScrollADView *adView,NSUInteger adIndex );

@interface ScrollADView : UIView<UIScrollViewDelegate>
//没有广告数据的时候的默认图像
@property (nonatomic, strong)   UIImage *noADImage;
//正在加载广告的过渡图像
@property (nonatomic, strong)   UIImage *defalutADImage;
//滚动的view
@property (strong, nonatomic)   UIScrollView *adScrollview;

//页面指示器
@property (strong, nonatomic)   UIPageControl *adPageControl;
//滚动的时间间隔
@property (assign ,nonatomic)  NSTimeInterval timeInterval;
///row numer
@property (assign ,nonatomic)  NSInteger rowNumber;

@property (   nonatomic,copy) SelectADBlock adBlock;
@property (   nonatomic,copy) ScrollViewDidScrollBlock adScrollBlock;
//循环滚动?默认为yes
@property (assign ,nonatomic) BOOL circle;
//上下方向,默认NO
@property (assign ,nonatomic) BOOL verticalScroll;
//imageView MODE
@property(nonatomic) UIViewContentMode contentMode;        
//广告的数据
-(void)setImages:(NSArray *)images withTitles:(NSArray*)titles;
-(NSInteger)objectNumber;
-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
-(void)scrollToLast;

@end
