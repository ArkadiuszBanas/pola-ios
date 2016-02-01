//
// Created by Paweł Janeczek on 01.02.2016.
// Copyright (c) 2016 PJMS. All rights reserved.
//

#import "BPAboutViewCell.h"
#import "BPTheme.h"


@implementation BPAboutViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [BPTheme clearColor];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect rect = self.contentView.frame;
    rect.origin = CGPointMake(10, 10);
    rect.size = CGSizeMake(CGRectGetWidth(rect) - 20, CGRectGetHeight(rect) - 20);
    self.contentView.frame = rect;
}


@end