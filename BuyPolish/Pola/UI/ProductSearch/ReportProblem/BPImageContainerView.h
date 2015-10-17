//
// Created by Paweł on 17/10/15.
// Copyright (c) 2015 PJMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPImageContainerView;

@protocol BPImageContainerViewDelegate <NSObject>
- (void)didTapAddImage:(BPImageContainerView *)imageContainerView;

- (void)didTapRemoveImage:(BPImageContainerView *)imageContainerView atIndex:(int)index;
@end

@interface BPImageContainerView : UIView

@property(nonatomic, weak) id <BPImageContainerViewDelegate> delegate;

- (void)addImage:(UIImage *)image;

- (void)removeImageAtIndex:(int)index;

@end