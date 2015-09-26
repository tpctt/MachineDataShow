//
//  Statuecell.m
//  MachineDataShow
//
//  Created by tim on 15-9-5.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import "Statuecell.h"

@implementation Statuecell
-(void)setOBJ:(CLJ_deveice_state_Obj*)OBJ1
{
    if (OBJ1) {
        NSString *State = [OBJ1.State lowercaseString];
        if([State isEqualToString:@"ok"]){
            [self.state setBackgroundColor:[UIColor greenColor]];
        }else  if([State isEqualToString:@"alarm"]){
            [self.state setBackgroundColor:[UIColor yellowColor]];
        }else  if([State isEqualToString:@"stop"]){
            [self.state setBackgroundColor:[UIColor redColor]];
        }
        
        
        self.name .text = OBJ1.StateClass;
        self.sourece .text = OBJ1.PartName;
        self.deal .text = OBJ1.Note;
        
        
    }
}
- (void)awakeFromNib {
    // Initialization code
    self.state.layer.cornerRadius = self.state.frame.size.height/2;
    self.state.layer.borderWidth = 1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
