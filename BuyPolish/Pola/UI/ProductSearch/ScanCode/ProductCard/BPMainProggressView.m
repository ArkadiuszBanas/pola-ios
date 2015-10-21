//
// Created by Paweł on 21/10/15.
// Copyright (c) 2015 PJMS. All rights reserved.
//

#import "BPMainProggressView.h"
#import "UIColor+BPAdditions.h"


const int MAIN_PROGRESS_HEIGHT = 25;
const int MAIN_PROGRESS_TITLE_MARGIN = 10;


@interface BPMainProggressView ()
@property(nonatomic, readonly) UIView *filledProgressView;
@property(nonatomic, readonly) UILabel *percentLabel;
@end

@implementation BPMainProggressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];

        _filledProgressView = [[UIView alloc] initWithFrame:CGRectZero];
        _filledProgressView.backgroundColor = [UIColor colorWithHexString:@"D93A2F"];
        [self addSubview:_filledProgressView];

        _percentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _percentLabel.textColor = [UIColor whiteColor];
        [self addSubview:_percentLabel];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect rect = CGRectZero;
    rect.origin = CGPointMake(0, 0);
    rect.size = CGSizeMake(CGRectGetWidth(self.bounds) * self.progress, CGRectGetHeight(self.bounds));
    self.filledProgressView.frame = rect;

    rect = self.percentLabel.frame;
    rect.origin.x = CGRectGetWidth(self.bounds) - MAIN_PROGRESS_TITLE_MARGIN - CGRectGetWidth(self.percentLabel.frame);
    rect.origin.y = CGRectGetHeight(self.bounds) / 2 - CGRectGetHeight(self.percentLabel.bounds) / 2;
    self.percentLabel.frame = rect;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;

    int progressInt = (int) (progress * 100);
    self.percentLabel.text = [NSString stringWithFormat:@"%i%%", progressInt];
    [self.percentLabel sizeToFit];

    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (CGSize)sizeThatFits:(CGSize)size {
    size.height = MAIN_PROGRESS_HEIGHT;
    return size;
}

@end