//
//  NetworkHelper.m
//  GNetWorkTool
//
//  Created by Leopard on 2021/1/15.
//  Copyright © 2021 Lepard. All rights reserved.
//

#import "NetworkHelper.h"
@interface NetworkHelper ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation NetworkHelper

+ (id)shareInstance //获取网络请求单例
{
    static NetworkHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (helper == nil)
        {
            helper = [[NetworkHelper alloc] init];

            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //所以需要以NSData的方式接收,然后自行解析
            //申明返回的结果是json类型
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            //南方新媒体这边和原来公司不一样，是用JSON请求所以加上以下这段代码
            //申明请求的数据是json类型
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            
            [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
            
            manager.requestSerializer.timeoutInterval = 10.0f;
            
            [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
            
            helper.manager = manager;
        }
    });
    return helper;
}

- (void)Get:(NSString *)url
  parameter:(NSDictionary *)parameter
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure
{
    //使用AFN请求网络
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //因为服务器返回的数据不是application/json格式的数据
    //所以需要以NSData的方式接收,然后自行解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //        //通过block 将数据回传给用户
        success(result/*json的解析完成后,数据的操作交由用户自行决定*/);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //通过block,将错误信息回传给用户
        failure(error);
        
    }];
    
}

- (void)Post:(NSString *)url parameter:(NSDictionary *)parameter success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *manager = self.manager;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = 10.f;
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //所以需要以NSData的方式接收,然后自行解析
    //申明返回的结果是json类型
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //申明请求的数据是json类型
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString * str2 = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        str2 = [str2 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        str2 = [str2 stringByReplacingOccurrencesOfString:@"\r" withString:@""];

        NSDictionary * result = [NSJSONSerialization JSONObjectWithData:[str2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        
        success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);
    }];
}
- (void)Post:(NSString *)url parameter:(NSDictionary *)parameter data:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //
        success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
    
}

@end
