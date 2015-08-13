//
//  ImageWall.m
//  UICollectionViewDemo
//
//  Created by 中联信 on 15/6/12.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "ImageWall.h"
#import "ScrollADView.h"

@interface ImageWall()
@property (strong,nonatomic) ScrollADView *view1;
@property (strong,nonatomic) ScrollADView *view2;
@property (strong,nonatomic) NSArray *array;
@property (strong,nonatomic) NSArray *array2;

//@property (strong,nonatomic) UIStepper *steper;

@end

@implementation ImageWall
-(void)resetViewPoi
{
//    NSInteger delt = (self.view1.adPageControl.numberOfPages - 3)/2;
    CGFloat w = _view2.adScrollview.frame.size.width/_view2.rowNumber;
//    CGFloat w1 = _view1.adScrollview.frame.size.width/_view1.rowNumber;
    _view2.adScrollview.contentOffset = CGPointMake(_view2.adScrollview.contentSize.width -  _view1.adScrollview.contentOffset.x/_view2.rowNumber - 2*w , _view2.adScrollview.contentOffset.y);
    if(_view1.circle == YES && _view1.adScrollview.contentOffset.x <= _view1.adScrollview.frame.size.width/_view1.rowNumber){
        
    }
}
-(void)setAdBlock:(SelectADBlock)adBlock
{
    [_view1 setAdBlock:adBlock];
    
}
-(void)commentInit
{
    // Do any additional setup after loading the view.
    _view1 = [[ScrollADView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _view1.backgroundColor = [UIColor clearColor];
    
    _view2 = [[ScrollADView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2)];
    _view2.backgroundColor = [UIColor clearColor];
    _view2.rowNumber = 2;
    _view2.adPageControl.hidden = YES;
    _view2.circle = NO ;
    _view1.circle = YES ;
    
    
    [_view1 setAdScrollBlock:^(ScrollADView *adView,NSUInteger adIndex )
     {
         NSInteger delt = (adView.adPageControl.numberOfPages - 3)/2;
         CGFloat w = _view2.adScrollview.frame.size.width/_view2.rowNumber;
         CGFloat w1 = _view1.adScrollview.frame.size.width/_view1.rowNumber; 
         _view2.adScrollview.contentOffset = CGPointMake(_view2.adScrollview.contentSize.width -  _view1.adScrollview.contentOffset.x/_view2.rowNumber - 2*w , _view1.adScrollview.contentOffset.y);
         if(_view1.circle == YES && _view1.adScrollview.contentOffset.x <= _view1.adScrollview.frame.size.width/_view1.rowNumber){
             
         }
         
     }];
    
    [self addSubview:_view2];
    [self addSubview:_view1];
}
-(void)setImageArray:(NSArray *)imageArray
{
    if (_imageArray == imageArray) {
        return;
    }
    _imageArray = imageArray;
    
    NSInteger numer = imageArray.count;
   
    
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    
    NSMutableArray *array00 = [NSMutableArray array];
    NSMutableArray *array200 = [NSMutableArray array];
    
    
    NSInteger delt = (numer-3)/2;
    
    for (int i = 1; i<=numer ; i++) {

        [array addObject:imageArray[i-1]];
        
        NSInteger index = 0;
        NSInteger zhongjian = numer/2 + numer%2 ;
        if(i <= zhongjian){
            index = i + delt+1;
        }else{
            index = i+zhongjian-numer -1  ;
        }
        
        if (index==0) {
            index = imageArray.count;
        }
        [array2 insertObject:imageArray[index-1] atIndex:0];
        
        
    }
    [array2 addObjectsFromArray:array2];
    [array2 addObject:[array2 firstObject]];
    
    
    [_view1 setImages:array withTitles:nil];
    [_view2 setImages:array2 withTitles:nil];
    

    
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    self.view1.frame = self.frame;
    self.view1.frame = CGRectMake(0, self.frame.size.height/4, self.frame.size.width, self.frame.size.height/2);

    self.view2.frame = CGRectMake(0, self.frame.size.height/3, self.frame.size.width, self.frame.size.height/3);
    
    if (self.view1.adScrollview.contentOffset.x == 0 && self.view2.adScrollview.contentOffset.x == 0) {
        if (self.view1.circle) {
            CGPoint po1 = CGPointMake(self.view1.frame.size.width/self.view1.rowNumber, 0);
            [self.view1.adScrollview setContentOffset:po1 animated:YES];
        }
      
    }else{
        CGFloat w = _view2.adScrollview.frame.size.width/_view2.rowNumber;
        CGPoint po = CGPointMake(_view2.adScrollview.contentSize.width -  _view1.adScrollview.contentOffset.x/_view2.rowNumber - 2*w , _view1.adScrollview.contentOffset.y);
        [_view2.adScrollview setContentOffset:po animated:YES];
        
    }
    [_view2 scrollViewDidScroll:_view2.adScrollview];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commentInit];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
