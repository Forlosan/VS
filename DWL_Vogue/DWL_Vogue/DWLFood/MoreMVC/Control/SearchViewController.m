//
//  SearchViewController.m
//  DWL_Vogue
//
//  Created by diaowenli on 15/11/5.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "SearchViewController.h"
#import "WidthAndHeight.h"
#import "VogueHeader.h"
#import "SearchInformation.h"
#import "SearchTableViewCell.h"
#import "SearchWebViewController.h"

@interface SearchViewController()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate>
@property(nonatomic, retain)UISearchBar *searchBar;
@property(nonatomic, retain)UITableView *searchTableView;
@property(nonatomic, retain)NSMutableArray *searchArr;
@property(nonatomic, assign)NSInteger num;
@property(nonatomic, retain)MBProgressHUD *HUD;

@end

@implementation SearchViewController
- (void)dealloc {
    [_searchBar release];
    [_searchTableView release];
    [_searchArr release];
    [_HUD release];
    NSLog(@"%s", __func__);
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleButton.frame = CGRectMake(WIDTH - 48, 25, 32, 32);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTintColor:[UIColor whiteColor]];
    [headView addSubview:cancleButton];
    [cancleButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];


    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 25, WIDTH - 120, 30)];
    self.searchBar.delegate = self;
    self.searchBar.layer.borderWidth = 8;
    self.searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchBar.layer.cornerRadius = 5;
    self.searchBar.layer.masksToBounds = YES;
    [headView addSubview:self.searchBar];
    self.searchBar.placeholder = @"搜索你想要的美食";
    [self.searchBar setTintColor:[UIColor lightGrayColor]];
    [self.navigationController.navigationBar bringSubviewToFront:self.searchBar];
    self.searchBar.keyboardType = UIKeyboardAppearanceDefault;
    self.searchBar.searchResultsButtonSelected = YES;
//    [self.searchBar setTranslucent:YES];
//    self.searchBar.barStyle = UIBarMetricsCompact;
//    self.searchBar.translucent = YES;
//    self.searchBar.showsSearchResultsButton = YES;
//    self.searchBar.searchTextPositionAdjustment = UIOffsetMake(30, 0);
    [_searchBar release];
    
    //    TableView
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Load-1242*2208.png"]];
    [self.searchTableView setBackgroundView:imageView];
    [self.view addSubview:self.searchTableView];
    [_searchTableView release];
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    self.searchTableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
//    self.searchTableView.footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    self.num = 0;
    
}

- (void)footer {
    self.num = self.num + 10;
    
    NSString *str = [self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url1 = [NSString stringWithFormat:@"machine=O0fd7f8732e846e4d9576337a9bd7acf37c68306d&vession=11.0.4.1&begin=%ld", (long)self.num];
    NSString *url2 = [url1 stringByAppendingString:@"&queryString="];
    NSString *bodyStr = [url2 stringByAppendingString:str];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError **error) {
        return parameters;
    }];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"text/javascript", @"text/html", @"application/json", nil];
    [manager POST:@"http://www.ecook.cn/public/searchRecipe.shtml" parameters:bodyStr success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"11%@", responseObject);
        for (NSMutableDictionary *dic1 in responseObject[@"contentList"]) {
            SearchInformation *search = [[SearchInformation alloc] init];
            [search setValuesForKeysWithDictionary:dic1];
            [self.searchArr addObject:search];
            [search release];
        }
        [self.searchTableView.footer endRefreshing];
        [self.searchTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)createData {
    
    NSString *str = [self.searchBar.text  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *bodyStr = [NSString stringWithFormat:@"machine=O0fd7f8732e846e4d9576337a9bd7acf37c68306d&vession=11.0.4.1&begin=0&queryString=%@", str];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError **error) {
        return parameters;
    }];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"text/javascript", @"text/html", @"application/json", nil];
    [manager POST:@"http://www.ecook.cn/public/searchRecipe.shtml" parameters:bodyStr success:^(NSURLSessionDataTask *task, id responseObject) {
        //        NSLog(@"11%@", responseObject);
        self.searchArr = [NSMutableArray array];
        for (NSMutableDictionary *dic1 in responseObject[@"contentList"]) {
            SearchInformation *search = [[SearchInformation alloc] init];
            [search setValuesForKeysWithDictionary:dic1];
            [self.searchArr addObject:search];
            [search release];
        }
        [self.searchTableView reloadData];
        self.searchTableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
        self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        if (self.searchArr.count == 0) {
            [self.HUD removeFromSuperview];
            self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.searchTableView animated:YES];
            hud.color = [UIColor colorWithWhite:0.147 alpha:0.300];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"没有您想要搜索的内容,请重新搜索";
            hud.margin = 10.f;
            hud.yOffset = - HEIGHT / 2 + 64 - 12;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:3];

        } else {
            [self.HUD removeFromSuperview];
        }


    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

