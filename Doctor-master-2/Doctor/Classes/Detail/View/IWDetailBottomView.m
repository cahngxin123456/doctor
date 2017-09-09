//
//  IWDetailBottomView.m
//  Conedot
//
//  Created by 范超 on 14/12/13.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWDetailBottomView.h"
#import "IWDetailExtendInfo.h"

@interface IWDetailBottomView()
- (IBAction)known:(UIButton *)button;
- (IBAction)signup:(UIButton *)button;
- (IBAction)comment:(UIButton *)button;
@property (weak, nonatomic) IBOutlet UIButton *buttonKnown;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignup;
@property (weak, nonatomic) IBOutlet UIButton *buttonComment;


@end

@implementation IWDetailBottomView

- (void)awakeFromNib {
    [self.buttonKnown setTitle:NSLocalizedString(@"noted", nil) forState:UIControlStateNormal];
    [self.buttonSignup setTitle:NSLocalizedString(@"likes", nil) forState:UIControlStateNormal];
    [self.buttonComment setTitle:NSLocalizedString(@"comment", nil) forState:UIControlStateNormal];
}

+ (instancetype)detailBottomView {
    return [[[NSBundle mainBundle] loadNibNamed:@"IWDetailBottomView" owner:nil options:nil] lastObject];
}


- (IBAction)known:(UIButton *)button {
    if (self.buttonKnown.selected) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(known:)]) {
        [self.delegate known:self.buttonKnown];
    }
}

- (IBAction)signup:(UIButton *)button {
    if (self.buttonSignup.selected) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(signup:)]) {
        [self.delegate signup:self.buttonSignup];
    }
}

- (IBAction)comment:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(comment:)]) {
        [self.delegate comment:self.buttonComment];
    }
}

- (void)setStatus:(IWDetailExtendInfo *)extendInfo {
    self.buttonKnown.selected = (extendInfo.knownFlag == 1);
    self.buttonSignup.selected = (extendInfo.praizeFlag == 1);
    self.buttonComment.selected = (![extendInfo.review isEqualToString:@""]);
}
@end
