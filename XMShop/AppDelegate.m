//
//  AppDelegate.m
//  XMShop
//
//  Created by apple on 2018/2/26.
//  Copyright © 2018年 RM. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setNavi];
    [self setDB];
    [self setSV];
    
    sleep(1);
    return YES;
}

- (void)setNavi{
    //隐藏导航栏下面的线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[UINavigationBar appearance] setBarTintColor:BGColor];
    [UINavigationBar appearance].translucent = NO;
}

- (void)setDB{
    /**
     想测试更多功能,打开注释掉的代码即可.
     */
    bg_setDebug(YES);//打开调试模式,打印输出调试信息.
    
    /**
     如果频繁操作数据库时,建议进行此设置(即在操作过程不关闭数据库).
     */
    //bg_setDisableCloseDB(YES);
    
    /**
     手动关闭数据库(如果设置了bg_setDisableCloseDB(YES)，则在切换bg_setSqliteName前，需要手动关闭数据库一下).
     */
    //bg_closeDB();
    
    /**
     自定义数据库名称，否则默认为BGFMDB
     */
    bg_setSqliteName(@"XMShopDB");
    
    //删除自定义数据库.
    //bg_deleteSqlite(@"Tencent");
    
    /**
     直接存储数组.
     */
    //[self testSaveArray];
    
    /**
     直接存储字典.
     */
    //[self testSaveDictionary];
    /**
     直接存储自定义对象.
     */
//    People* p = [self people];
//    p.bg_tableName = bg_tablename;//自定义数据库表名称(库自带的字段).
    /**
     存储.
     */
//    [p bg_save];
}

- (void)setSV{
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
