//
//  carOwnerInterfaceVC.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/3.
//  Copyright © 2016年 董志成. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "SCPhotoHelper.h"
#import "MLSelectPhotoBrowserViewController.h"

#import "carOwnerInterfaceVC.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerViewController.h"
#import "carOwnerInterfaceTableViewCell.h"


@interface carOwnerInterfaceVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong,nonatomic) MLSelectPhotoAssets *carOwnerInterfaceVCAsset;

@property (strong,nonatomic) NSMutableArray * carOwnerassets;

@property (weak,nonatomic) UICollectionView *collectionView;

@end

@implementation carOwnerInterfaceVC
- (IBAction)textScreenRecord:(id)sender {
    

    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLabyout = [[UICollectionViewFlowLayout alloc] init];
        flowLabyout.itemSize = CGSizeMake(50, 50);
        flowLabyout.minimumLineSpacing = 5;
        flowLabyout.minimumInteritemSpacing = 5;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLabyout];
        collectionView.bounces = NO;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"NewShowCell"];
        //_mCollectionView.scrollEnabled = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return _collectionView;
}


- (NSMutableArray *)carOwnerassets{
    if (!_carOwnerassets) {
        _carOwnerassets = [NSMutableArray array];
    }
    return _carOwnerassets;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor grayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectPhotos) name:@"breakRulusNotesViewController" object:nil];
    
    
    
}

- (void)selectPhotos {
    __weak typeof (self) weakSelf = self;
    [[SCPhotoHelper sharedInstance] choosePicture:^(NSArray *assets) {
        [weakSelf.carOwnerassets addObjectsFromArray:assets];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carOwnerassets.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"carOwnerInterfaceVCCell";
    
    carOwnerInterfaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[carOwnerInterfaceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    MLSelectPhotoAssets *asset = self.carOwnerassets[indexPath.row];
    cell.hearImageView.image = [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
    
     
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.carOwnerassets removeObjectAtIndex:[indexPath row]];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        
    }
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
    browserVc.currentPage = indexPath.row;
    [browserVc setValue:@(YES) forKeyPath:@"isTrashing"];
    browserVc.photos = self.carOwnerassets;
    __weak typeof (self) weakSelf = self;
    browserVc.deleteCallBack = ^(NSArray *assets){
        weakSelf.carOwnerassets = [NSMutableArray arrayWithArray:_carOwnerassets];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:browserVc animated:YES];
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"NewShowCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    MLSelectPhotoAssets *asset = self.carOwnerassets[indexPath.row];
    [cell.contentView setBackgroundColor:[UIColor greenColor]];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50,50);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.carOwnerassets.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MLSelectPhotoBrowserViewController *browserVc = [[MLSelectPhotoBrowserViewController alloc] init];
    browserVc.currentPage = indexPath.row;
    [browserVc setValue:@(YES) forKeyPath:@"isTrashing"];
    browserVc.photos = self.carOwnerassets;
    __weak typeof (self) weakSelf = self;
    browserVc.deleteCallBack = ^(NSArray *assets){
        weakSelf.carOwnerassets = [NSMutableArray arrayWithArray:assets];
        [weakSelf.collectionView reloadData];
    };
    [self.navigationController pushViewController:browserVc animated:YES];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)removeObserver:(id)observer{
//
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
