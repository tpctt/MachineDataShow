//
//  AddMediaBaseView.h
//  MachineDataShow
//
//  Created by 中联信 on 15/8/25.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddMediaBaseView : UIView

@property (assign,nonatomic) SEL addSelecter;
@property (strong,nonatomic) id tagert;
@property (assign,nonatomic) BOOL isShow;
@property (assign,nonatomic) int maxNumber;
@property (strong,nonatomic) NSMutableArray *resoureArray;

-(void)addNewResoure:(id)resoure;


@end
