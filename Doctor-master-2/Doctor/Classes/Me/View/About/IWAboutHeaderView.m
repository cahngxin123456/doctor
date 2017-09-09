//
//  IWAboutHeaderView.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWAboutHeaderView.h"

@interface IWAboutHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;


@end

@implementation IWAboutHeaderView

- (void)awakeFromNib {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *buildText = [NSString stringWithFormat:@"build %@", build];
    NSString *versionText = [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"about_version", nil),  version, buildText];
    self.versionLabel.text = versionText;
}

+ (id)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"IWAboutHeaderView" owner:nil options:nil][0];
}

@end
