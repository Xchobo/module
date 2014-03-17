//
//  ImageTransform.m
//  MoveImage
//
//  Created by Xchobo on 2014/3/18.
//  Copyright (c) 2014年 Xchobo. All rights reserved.
//

#import "ImageTransform.h"

// 設定 Transform 的基本參數初始值
float lastTransX = 0.0, lastTransY = 0.0;
float lastScale = 1.0;
float lastRotation = 0.0;

@implementation ImageTransform

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//接收圖片開始進行手勢設定
- (void)imgAction{
    // 設定圖框
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    [_imageView setUserInteractionEnabled:YES];
    [self addSubview:_imageView];
    
    // 移動
    UIPanGestureRecognizer *moveGes = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(moveImage:)];
    [moveGes setMinimumNumberOfTouches:1];
    [moveGes setMaximumNumberOfTouches:1];
    [_imageView addGestureRecognizer:moveGes];
    
    // 旋轉
    UIRotationGestureRecognizer *rotateGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(rotateImage:)];
    [_imageView addGestureRecognizer:rotateGes];
    
    // 縮放
    UIPinchGestureRecognizer *scaleGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(scaleImage:)];
    [_imageView addGestureRecognizer:scaleGes];
}

// 取得圖片
- (void)setImage:(UIImage *)img{
    if (_image != img) {
        _image = img;
    }
    
    float imageScale = self.frame.size.width / img.size.width;
    self.imageView.frame = CGRectMake(0, 0, img.size.width * imageScale, img.size.height * imageScale);
    _originalImageViewSize = CGSizeMake(img.size.width * imageScale, img.size.height * imageScale);
    _imageView.image = img;
    _imageView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
}

// 移動手勢的事件
- (void)moveImage:(UIPanGestureRecognizer *)sender{
    CGPoint translatedPoint = [sender translationInView:self];
    
    if([sender state] == UIGestureRecognizerStateBegan) {
        lastTransX = 0.0;
        lastTransY = 0.0;
    }
    
    CGAffineTransform trans = CGAffineTransformMakeTranslation(translatedPoint.x - lastTransX, translatedPoint.y - lastTransY);
    CGAffineTransform newTransform = CGAffineTransformConcat(_imageView.transform, trans);
    lastTransX = translatedPoint.x;
    lastTransY = translatedPoint.y;
    
    _imageView.transform = newTransform;
}

// 旋轉手勢的事件
- (void)rotateImage:(UIRotationGestureRecognizer *)sender{
    if([sender state] == UIGestureRecognizerStateEnded) {
        lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = - (lastRotation) + [sender rotation];
    
    CGAffineTransform currentTransform = _imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    [_imageView setTransform:newTransform];
    
    lastRotation = [sender rotation];
    
}

// 縮放手勢的事件
- (void)scaleImage:(UIPinchGestureRecognizer *)sender{
    if([sender state] == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = [sender scale]/lastScale;
    
    CGAffineTransform currentTransform = _imageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [_imageView setTransform:newTransform];
    
    lastScale = [sender scale];
}

//重設
- (void)reset{
    self.imageView.transform = CGAffineTransformIdentity;
}

@end
