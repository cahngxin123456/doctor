//
//  IWDetailBottom3View.m
//  Conedot
//
//  Created by 范超 on 16/4/9.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWDetailBottom3View.h"
#import "IWDetailExtendInfo.h"

@interface IWDetailBottom3View()

@property (weak, nonatomic) IBOutlet UIButton *buttonKnown;
- (IBAction)known:(UIButton *)sender;

@end

@implementation IWDetailBottom3View

+ (instancetype)detailBottom3View {
    return [[[NSBundle mainBundle] loadNibNamed:@"IWDetailBottom3View" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [self.buttonKnown setTitle:NSLocalizedString(@"noted", nil) forState:UIControlStateNormal];
}


- (void)setStatus:(IWDetailExtendInfo *)extendInfo {
    self.buttonKnown.selected = (extendInfo.learnStatus == 1);
}


- (IBAction)known:(UIButton *)sender {
    if (self.buttonKnown.selected) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(known3:)]) {
        [self.delegate known3:self.buttonKnown];
    }
}
@end
