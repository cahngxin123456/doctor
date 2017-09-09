//
//  IWHttpTool.h
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//  封装项目中得GET\POST请求

#import <Foundation/Foundation.h>
@class IWFormData;

@interface IWHttpTool : NSObject

+ (void)updateImageWithURL:(NSString *)url params:(NSDictionary *)params datas:(NSArray *)datas name:(NSString *)name success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData  文件参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(IWFormData *)formData success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+ (void)updateImageWithUrl:(NSString *)url params:(NSDictionary *)params path:(NSString *)path success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end

/**
 *  用来封装文件数据的模型
 */
@interface IWFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end

