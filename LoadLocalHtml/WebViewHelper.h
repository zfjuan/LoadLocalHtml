//
//  WebViewHelper.h
//  LoadLocalHtml
//
//  Created by macco on 2017/5/22.
//  Copyright © 2017年 macco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WebViewHelper : NSObject
-(void)saveHtmlDataToSandBox; //将HtmlData存储到沙盒
- (NSString *)getHtmlStrWithFileName:(NSString *)fileName; //>=9:通过获取沙盒中的网页来加载数据
- (NSURL *)getHtmlUrlWithFileName:(NSString *)fileName; // <9:通过GCDWebServer

- (void)deleteFileUnderTheBundleWithFileName:(NSString *)fileName; //删除沙盒中bundle文件下某个文件夹
- (void)addFileToBundleWithFileName:(NSString *)fileName; //沙盒中bundle文件下增加文件夹

@end
