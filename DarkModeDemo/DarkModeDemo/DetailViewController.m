//
//  DetailViewController.m
//  DarkModeDemo
//
//  Created by caishihui on 2019/9/23.
//  Copyright © 2019 wqj. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://baike.baidu.com/item/%E8%8B%B9%E6%9E%9C%E5%85%AC%E5%8F%B8/304038?fr=aladdin"]];
    [self.webView loadRequest:request];
}

@end
