//
//  ImageWall.h
//  ImageWall
//
//  Created by 中联信 on 15/6/17.
//  Copyright (c) 2015年 Tim.rabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ImageWall.
FOUNDATION_EXPORT double ImageWallVersionNumber;

//! Project version string for ImageWall.
FOUNDATION_EXPORT const unsigned char ImageWallVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ImageWall/PublicHeader.h>


#import "ScrollADView.h"

@interface ImageWall : UIView
@property (strong,nonatomic) NSArray *imageArray;
@property (   nonatomic,copy) SelectADBlock adBlock;
-(void)resetViewPoi;

@end
