//
//  IWRemind.h
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import <Foundation/Foundation.h>

@interface IWRemind : NSObject

@property (nonatomic, copy) NSString *todayBloodPressure; // 今日测量血压条数
@property (nonatomic, copy) NSString *todayBloodSugar; // 今日测量血糖条数
@property (nonatomic, copy) NSString *rnewReply; // 新回复条数

@end
