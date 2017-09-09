//
//  IWMedicalReport.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import <Foundation/Foundation.h>

@interface IWMedicalReport : NSObject

@property (nonatomic, copy) NSString *ID; // 主键

@property (nonatomic, copy) NSString *reportId; // 主键
@property (nonatomic, copy) NSString *reportType; // 报告类型
@property (nonatomic, copy) NSString *reportType2show; // 报告类型展示
@property (nonatomic, copy) NSString *reportDate; // 报告日期
@property (nonatomic, copy) NSString *hospital; // 医疗机构
@property (nonatomic, copy) NSString *disease; // 疾病名称
@property (nonatomic, copy) NSString *overview; // 备注概述
@property (nonatomic, copy) NSString *remark; // 问题描述
@property (nonatomic, copy) NSString *pictureThumb; // 图片缩略图
@property (nonatomic, copy) NSString *picture; // 图片
@property (nonatomic, copy) NSString *insertTime; // 提交时间
@property (nonatomic, copy) NSString *usingStatus2show; // 状态显示名
@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, assign) BOOL isShowDetail;


@property (nonatomic, strong) NSArray *pictures;

- (NSMutableArray *)urlsWithEdit:(BOOL)edit;
@end
