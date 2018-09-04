//
//  PMViewController.m
//  URLProtocolMark
//
//  Created by cnkcq on 09/01/2018.
//  Copyright (c) 2018 cnkcq. All rights reserved.
//

#import "PMViewController.h"
#import "PMWebViewController.h"
#import "PMWKWebViewController.h"

@interface PMViewController ()

@end

@implementation PMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"web" style:UIBarButtonItemStylePlain target:self action:@selector(pushWeb)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"wkweb" style:UIBarButtonItemStylePlain target:self action:@selector(pushwkWeb)];
}

- (void)pushwkWeb {
    PMWKWebViewController *wkweb = [[PMWKWebViewController alloc] init];
    [self.navigationController pushViewController:wkweb animated:YES];
}

- (void)pushWeb {
    PMWebViewController *web = [[PMWebViewController alloc] init];
    [self.navigationController pushViewController:web animated:YES];
}

@end
