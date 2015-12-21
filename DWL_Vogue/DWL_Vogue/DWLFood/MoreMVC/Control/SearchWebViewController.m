//
//  SearchWebViewController.m
//  DWL_Vogue
//
//  Created by diaowenli on 15/11/5.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "SearchWebViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"

@interface SearchWebViewController ()<UIWebViewDelegate>
@property(nonatomic, retain)UIActivityIndicatorView *acView;

@end

@implementation SearchWebViewController
- (void)dealloc {
    [_url release];
    [_acView release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.url);
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 4, WIDTH, HEIGHT - 4)];
    [self.view addSubview:webView];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [webView release];
    webView.scalesPageToFit = YES;
    webView.scrollView.bounces = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    self.acView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32.0f, 32.0f)];
    self.acView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.acView.center = self.view.center;
    [self.view addSubview:self.acView];
    [_acView release];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headView];
    headView.backgroundColor = [UIColor colorWithRed:54 / 255.0 green:53 / 255.0 blue:68 / 255.0 alpha:1];
    [headView release];
    
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeSystem];
    headButton.frame = CGRectMake(16, 25, 32, 32);
    [headButton setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [headButton setTintColor:[UIColor whiteColor]];
    [headView addSubview:headButton];
    [headButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 50, 32, 100, 25)];
    headLabel.text = @"美食 · 菜谱";
    headLabel.textAlignment = 1;
    headLabel.font = [UIFont systemFontOfSize:15];
    headLabel.textColor = [UIColor whiteColor];
    [headView addSubview:headLabel];
    [headLabel release];
}

- (void)leftButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.acView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.acView stopAnimating];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end