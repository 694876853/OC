//
//  ViewController.m
//  GNetWorkTool
//
//  Created by Leopard on 2021/1/15.
//  Copyright © 2021 Lepard. All rights reserved.
//

#import "ViewController.h"
#import "NetworkHelper.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求示例(把参数和域名换成自己的即可)
    NetworkHelper * request = [NetworkHelper shareInstance];

    NSDictionary * parm = @{
                            @"clientid": @"JHSG7328f",
                            @"devicetype": @"ios",
                            @"distributor": @"SNM",
                            @"clientos": @"",
                            @"servicecode": @"ytfm",
                            @"clienttype": @"PC",
                            @"clientver": @"",
                            @"appcode":@""
                            };

    [request Post:@"" parameter:parm success:^(id responseObject) {

        NSLog(@"请求成功的回调====>>>%@",responseObject);
    } failure:^(NSError *error) {
        //
        NSLog(@"请求失败的回调====>>>%@",error);

    }];
    
    
    // Do any additional setup after loading the view.
}


@end