#pragma searchBar
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    [searchBar becomeFirstResponder];
//    [self createData];
//}
//

- (void)rightAction {
    [self.HUD removeFromSuperview];
    self.searchBar.text = nil;
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.searchBar resignFirstResponder];
    self.searchArr = [NSMutableArray array];
    [self.searchTableView reloadData];
}

//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    [self searchBar:searchBar textDidChange:nil];
//    [searchBar resignFirstResponder];
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self createData];
    [self.searchBar resignFirstResponder];
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    [_HUD release];
    self.HUD.userInteractionEnabled = NO;
    self.HUD.minSize = CGSizeMake(120, 100);
    self.HUD.delegate = self;
    self.HUD.color = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.HUD.labelText = self.searchBar.text;
    self.HUD.labelFont = [UIFont systemFontOfSize:14];
    self.HUD.detailsLabelText = @"正在准备";
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:12];
    [self.HUD show:YES];
}

#pragma mark 分区
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.searchArr.count == 0) {
        
        return nil;
    } else {
        NSString *str = [NSString stringWithFormat:@"共搜索到%ld条相关的美食", self.searchArr.count];
        return str;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(12, 5, 300, 20);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:54 / 255.0 green:53 / 255.0 blue:68 / 255.0 alpha:1];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.text = sectionTitle;
    
    // Create header view and add label as a subview
    UIView *sectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)] autorelease];
    [sectionView setBackgroundColor:[UIColor colorWithRed:239 / 255.0 green:238 / 255.0 blue:244 / 255.0 alpha:1]];
//    [sectionView setBackgroundColor:[UIColor whiteColor]];
    [sectionView addSubview:label];
    return sectionView;
}

- (void)leftButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse1 = @"reuse1";
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse1];
    if (!cell) {
        cell = [[[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse1] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SearchInformation *search = self.searchArr[indexPath.row];
    [cell.searchImageView sd_setImageWithURL:[NSURL URLWithString:[[@"http://pic.ecook.cn/web/" stringByAppendingString:search.imageid] stringByAppendingString:@".jpg!m3"]] placeholderImage:[UIImage imageNamed:@"placeholderWhite.jpg"]];
    cell.searchTitleLabel.text = [[search.searchName stringByReplacingOccurrencesOfString:@"/ecook" withString:@""] stringByReplacingOccurrencesOfString:@"ecook" withString:@""];
    cell.searchContentLabel.text = search.content;
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:cell.searchTitleLabel.text];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[cell.searchTitleLabel.text rangeOfString:self.searchBar.text]];
    [cell.searchTitleLabel setAttributedText:attribute];
    [attribute release];

//    // 关键字高亮
//    NSString *keyword = self.searchBar.text;
//    // 清除空格
//    keyword = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    // 设置标签文字
//    NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString:search.searchName];
//    // 获取标红的位置和长度
//    NSRange range = [search.searchName rangeOfString:keyword];
//    // 设置标签文字的属性
//    [attrituteString setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor], NSFontAttributeName : [UIFont systemFontOfSize:16]} range:range];
//    cell.searchTitleLabel.text = search.searchName;
//    // 显示在titleLabel上
//    cell.searchTitleLabel.attributedText = attrituteString;
//    [attrituteString release];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    SearchWebViewController *web = [[SearchWebViewController alloc] init];
    web.url = [self.searchArr[indexPath.row] searchUrl];
    [self presentViewController:web animated:YES completion:nil];
    [web release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WIDTH / 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.searchArr.count == 0) {
        return 0;
    } else {
        return 30;
    }
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