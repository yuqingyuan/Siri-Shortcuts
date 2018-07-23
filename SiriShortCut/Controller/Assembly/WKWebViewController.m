//
//  WKWebViewController.m
//  SiriShortCut
//
//  Created by yuqingyuan on 2018/7/23.
//  Copyright © 2018年 yuqingyuan. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong) WKWebView *webView;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
}

-(void)viewDidAppear:(BOOL)animated
{
    if(animated)
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.loadUrl]];
    }
}

#pragma mark - button

-(void)webviewDismissAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - delegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"start");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"commit");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"finish");
    self.title = webView.title;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"fail");
}

- (WKWebView *)webView
{
    if(!_webView)
    {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
