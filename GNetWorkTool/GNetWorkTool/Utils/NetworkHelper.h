//
//  NetworkHelper.h
//  GNetWorkTool
//
//  Created by Leopard on 2021/1/15.
//  Copyright © 2021 Lepard. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkHelper : NSObject
//初始化单例
+ (id)shareInstance;

//封装常用的网络请求
/**
 *  向服务器发送get请求
 *
 *  @param url     请求的接口
 *  @param parameter 向服务器请求数据时候的参数
 *  @param success 请求成功结果,block的参数为服务器返回的数据
 *  @param failure 请求失败,block的参数是错误的信息
 */
- (void)Get:(NSString *)url
  parameter:(NSDictionary *)parameter
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure;

/**
 *  向服务器post数据
 *
 *  @param url       要提交数据额结构
 *  @param parameter 要提交的数据
 *  @param success   成功执行的block,block的参数为服务器返回的内容
 *  @param failure   失败执行的block,block的参数为错误信息
 */
- (void)Post:(NSString *)url
   parameter:(NSDictionary *)parameter
     success:(void(^)(id responseObject))success
     failure:(void(^)(NSError *error))failure;

/**
 *  向服务器上传文件
 *
 *  @param url       要上传文件的接口
 *  @param parameter 上传的参数
 *  @param fileData  上传的文件数据
 *  @param name      服务所对应的字段
 *  @param fileName  上传到服务器的文件名
 *  @param mimeType  上传文件类型
 *  @param success   成功执行的block,block的参数为服务器返回的内容
 *  @param failure   失败执行的block,block的参数为错误信息
 */
- (void)Post:(NSString *)url
   parameter:(NSDictionary *)parameter
        data:(NSData *)fileData
        name:(NSString *)name
    fileName:(NSString *)fileName
    mimeType:(NSString *)mimeType
     success:(void(^)(id responseObject))success
     failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
