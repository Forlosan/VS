//
//  OursViewController.m
//  DWL_Vogue
//
//  Created by diaowenli on 15/11/7.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "OursViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"

@interface OursViewController ()

@end

@implementation OursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    HeadView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [self.view addSubview:headView];
    headView.backgroundColor = [UIColor colorWithRed:54 / 255.0 green:53 / 255.0 blue:68 / 255.0 alpha:1];
    [headView release];
    //
    UIButton *headButton = [UIButton buttonWithType:UIButtonTypeSystem];
    headButton.frame = CGRectMake(16, 25, 32, 32);
    [headButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [headButton setTintColor:[UIColor whiteColor]];
    [headView addSubview:headButton];
    [headButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 30, 32, 60, 20)];
    [headView addSubview:headLabel];
    headLabel.text = @"设置";
    headLabel.textAlignment = 1;
    headLabel.textColor = [UIColor whiteColor];
    headLabel.font = [UIFont systemFontOfSize:15];
    [headLabel release];
    
    UIImageView *logImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 74, WIDTH - 200, WIDTH - 200)];
    logImageView.image = [UIImage imageNamed:@"LOGO-1024.png"];
    [self.view addSubview:logImageView];
    [logImageView release];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, WIDTH - 126, WIDTH - 50, 30)];
    
    //  显示版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(infoDictionary);
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    versionLabel.text = [@"Vogue Show当前版本 " stringByAppendingString:app_build];
    [self.view addSubview:versionLabel];
    versionLabel.font = [UIFont systemFontOfSize:17];
    versionLabel.textColor = [UIColor darkGrayColor];
    versionLabel.textAlignment = 1;
    [versionLabel release];
    
    UILabel *oursLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, WIDTH - 50, WIDTH - 50, 200)];
    [self.view addSubview:oursLabel];
    oursLabel.text = @"    Vogue Show 是一款把生活和时尚融为一体的助手，在这里你不仅会感受到生活的美好，同时也会让你的时尚感爆棚。这里有你需要的一切，我们会更加的努力，给你的生活带来不一样的感觉。请多提建议，多多支持！";
    oursLabel.textColor = [UIColor darkGrayColor];
    oursLabel.numberOfLines = 0;
    oursLabel.font = [UIFont systemFontOfSize:14];
    [oursLabel release];
    
}

- (void)leftButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
