//
//  PMWebViewController.m
//  URLProtocolMark_Example
//
//  Created by steve on 04/09/2018.
//  Copyright © 2018 cnkcq. All rights reserved.
//

#import "PMWebViewController.h"

@interface PMWebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation PMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.google.com/"]];
//    [request setAllHTTPHeaderFields:@{
//                                      @"hello": @"google"
//                                      }];
//    NSString *bodyStr = @"google beauty body";
//    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:bodyData];
    
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[request copy]];
}

@end
