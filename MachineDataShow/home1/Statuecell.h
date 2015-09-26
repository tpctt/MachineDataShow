//
//  Statuecell.h
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//
#import "GCYSSB_Object.h"
#import <UIKit/UIKit.h>

@interface Statuecell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *state;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sourece;

@property (weak, nonatomic) IBOutlet UILabel *deal;
-(void)setOBJ:(CLJ_deveice_state_Obj*)OBJ1;

@end
