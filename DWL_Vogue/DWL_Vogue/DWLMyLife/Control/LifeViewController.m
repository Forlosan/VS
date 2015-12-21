//
//  LifeViewController.m
//  DWL_Vogue
//
//  Created by dllo on 15/10/27.
//  Copyright (c) 2015年 Forlosan. All rights reserved.
//

#import "LifeViewController.h"
#import "VogueHeader.h"
#import "WidthAndHeight.h"
#import "LifeCollectionViewCell.h"
#import "MyLifeViewController.h"

@interface LifeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, retain)UIButton *titleButton;
@property(nonatomic, retain)UICollectionView *collectionView;
@property(nonatomic, retain)NSArray *lifeImageArr;
@property(nonatomic, retain)NSArray *lifeTextArr;
@property(nonatomic, retain)NSArray *lifeUrlArr;
@property(nonatomic, retain)NSArray *lifeWebTitleNameArr;

@end

@implementation LifeViewController
- (void)dealloc {
    [_collectionView release];
    [_lifeImageArr release];
    [_lifeTextArr release];
    [_lifeUrlArr release];
    [_lifeWebTitleNameArr release];
    Block_release(_block);
//    Block_release(_block1);
    
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //    LifeArr
        self.lifeImageArr = @[@"car.jpg", @"building.jpg", @"decoration.jpg", @"digital.jpg", @"originality.jpg", @"news.jpg"];
        self.lifeTextArr = @[@"汽  车", @"建  筑", @"空  间", @"数  码", @"创  意", @"格  调"];
        self.lifeWebTitleNameArr = @[@"生活 · 汽车", @"生活 · 建筑", @"生活 · 空间", @"生活 · 数码", @"生活 · 创意", @"生活 · 格调"];
        self.lifeUrlArr = @[CAR, BUILIDING, DECORATION, DIGITAL, ORIGINALITY, BIGE];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    Flowlayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH / 2 - 40, HEIGHT / 6);
    flowLayout.minimumLineSpacing = 30;
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    flowLayout.headerReferenceSize = CGSizeMake(WIDTH, 100);
    
//    CollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    [flowLayout release];
    [_collectionView release];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //  注册侧cell
    [self.collectionView registerClass:[LifeCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.770 green:0.774 blue:0.810 alpha:1.000];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
//    HeadView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    [headView release];
    //  imageView
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    headImageView.image = [UIImage imageNamed:@"headView.jpg"];
    [headView addSubview:headImageView];
    [headImageView release];
    //  label
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 150, 50, 300, 30)];
    headLabel.text = @"寻找生活中的美好";
    headLabel.textColor = [UIColor whiteColor];
    headLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    headLabel.textAlignment = 1;
    [headView addSubview:headLabel];
    [headLabel release];
    
//    FootView
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 64, WIDTH, 64)];
    footView.backgroundColor = [UIColor colorWithRed:39 / 255.0 green:38 / 255.0 blue:55 / 255.0 alpha:1];
    [self.view addSubview:footView];
    [footView release];
    
    //  button
    self.titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.titleButton.frame = CGRectMake(WIDTH / 2 - 50, 15, 100, 20);
    [self.titleButton setTitle:@"时尚·生活↑" forState:UIControlStateNormal];
    [self.titleButton setTintColor:[UIColor whiteColor]];
    self.titleButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
    [footView addSubview:self.titleButton];
    [self.titleButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)click {
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lifeImageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LifeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.lifeImageView.image = [UIImage imageNamed:self.lifeImageArr[indexPath.row]];
    cell.lifeLabel.text = self.lifeTextArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.block(self.lifeUrlArr[indexPath.row]);
//    self.block1(self.lifeWebTitleNameArr[indexPath.row]);
    [self.delegate takeName:self.lifeWebTitleNameArr[indexPath.row]];
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.view.window.layer addAnimation:transition forKey:nil];
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
