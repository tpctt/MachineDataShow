//
//  ScrollADView.m
//  Taoqianbao2
//
//  Created by 中联信 on 15-2-26.
//  Copyright (c) 2015年 中联信. All rights reserved.
//

#import "ScrollADView.h"
@interface NSArray (Safe)
-(id)safeObjectAtIndex:(NSInteger)index;
@end
@implementation NSArray(Safe)

-(id)safeObjectAtIndex:(NSInteger)index
{
    if (index<0) {
        return nil;
        
    }
    if (index>=self.count) {
        return nil;
    }
    if (self.count==0) {
        return nil;
    }
    return self[index];
}

@end

@interface ScrollADView()
@property (assign,nonatomic) CGRect preRect;

//没有使用的imageView
@property (strong,nonatomic) NSMutableArray *unusedImageViewArray;
//使用的imageView
@property (strong,nonatomic) NSMutableArray *usedImageViewArray;
//没有图像的默认底图
@property (strong,nonatomic) UIImageView *noADImageView;

@property (strong,nonatomic)  dispatch_source_t timer ;

@property (strong,nonatomic)  UITapGestureRecognizer *tap;

@property (strong,nonatomic)  NSArray *images;

@property (strong,nonatomic)  NSArray *titles;


///
@property (assign)  int prePage;


@end


@implementation ScrollADView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)commonInit
{
    self.circle = YES;
    self.contentMode = UIViewContentModeScaleToFill;
    
    self.unusedImageViewArray = [NSMutableArray array];
    self.usedImageViewArray = [NSMutableArray array];
    
    self.adScrollview  = [[UIScrollView alloc]initWithFrame:self.bounds];
    self.adPageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
    self.noADImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    self.rowNumber = 1;
    
    [self addSubview:self.adScrollview];
    [self addSubview:self.adPageControl];
    [self addSubview:self.noADImageView];
    
    self.adScrollview.showsHorizontalScrollIndicator = NO;
    self.adScrollview.showsVerticalScrollIndicator = NO;

    self.adScrollview.delegate = self;
    self.adScrollview.scrollsToTop = NO;
    self.adScrollview.pagingEnabled = YES;
    self.adScrollview.bounces = NO;
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAct:)];
    [self.adScrollview addGestureRecognizer:self.tap];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
    
}

-(void)tapAct:(UITapGestureRecognizer *)tap
{
    if(self.images.count)
    {
        NSUInteger index = self.adScrollview.contentOffset.x/self.adScrollview.frame.size.width;
        
        if (self.circle) {
            if (index == 0) {
                index = self.images.count - 1;
            }else{
                index -=1;
            }
        }
        
        if (self.adBlock) {
            self.adBlock(self, index);
            
        }
        
    }
}

-(void)setNoADImage:(UIImage *)noADImage
{
    if (noADImage == _noADImage) {
        return;
    }
    _noADImage = nil;
    _noADImage = noADImage;
    self.noADImageView.image = self.noADImage;
    
}
-(NSInteger)objectNumber
{
       return self.images.count;
}
//广告的数据
-(void)setImages:(NSArray *)images withTitles:(NSArray*)titles
{
    if (self.images == images && images != nil) {
        return;
    }
    self.images = nil;
    self.images = images;
    self.titles = titles;

    
    if (images == nil) {
        self.adScrollview.hidden = YES;
        self.noADImageView.hidden = NO;
        
        self.noADImageView.image = self.noADImage;
        return;
        
    }else{
        self.adScrollview.hidden = NO;
        self.noADImageView.hidden = YES;
    }

    [self.unusedImageViewArray addObjectsFromArray:self.usedImageViewArray ];
    [self.usedImageViewArray removeAllObjects];
    
    NSUInteger count = images.count;
    self.adPageControl.numberOfPages = (int)count;
    if(self.circle == YES)
    {
        count+=2;
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        UIImageView *imageView = [self.unusedImageViewArray safeObjectAtIndex:i];
        if (imageView==nil) {
            imageView = [[UIImageView alloc]init];
            
        }else{
        }
        imageView.contentMode = self.contentMode;
        
        if (self.titles) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
            label.text = [self.titles safeObjectAtIndex:i];
            [imageView addSubview:label];
            
        }
       
        
        //上下
        if (_verticalScroll == YES) {
            imageView.frame = CGRectMake(  0, i  * self.frame.size.height/self.rowNumber ,self.frame.size.width, self.frame.size.height/self.rowNumber);
            self.adScrollview.contentSize = CGSizeMake(self.frame.size.width, (i +1 )* self.frame.size.height/self.rowNumber);
            
        }else{
            imageView.frame = CGRectMake( i  * self.frame.size.width/self.rowNumber, 0, self.frame.size.width/self.rowNumber, self.frame.size.height);
            self.adScrollview.contentSize = CGSizeMake((i +1 )* self.frame.size.width/self.rowNumber, self.frame.size.height);

        }
        [self.adScrollview addSubview:imageView];
        [self.usedImageViewArray addObject:imageView];

        NSInteger realIndex = 0;
        
        if (self.circle) {
            if (i == 0) {
                realIndex = self.images.count-1;
                
            }else if(i==count-1){
                realIndex = 0;
                
            }else{
                realIndex = i-1 ;
            }
            
        }else{
            realIndex = i ;
            
        }

        {
            NSString *imagesString = images[realIndex];
            if  ([imagesString isKindOfClass:[NSString class]]){
                [imageView sd_setImageWithURL:[NSURL URLWithString:imagesString]
                             placeholderImage:self.defalutADImage
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                        
                                    }];
            }else if ([imagesString isKindOfClass:[UIImage class]]){
                UIImage *image = (UIImage*)imagesString;
                imageView.image = image;
                
            }
        }
    }
    [self.unusedImageViewArray removeObjectsInArray:self.adScrollview.subviews];
    
    
}

