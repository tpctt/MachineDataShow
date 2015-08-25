//
//  AddMediaBaseView.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/25.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "AddMediaBaseView.h"
@interface AddMediaBaseView ()

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) NSMutableArray *subBtnArray;
@property (strong,nonatomic) NSMutableArray *resoureArray;

@property (strong,nonatomic) UIButton *addBtn;


@end
@implementation AddMediaBaseView

static CGFloat delt = 5;
-(CGRect)getBtnRect
{
    CGFloat h = self.frame.size.height - 2* delt;
    return CGRectMake(delt, delt, h, h);
    return CGRectZero;
}

///start 0
-(CGRect)getBtnRectAt:(NSInteger)index
{
    CGRect rect = [self getBtnRect];
    CGFloat h = rect.size.height;
    CGFloat x = (index +1 ) * delt + index * rect.size.width;
    
    return CGRectMake(x, delt, h, h);
    return CGRectZero;
}
-(UIButton*)addBtnAt:(NSInteger)Index
{
    UIButton* btn = [[UIButton alloc]initWithFrame:[self getBtnRectAt:Index]];
    
    
    return btn;
}

-(void)addNewResoure:(id)resoure
{
    UIButton *btn = [self addBtnAt:self.subBtnArray.count];
    if([resoure isKindOfClass:[UIImage class]]){
        [btn setImage:(UIImage*)resoure forState:0];
    }else if([resoure isKindOfClass:[NSString class]]){
        NSString *path = (NSString *)resoure;
        
        [btn setTitle:path forState:0];
        
    }
    
    
    
    
    
    
    [self.scrollView addSubview:btn];
    
    [self.subBtnArray addObject:btn];
    [self.resoureArray addObject:resoure];
    
    self.addBtn.frame = [self getBtnRectAt:self.subBtnArray.count];
    
}

-(void)commonInit
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    
    self.subBtnArray = [NSMutableArray array];
    self.resoureArray = [NSMutableArray array];
    
    self.addBtn = [self addBtnAt:0  ];
    [self.addBtn addTarget:self action:self.addSelecter forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setTitle:@"add" forState:0];
    
    
    [self.scrollView addSubview:self.addBtn];
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
