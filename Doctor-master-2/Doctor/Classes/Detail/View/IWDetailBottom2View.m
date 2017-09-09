//
//  IWDetailBottom2View.m
//  Conedot
//
//  Created by 范超 on 14/12/19.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWDetailBottom2View.h"
#import "IWDetailExtendInfo.h"

@interface IWDetailBottom2View()
- (IBAction)apply:(UIButton *)sender;
- (IBAction)known:(UIButton *)sender;
- (IBAction)signup:(UIButton *)sender;
- (IBAction)comment:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonApply;
@property (weak, nonatomic) IBOutlet UIButton *buttonKnown;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignup;
@property (weak, nonatomic) IBOutlet UIButton *buttonComment;

@end

@implementation IWDetailBottom2View

+ (instancetype)detailBottom2View {
    return [[[NSBundle mainBundle] loadNibNamed:@"IWDetailBottom2View" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [self.buttonApply setTitle:NSLocalizedString(@"apply", nil) forState:UIControlStateNormal];
    [self.buttonKnown setTitle:NSLocalizedString(@"noted", nil) forState:UIControlStateNormal];
    [self.buttonSignup setTitle:NSLocalizedString(@"likes", nil) forState:UIControlStateNormal];
    [self.buttonComment setTitle:NSLocalizedString(@"comment", nil) forState:UIControlStateNormal];
}

- (IBAction)apply:(UIButton *)sender {
    if (self.buttonApply.selected) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(apply2:)]) {
        [self.delegate apply2:self.buttonApply];
    }
}

- (IBAction)known:(UIButton *)sender {
    if (self.buttonKnown.selected) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(known2:)]) {
        [self.delegate known2:self.buttonKnown];
    }
}

- (IBAction)signup:(UIButton *)sender {
    if (self.buttonSignup.selected) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(signup2:)]) {
        [self.delegate signup2:self.buttonSignup];
    }
}

- (IBAction)comment:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(comment2:)]) {
        [self.delegate comment2:self.buttonComment];
    }
}

- (void)setStatus:(IWDetailExtendInfo *)extendInfo {
    self.buttonApply.selected = (extendInfo.applyFlag == 1);
    self.buttonKnown.selected = (extendInfo.knownFlag == 1);
    self.buttonSignup.selected = (extendInfo.praizeFlag == 1);
    self.buttonComment.selected = (![extendInfo.review isEqualToString:@""]);
}

@end
