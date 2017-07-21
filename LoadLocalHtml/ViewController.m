//
//  ViewController.m
//  LoadLocalHtml
//
//  Created by macco on 2017/5/18.
//  Copyright © 2017年 macco. All rights reserved.
//

#import "ViewController.h"
#import "WebViewHelper.h"
#import "SSZipArchive/SSZipArchive.h"

@interface ViewController ()<WKNavigationDelegate>
@property (nonatomic, strong)WKWebView *webView;
@property (copy, nonatomic) NSString *zipPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height - 120)];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 30, 60, 34)];
    backButton.backgroundColor = [UIColor redColor];
    [backButton setTitle:@"bun0" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(html0Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
   
    UIButton *backButton1 = [[UIButton alloc]initWithFrame:CGRectMake(120, 30, 60, 34)];
    backButton1.backgroundColor = [UIColor greenColor];
    [backButton1 setTitle:@"bun1" forState:UIControlStateNormal];
    [backButton1 addTarget:self action:@selector(html1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton1];
    
    UIButton *backButton3 = [[UIButton alloc]initWithFrame:CGRectMake(200, 30, 60, 34)];
    backButton3.backgroundColor = [UIColor greenColor];
    [backButton3 setTitle:@"gcd" forState:UIControlStateNormal];
    [backButton3 addTarget:self action:@selector(html3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton3];
    
    UIButton *backButton4 = [[UIButton alloc]initWithFrame:CGRectMake(270, 30, 60, 34)];
    backButton4.backgroundColor = [UIColor brownColor];
    [backButton4 setTitle:@"dele" forState:UIControlStateNormal];
    [backButton4 addTarget:self action:@selector(deleCli) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton4];
    
    UIButton *backButton5 = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 60, 34)];
    backButton5.backgroundColor = [UIColor brownColor];
    [backButton5 setTitle:@"zip" forState:UIControlStateNormal];
    [backButton5 addTarget:self action:@selector(unzip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton5];
}


- (void)html0Click {

    WebViewHelper *webHelper = [[WebViewHelper alloc]init];
    NSString *html = [webHelper getHtmlStrWithFileName:@"Info/info.html"];
    [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];

}

- (void)html1Click {
    WebViewHelper *webHelper = [[WebViewHelper alloc]init];
    NSString *html = [webHelper getHtmlStrWithFileName:@"Info/AskPublishGuard.html"];
    [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

-(void) html3Click {

    WebViewHelper *webHelper = [[WebViewHelper alloc]init];
    NSURL *htmlPath = [webHelper getHtmlUrlWithFileName:@"Info/info.html"];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:htmlPath];
    [self.webView loadRequest:request];
    
}

- (void)deleCli {
    WebViewHelper *webHelper = [[WebViewHelper alloc]init];
    [webHelper deleteFileUnderTheBundleWithFileName:@"Info"];
    [webHelper addFileToBundleWithFileName:@"Info"];
}

- (void)unzip {
    [self unzipFile];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"1111");
}

#pragma mark - zip
- (void)unzipFile{

    self.zipPath = [[NSBundle mainBundle] pathForResource:@"InfoTwo" ofType:@"zip"];
    NSString *path = [NSString stringWithFormat:@"%@/\%@",
                      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0],
                      @"123"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtURL:url
                             withIntermediateDirectories:YES
                                              attributes:nil
                                                   error:&error];
    NSString *unzipPath = url.path;
    
    
    BOOL success = [SSZipArchive unzipFileAtPath:self.zipPath
                                   toDestination:unzipPath];
    if (!success) {
        return;
    }
//    NSMutableArray<NSString *> *items = [[[NSFileManager defaultManager]
//                                          contentsOfDirectoryAtPath:unzipPath
//                                          error:&error] mutableCopy];
     NSArray *htmlArr = [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[unzipPath stringByAppendingPathComponent:@"InfoTwo"] error:nil]];
    if (error) {
        return;
    }
//    [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        
//    }];

}


- (void)zip {
//    // 解压
//    NSString *zipPath = @"被解压的文件路径";
//    NSString *destinationPath = @"解压到的目录";
//    [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath];
//    
//    // 压缩
//    NSString *zippedPath = @"压缩文件路径";
//    NSArray *inputPaths = [NSArray arrayWithObjects:
//                           [[NSBundle mainBundle] pathForResource:@"photo1" ofType:@"jpg"],
//                           [[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"] nil];
//    [SSZipArchive createZipFileAtPath:zippedPath withFilesAtPaths:inputPaths];
}
#pragma mark - SSZipArchiveDelegate
- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo {

}
- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPat uniqueId:(NSString *)uniqueId {

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
