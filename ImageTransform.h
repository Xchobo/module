//
//  ImageTransform.h
//  MoveImage
//
//  Created by Xchobo on 2014/3/18.
//  Copyright (c) 2014年 Xchobo. All rights reserved.
//

#import <UIKit/UIKit.h>
//#include <math.h>
//#import <QuartzCore/QuartzCore.h>

@interface ImageTransform : UIView{
    CGSize _originalImageViewSize; 
}

@property (nonatomic, retain) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;


- (void)imgAction;
- (void)reset;

@end
