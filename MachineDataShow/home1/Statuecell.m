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
//            [self.state setBackgroundColor:[UIColor greenColor]];
            [self.state setImage:[UIImage imageNamed:@"image_button_default"] forState:0];
        }else  if([State isEqualToString:@"alarm"]){
//            [self.state setBackgroundColor:[UIColor yellowColor]];
            [self.state setImage:[UIImage imageNamed:@"image_button_disabled"] forState:0];

        }else  if([State isEqualToString:@"stop"]){
//            [self.state setBackgroundColor:[UIColor redColor]];
            [self.state setImage:[UIImage imageNamed:@"image_button_pressed"] forState:0];

        }
        
        
        self.name .text = OBJ1.StateClass;
        if ([OBJ1.StateClass isEqualToString:@"0"]) {
            self.name .text = @"安全";
        }else  if ([OBJ1.StateClass isEqualToString:@"1"]) {
            self.name .text = @"报警";
        }else  if ([OBJ1.StateClass isEqualToString:@"2"]) {
            self.name .text = @"配件";
        }
        self.sourece .text = OBJ1.PartName;
        self.deal .text = OBJ1.Note;
        
//        self.state.layer.cornerRadius = self.state.frame.size.height/2;
//        self.state.layer.borderWidth = 1;
        [self.state setTitle:@"" forState:0];
        
    }
}
- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
