//
//  IWHttpTool.m
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWHttpTool.h"
#import "AFNetworking.h"

@implementation IWHttpTool

+ (void)updateImageWithURL:(NSString *)url params:(NSDictionary *)params datas:(NSArray *)datas name:(NSString *)name success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i < datas.count; i++) {
            NSData *data = datas[i];
            if ([@"attachment" isEqualToString:name]) {
                NSString *newName = name;
                if (i == 0) {
                    newName = [NSString stringWithFormat:@"%@", name];
                } else {
                    newName = [NSString stringWithFormat:@"%@%d", name, i + 1];
                }
                [formData appendPartWithFileData:data name:newName fileName:[NSString stringWithFormat:@"%@.jpg",name] mimeType:@"image/jpeg"];
            } else {
                NSString *newName = name;
                NSRange range = [name rangeOfString:@"photo"];
                if (range.length == 0) {
                    newName = [NSString stringWithFormat:@"%@%d", name, i + 1];
                }
                [formData appendPartWithFileData:data name:newName fileName:[NSString stringWithFormat:@"%@.jpg",name] mimeType:@"image/jpeg"];
            }
        }
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            if (success) {
                success(responseObject);
            }
        } else {
            if (failure) {
                failure(error);
            }
        }
    }];
    
    [uploadTask resume];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2. 设置接受JSON格式
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [mgr.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    // 3.发送请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              success(responseObject);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(IWFormData *)formData success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

+ (void)updateImageWithUrl:(NSString *)url params:(NSDictionary *)params path:(NSString *)path success:(void (^)(id))success failure:(void (^)(NSError *))failure  {
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"uploadImage" fileName:[path lastPathComponent] mimeType:@"application/octet-stream" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (!error) {
            if (success) {
                success(responseObject);
            }
        } else {
            if (failure) {
                failure(error);
            }
        }
    }];
    
    [uploadTask resume];
}


@end

/**
 *  用来封装文件数据的模型
 */
@implementation IWFormData

@end

