//
//  IWMedicalReport.m
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWMedicalReport.h"
#import "MJExtension.h"
#import "IWPhoto.h"

@implementation IWMedicalReport
/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (void)setPicture:(NSString *)picture {
    _picture = picture;
    
    _pictures = [_picture componentsSeparatedByString:@","];
}

- (NSMutableArray *)urlsWithEdit:(BOOL)edit {
    NSArray *arrs = [_picture componentsSeparatedByString:@","];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *url in arrs) {
        if ([url isEqualToString:@""]) {
            continue;
        }
        IWPhoto *photo = [[IWPhoto alloc] init];
        photo.pic = url;
        photo.showDelete = edit;
        [tempArray addObject:photo];
    }
    
    return tempArray;
}


@end
