//
//  IWMedicalArchivesTool.m
//  Doctor
//
//  Created by 范超 on 16/12/18.
//
//

#import "IWMedicalArchivesTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWMedicalArchivesTool

// 保存疾病
+ (void)addMedicalOld1WithParam:(IWAddOld1Param *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_JIBING_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 保存手术
+ (void)addMedicalOld2WithParam:(IWAddOld2Param *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_SHOUSHU_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 保存输血
+ (void)addMedicalOld3WithParam:(IWAddOld3Param *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_SHUXUE_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 保存家族
+ (void)addMedicalJiaZuWithParam:(IWAddJiaZuParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_JIAZU_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 保存遗传
+ (void)addMedicalYiChuanWithParam:(IWAddYiChuanParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_YICHUAN_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 保存残疾
+ (void)addMedicalCanjiWithParam:(IWAddCanjiParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_CANJI_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 保存锻炼
+ (void)addMedicalDuanLianWithParam:(IWAddDuanLianParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_DUANLIAN_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addMedicalBaoLuWithParam:(IWAddBaoLuParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_BAOLU_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addMedicalYanJiuWithParam:(IWAddYanJiuParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_YANJIU_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)addMedicalGuoMinWithParam:(IWAddGuoMinParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_GUOMIN_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addMedicalShengYuWithParam:(IWAddShengYuParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_SHENGYU_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addMedicalBloodWithParam:(IWAddBloodparam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_BLOOD_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addMedicalHeightWithParam:(IWAddHeightParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_HEIGHT_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addMedicalWeightWithParam:(IWAddWeightParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_WEIGHT_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)medicalHealthDetailWithParam:(IWGetMedicalHealthDetailParam *)param success:(void (^)(IWGetMedicalHealthDetailResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_HEALTH_GET_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWGetMedicalHealthDetailResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWGetMedicalHealthDetailResult objectWithKeyValues:json];
            } else {
                result = [[IWGetMedicalHealthDetailResult alloc] init];
                result.code = [json[@"code"] intValue];
                result.info = json[@"info"];
            }
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)medicalReportListWithParam:(IWGetMedicalReportListParam *)param success:(void (^)(IWGetMedicalReportListResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_DISEASE_REPORT_LIST_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWGetMedicalReportListResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWGetMedicalReportListResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWGetMedicalReportListResult alloc] init];
                result.code = [json[@"code"] intValue];
                result.info = json[@"info"];
            }
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)medicalReportDetailWithParam:(IWGetMedicalReportDetailParam *)param success:(void (^)(IWGetMedicalReportDetailResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_DISEASE_REPORT_DETAIL_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWGetMedicalReportDetailResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWGetMedicalReportDetailResult objectWithKeyValues:json];
            } else {
                result = [[IWGetMedicalReportDetailResult alloc] init];
                result.code = [json[@"code"] intValue];
                result.info = json[@"info"];
            }
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)submitUserInfoWithParams:(IWAddUserInfoParam *)param isMember:(BOOL)isMember datas:(NSData *)data success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    NSMutableArray *datas = [NSMutableArray array];
    if (data != nil) {
        [datas addObject:data];
    }
    [IWHttpTool updateImageWithURL:isMember ? SERVER_DO_SUBMIT_MEMBER_INFO_URL : SERVER_DO_CHANGE_INFO_URL  params:param.keyValues datas:datas name:@"photo" success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)deleteMedicalMemberWithParam:(IWDeleteInquiryMemberParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_DO_DELETE_MEMBER_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)deleteMedicalReportWithParam:(IWDeleteMedicalReportParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_DO_DELETE_DISEASE_REPORT_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)deletePressureDetailWithParam:(IWDeletePressureDetailParam *)param success:(void (^)(IWBaseResult *))success failure:(void (^)(NSError *))failure{
    
    [IWHttpTool postWithURL:SERVER_DO_DELETE_BLOOD_PRESSURE_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

//删除血糖详情
+ (void)deleteSugerDetailWithParam:(IWDeleteSugerDetailModel *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure{
    [IWHttpTool postWithURL:SERVER_DO_DELETE_BLOOD_SUGAR_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)submitReportWithParams:(IWAddReportParam *)param datas:(NSArray *)datas success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool updateImageWithURL:SERVER_SUBMIT_DISEASE_REPORT_URL params:param.keyValues datas:datas name:@"uploadImage" success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addMedicalPressureWithParam:(IWAddMedicalPressureParam *)param success:(void (^)(IWAddMedicalPressureResult *result))success failure:(void (^)(NSError *error))failure; {
    [IWHttpTool postWithURL:SERVER_SUBMIT_BLOODPRESSURE_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWAddMedicalPressureResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWAddMedicalPressureResult objectWithKeyValues:json];
            } else {
                result = [[IWAddMedicalPressureResult alloc] init];
                result.code = [json[@"code"] intValue];
                result.info = json[@"info"];
            }
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)addMedicalSugerWithParam:(IWAddMedicalSugarParam *)param success:(void (^)(IWAddMedicalSugarResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_SUBMIT_BLOODSUGAR_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWAddMedicalSugarResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWAddMedicalSugarResult objectWithKeyValues:json];
            } else {
                result = [[IWAddMedicalSugarResult alloc] init];
                result.code = [json[@"code"] intValue];
                result.info = json[@"info"];
            }
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getMedicalSugarListListWithParam:(IWGetMedicalSugarListParam *)param success:(void (^)(IWGetMedicalSugarListResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_BLOOD_SUGAR_LIST_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWGetMedicalSugarListResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWGetMedicalSugarListResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWGetMedicalSugarListResult alloc] init];
                result.code = [json[@"code"] intValue];
                result.info = json[@"info"];
            }
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
