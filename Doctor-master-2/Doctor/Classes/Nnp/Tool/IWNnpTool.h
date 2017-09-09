//
//  IWNnpTool.h
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import <Foundation/Foundation.h>
#import "IWNppParam.h"
#import "IWNppResult.h"

@interface IWNnpTool : NSObject
/**
 *  加载混合列表数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)nnpWithParam:(IWNppParam *)param success:(void (^)(IWNppResult *result))success failure:(void (^)(NSError *error))failure;
@end
