//
//  AppDelegate.m
//  LoadLocalHtml
//
//  Created by macco on 2017/5/18.
//  Copyright © 2017年 macco. All rights reserved.
//

#import "AppDelegate.h"

#import "WebViewHelper.h"
#import "GCDWebServer.h"
@interface AppDelegate (){
    GCDWebServer* _webServer;
}


@end

@implementation AppDelegate


- (void)createWebServer {
    
    _webServer = [[GCDWebServer alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *htmlDataPath = [documentsPath stringByAppendingPathComponent:@"HtmlSource.bundle"];
    
    [_webServer addGETHandlerForBasePath:@"/" directoryPath:htmlDataPath indexFilename:@"index.html" cacheAge:20 allowRangeRequests:NO];
    // Start server on port 8080
    [_webServer startWithPort:8080 bonjourName:nil];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    WebViewHelper *webHelper = [[WebViewHelper alloc]init];
    [webHelper saveHtmlDataToSandBox];
    
    if ([[UIDevice currentDevice] systemVersion].floatValue < 9.0) {
        [self createWebServer];
    }
    [self createWebServer];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
