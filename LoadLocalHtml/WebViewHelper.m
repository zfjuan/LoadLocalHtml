//
//  WebViewHelper.m
//  LoadLocalHtml
//
//  Created by macco on 2017/5/22.
//  Copyright © 2017年 macco. All rights reserved.
//

#import "WebViewHelper.h"
#import "GCDWebServer.h"

@interface WebViewHelper (){
    GCDWebServer* _webServer;
}
@end
@implementation WebViewHelper

//将HtmlData存储到沙盒
- (void)saveHtmlDataToSandBox {
    NSString *boundleResourcePath = [[NSBundle mainBundle] pathForResource:@"HtmlSource" ofType:@"bundle"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *htmlDataPath = [documentsPath stringByAppendingPathComponent:@"HtmlSource.bundle"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:htmlDataPath]) {
        NSError * err;
        [fileManager copyItemAtPath:boundleResourcePath toPath:htmlDataPath error:&err];
    }
}

- (void)createWebServer {
    
    _webServer = [[GCDWebServer alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *htmlDataPath = [documentsPath stringByAppendingPathComponent:@"HtmlSource.bundle"];
    
    [_webServer addGETHandlerForBasePath:@"/" directoryPath:htmlDataPath indexFilename:@"index.html" cacheAge:20 allowRangeRequests:NO];
    // Start server on port 8080
    [_webServer startWithPort:8080 bonjourName:nil];
    
}

//>=9:通过获取沙盒中的网页来加载数据
- (NSString *)getHtmlStrWithFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *bundlePath = [documentsPath stringByAppendingPathComponent:@"HtmlSource.bundle"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"Info"];
//    NSArray *htmlArr = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:infoPath error:nil]];
    NSString *filePath = [bundlePath stringByAppendingPathComponent:fileName];
    NSString *html = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return html;

}

// <9:通过GCDWebServer
- (NSURL *)getHtmlUrlWithFileName:(NSString *)fileName {
    NSString* bundlePath = @"http://localhost:8080/";
    NSString *infoPath = [bundlePath stringByAppendingPathComponent:fileName];
    NSURL* htmlPath = [[NSURL alloc] initWithString:infoPath];
    return htmlPath;
}

//删除沙盒中bundle文件下某个文件夹
- (void)deleteFileUnderTheBundleWithFileName:(NSString *)fileName{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *bundlePath = [documentsPath stringByAppendingPathComponent:@"HtmlSource.bundle"];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *htmlArr = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:bundlePath error:nil]];
    for (NSString *fileNameStr in htmlArr) {
        if ([fileNameStr isEqualToString:fileName]) {
            [[NSFileManager defaultManager] removeItemAtPath:[bundlePath stringByAppendingPathComponent:fileName] error:nil];
        }
    }
}

//沙盒中bundle文件下增加文件夹
- (void)addFileToBundleWithFileName:(NSString *)fileName {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *boundleResourcePath = [resourcePath stringByAppendingPathComponent:fileName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *htmlDataPath = [documentsPath stringByAppendingPathComponent:@"HtmlSource.bundle"];
    NSString *filePath = [htmlDataPath stringByAppendingPathComponent:fileName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath]) {
        NSError * err;
        [fileManager copyItemAtPath:boundleResourcePath toPath:[NSString stringWithFormat:@"%@",filePath] error:&err];
    }
}

@end
