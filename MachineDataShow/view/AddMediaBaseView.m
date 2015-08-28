//
//  AddMediaBaseView.m
//  MachineDataShow
//
//  Created by 中联信 on 15/8/25.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "AddMediaBaseView.h"

static CGFloat delt = 10;
static NSArray *audio = nil;

@protocol ButtonWithDelDelegate <NSObject>
-(void)tapDelFor:(NSInteger)index;

@end
@interface ButtonWithDel:UIView
@property (strong,nonatomic) UIButton *btn;
@property (strong,nonatomic) UIButton *delBtn;
@property (assign,nonatomic) NSInteger index;

@property (strong,nonatomic) id  resoure;
@property (assign,nonatomic) id<ButtonWithDelDelegate> delegate;
+(BOOL)isAudio:(NSString*)path;

@end

@implementation ButtonWithDel
+(BOOL)isAudio:(NSString*)path
{
    if (audio == nil) {
        audio = @[@"acc",@"mp3"];
    }
    NSString *type = [path lastPathComponent];
    for (NSString *string in  audio) {
        if ([string isEqualToString:type]) {
            return YES;
        }
    }
    
    return NO;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(void)commonInit
{
    self.btn = [[UIButton alloc]initWithFrame:[self getBtnRect]];
    self.delBtn = [[UIButton alloc]initWithFrame:[self getDelBtnRect]];
    
    [self addSubview:self.btn];
    [self addSubview:self.delBtn];
    
    [self.btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.delBtn addTarget:self action:@selector(delbtnAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.delBtn setTitle:@"x" forState:0];
    [self.delBtn setTitleColor:[UIColor redColor] forState:0];
    
    
}
-(void)setResoure:(id)resoure
{
    if (_resoure != resoure) {
        _resoure = resoure;
        
        UIButton *btn = self.btn;
        if([resoure isKindOfClass:[UIImage class]]){
            [btn setImage:(UIImage*)resoure forState:0];
            
        }else if([resoure isKindOfClass:[NSString class]]){
            NSString *path = (NSString *)resoure;
            
            [btn setTitle:path forState:0];
            
        }
        
    }
    
}
-(void)btnAct:(UIButton*)sender
{
    UIButton *btn = self.btn;
    if([_resoure isKindOfClass:[UIImage class]]){
 
    }else if([_resoure isKindOfClass:[NSString class]]){
        NSString *path = (NSString *)_resoure;
        
        
    }
}
-(void)delbtnAct:(UIButton*)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tapDelFor:)])
    {
        [self.delegate tapDelFor:_index ];
    }
}

-(CGRect)getBtnRect
{
    CGFloat h = self.frame.size.height - 2* delt;
    return CGRectMake(delt, delt, h, h);
    return CGRectZero;
}
-(CGRect)getDelBtnRect
{
    CGFloat h = self.frame.size.height - 2* delt;
    return CGRectMake(h, 0, 2*delt, 2*delt);
    return CGRectZero;
}
@end

@interface AddMediaBaseView ()<ButtonWithDelDelegate>

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) NSMutableArray *subBtnArray;
@property (strong,nonatomic) NSMutableArray *resoureArray;

@property (strong,nonatomic) UIButton *addBtn;


@end
@implementation AddMediaBaseView

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
    CGFloat x = (index*2 +1 ) * delt + index * rect.size.width;
    
    return CGRectMake(x, delt, h, h);
    return CGRectZero;
}
-(CGRect)getBtnRectForButtonWithDelAt:(NSInteger)index
{
    CGFloat w = self.frame.size.height;
    return CGRectMake(index * w, 0, w, w );
    
//    CGRect rect = [self getBtnRect];
//    CGFloat h = rect.size.height;
//    CGFloat x = (index +1 ) * delt + index * rect.size.width;
//    
//    return CGRectMake(x-delt, 0, h+delt, h+delt);
//    return CGRectZero;
}

-(UIButton*)addBtnAt:(NSInteger)Index
{
    UIButton* btn = [[UIButton alloc]initWithFrame:[self getBtnRectAt:Index]];
    
    
    return btn;
}


///添加一个资源在后面
-(void)addNewResoure:(id)resoure
{
    if(resoure==nil)return;
    
    ButtonWithDel *view = [[ButtonWithDel alloc]initWithFrame:[self getBtnRectForButtonWithDelAt:self.subBtnArray.count]];
    [view setResoure:resoure];
    view.delegate = self;
    
    
    [self.scrollView addSubview:view];
    
    [self.subBtnArray addObject:view];
    [self.resoureArray addObject:resoure];
    
    self.addBtn.frame = [self getBtnRectAt:self.subBtnArray.count];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.addBtn.frame), self.scrollView.frame.size.height);
    
    
}
///删除一个i
-(void)tapDelFor:(NSInteger)index
{
    ButtonWithDel *view  = self.subBtnArray[index];
    [view removeFromSuperview];
    
    [self.subBtnArray removeObjectAtIndex:index];
    [self.resoureArray removeObjectAtIndex:index];
    
    for(NSInteger i = 0; i<self.subBtnArray.count; i++)
    {
        ///重新布局
        ButtonWithDel *view  = self.subBtnArray[i];
        view.frame = [self getBtnRectForButtonWithDelAt:i];
        
    }
    ///重新布局
    self.addBtn.frame = [self getBtnRectAt:self.subBtnArray.count];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.addBtn.frame), self.scrollView.frame.size.height);

}

-(void)commonInit
{
    if (self.scrollView)return;
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    
    self.subBtnArray = [NSMutableArray array];
    self.resoureArray = [NSMutableArray array];
    
    self.addBtn = [self addBtnAt:0  ];
    [self.addBtn addTarget:self action:self.addSelecter forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setTitle:@"+" forState:0];
    [self.addBtn setTitleColor:[UIColor blackColor] forState:0];
    self.addBtn.layer.borderColor = [[UIColor grayColor]CGColor];
    self.addBtn.layer.borderWidth = 0.5;
    
    [self.scrollView addSubview:self.addBtn];
    
}
-(void)setAddSelecter:(SEL)addSelecter
{
    if (_addSelecter == addSelecter) {
        
    }else{
        
        [self.addBtn removeTarget:_tagert action:_addSelecter forControlEvents:UIControlEventTouchUpInside];
        _addSelecter = addSelecter;
        [self.addBtn addTarget:_tagert action:self.addSelecter forControlEvents:UIControlEventTouchUpInside];
        
    }
}
-(void)setTagert:(id)tagert
{
    if (_tagert == tagert) {
        
    }else{
        
        [self.addBtn removeTarget:_tagert action:_addSelecter forControlEvents:UIControlEventTouchUpInside];
        _tagert = tagert;
        [self.addBtn addTarget:_tagert action:_addSelecter forControlEvents:UIControlEventTouchUpInside];
        
    }
}


///init
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        [self commonInit];

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