-(void)setTimeInterval:(NSTimeInterval)timeInterval
{
    if (_timeInterval == timeInterval) {
        return;
    }
    __block int timeout=timeInterval; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_source_t
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    //    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),timeout*NSEC_PER_SEC, 0); //TIMEouT执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }else{
            //            int minutes = timeout / 60;
            //            int seconds = timeout ;
            if (self.adScrollview.tracking) {
                
                return ;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:1 animations:^{
                    if (self.adScrollview.contentOffset.x >= self.adScrollview.contentSize.width -  self.adScrollview.frame.size.width ) {
                        self.adScrollview.contentOffset = CGPointZero;
                    }else {
                        self.adScrollview.contentOffset = CGPointMake(self.adScrollview.contentOffset.x + self.adScrollview.frame.size.width, 0 );
                        
                    }
                } completion:^(BOOL finished) {
                    
                }];
                
            });
            //            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page1 = 0;
    if (self.circle) {
        int page = scrollView.contentOffset.x/scrollView.frame.size.width;
        if (page==self.images.count+1) {
            page=0;
        }else{
            page-=1;
        }
        self.adPageControl.currentPage = page;
        
        if(scrollView.contentOffset.x==0)
        {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width *self.images.count, 0);
        }else if (scrollView.contentOffset.x == scrollView.frame.size.width *(self.images.count+1)){
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width *1, 0);

        }
        page1 = page;
        
    }else {
        int page = scrollView.contentOffset.x/scrollView.frame.size.width;
        self.adPageControl.currentPage = page;

        page1 = page;

    }
    
    self.prePage = page1;
//    NSLog(@"%d",self.prePage);
    
    if (self.adScrollBlock) {
        self.adScrollBlock(self, page1);
        
    }
    
    
}
-(void)scrollToLast
{
    [self.adScrollview setContentOffset:CGPointMake(self.adScrollview.contentSize.width-self.adScrollview.frame.size.width, 0) animated:YES];
    
}
 
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(CGRectEqualToRect(self.frame, self.preRect)  ){
        return;
    }
    self.preRect = self.frame;
    
    self.noADImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.adScrollview.frame =  CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.adPageControl.frame =  CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
    
    
    NSUInteger count = self.usedImageViewArray.count;
    self.adScrollview.contentSize = CGSizeMake(count * self.frame.size.width, self.frame.size.height);

    for (NSUInteger i = 0; i < count; i++) {
        UIImageView *imageView = [self.usedImageViewArray objectAtIndex:i];
        if (imageView ) {
            if (_verticalScroll == YES) {
                imageView.frame = CGRectMake(  0, i  * self.frame.size.height/self.rowNumber ,self.frame.size.width, self.frame.size.height/self.rowNumber );
                self.adScrollview.contentSize = CGSizeMake(self.frame.size.width, (i +1 )* self.frame.size.height/self.rowNumber );
                
            }else{
                imageView.frame = CGRectMake( i  * self.frame.size.width/self.rowNumber , 0, self.frame.size.width/self.rowNumber , self.frame.size.height);
                self.adScrollview.contentSize = CGSizeMake((i +1 )* self.frame.size.width/self.rowNumber , self.frame.size.height);
                
            }
        }
//        NSLog(@"%@",imageView);

    }
//    NSLog(@"SELF %@",self);
//    NSLog(@"SELF.adScrollview %@",self.adScrollview);
//
//    NSLog(@"%d",self.prePage);
    
//    if (self.circle) {
//        [self.adScrollview setContentOffset:CGPointMake((self.prePage +1) * self.frame.size.width/self.rowNumber, 0) animated:YES];
//
//    }
//    else{
//        [self.adScrollview setContentOffset:CGPointMake(self.prePage  * self.frame.size.width/self.rowNumber, 0) animated:YES];
//
//    }
}
@end
