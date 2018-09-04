//
//  PMWKWebViewController.m
//  URLProtocolMark_Example
//
//  Created by steve on 04/09/2018.
//  Copyright © 2018 cnkcq. All rights reserved.
//

#import "PMWKWebViewController.h"
#import <WebKit/WKWebView.h>

@interface PMWKWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation PMWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
//    [request setAllHTTPHeaderFields:@{
//                                      @"hello": @"baidu"
//                                      }];
//    NSString *bodyStr = @"baidu beauty body";
//    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:bodyData];
//    WKURLSchemeTask （iOS11， *）
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[request copy]];
}

@end
