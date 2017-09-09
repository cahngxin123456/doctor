//
//  IWMedicalHealth.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import <Foundation/Foundation.h>
#import "IWUserHealthInfo.h"
#import "IWShengYu.h"
#import "IWYanJiu.h"
#import "IWGuoMin.h"
#import "IWJiBing.h"
#import "IWYiChuan.h"
#import "IWCanJi.h"
#import "IWBaoLu.h"
#import "IWJiaZu.h"

@interface IWMedicalHealth : NSObject

@property (nonatomic, strong) IWUserHealthInfo *userHealthInfo;
@property (nonatomic, strong) NSArray *shengyu;
@property (nonatomic, strong) IWYanJiu *yanjiu;
@property (nonatomic, strong) IWGuoMin *guomin;
@property (nonatomic, strong) NSArray *jibing;
@property (nonatomic, strong) NSArray *shoushu;
@property (nonatomic, strong) NSArray *shuxue;

@property (nonatomic, strong) IWYiChuan *yichuan;
@property (nonatomic, strong) IWCanJi *canji;
@property (nonatomic, strong) IWBaoLu *baolu;

@property (nonatomic, strong) NSArray *jiazuGrandPaAndMa;
@property (nonatomic, strong) NSArray *jiazuFather;
@property (nonatomic, strong) NSArray *jiazuMother;
@property (nonatomic, strong) NSArray *jiazuBroAndSis;

@end
