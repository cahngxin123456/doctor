//
//  IWTextField.m
//  Conedot
//
//  Created by 范超 on 14-10-16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWTextField.h"

@implementation IWTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 5, 0);
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds,5,0);
}


-(void)drawRect:(CGRect)rect
{
    UIImage *backgroundImage = [UIImage resizedImageWithName:@"input_textField"];
    
    [backgroundImage drawInRect:[self bounds]];
}

@end
