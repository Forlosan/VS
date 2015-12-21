//
//  ClothesWebViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/29.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "ClothesWebViewController.h"
#import "WidthAndHeight.h"
#import "VogueHeader.h"


@interface ClothesWebViewController ()<UIWebViewDelegate>
@property(nonatomic, retain)UIActivityIndicatorView *acView;

@end

@implementation ClothesWebViewController

- (void)dealloc {
    [_url release];
    [_acView release];
    
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    leftButton.frame = CGRectMake(0, 0, 30, 30);
//    [leftButton setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
//    [leftButton setTintColor:[UIColor whiteColor]];
//    [leftButton addTarget:self action:@selector(leftButtonClick)forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    [leftItem release];
    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -64, WIDTH, HEIGHT + 64)];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:webView];
    [webView release];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
//    webView.scrollView.pagingEnabled = NO;
//    webView.scrollView.bounces = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    self.acView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32.0f, 32.0f)];
    self.acView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.acView.center = self.view.center;
    [self.view addSubview:self.acView];
    [_acView release];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    
    //    headView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headView];
    headView.backgroundColor = [UIColor colorWithRed:54 / 255.0 green:53 / 255.0 blue:68 / 255.0 alpha:1];
    [headView release];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(16, 25, 32, 32);
    [leftButton setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [leftButton setTintColor:[UIColor whiteColor]];
    [headView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 50, 32, 100, 25)];
    headLabel.text = @"潮流";
    headLabel.textAlignment = 1;
    headLabel.font = [UIFont systemFontOfSize:15];
    headLabel.textColor = [UIColor whiteColor];
    [headView addSubview:headLabel];
    [headLabel release];
}

- (void)leftButtonClick {
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.5f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    transition.type = kCATransitionReveal;
//    transition.subtype = kCATransitionFromBottom;
//    transition.delegate = self;
//    [self.view.window.layer addAnimation:transition forKey:nil];
//    [self.navigationController popViewControllerAnimated:YES];
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
