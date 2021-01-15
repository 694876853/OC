//
//  AppDelegate.h
//  GNetWorkTool
//
//  Created by Leopard on 2021/1/15.
//  Copyright © 2021 Lepard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

