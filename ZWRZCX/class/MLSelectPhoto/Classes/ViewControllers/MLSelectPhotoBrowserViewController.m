
#import "MLSelectPhotoBrowserViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIView+MLExtension.h"
#import "MLSelectPhotoPickerBrowserPhotoScrollView.h"
#import "MLSelectPhotoCommon.h"
#import "UIImage+MLTint.h"
#import "ALActionSheetView.h"

// 分页控制器的高度
static NSInteger ZLPickerColletionViewPadding = 20;
static NSString *_cellIdentifier = @"collectionViewCell";

@interface MLSelectPhotoBrowserViewController () <UIScrollViewDelegate,ZLPhotoPickerPhotoScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

// 控件
@property (strong,nonatomic)    ALActionSheetView *deleteSheetView;
@property (strong,nonatomic)    UIButton          *deleleBtn;
@property (strong,nonatomic)    UIButton          *trashBtn;
@property (weak,nonatomic)      UIButton          *backBtn;
@property (weak,nonatomic)      UICollectionView  *collectionView;

// 标记View
@property (strong,nonatomic)    UIToolbar *toolBar;
@property (weak,nonatomic)      UILabel *makeView;
@property (strong,nonatomic)    UIButton *doneBtn;

@property (strong,nonatomic)    NSMutableDictionary *deleteAssets;
@property (strong,nonatomic)    NSMutableArray *doneAssets;

// 是否是编辑模式
@property (assign,nonatomic) BOOL isEditing;
// 是否是选完图预览删除模式,显示垃圾桶
@property (assign,nonatomic) BOOL isTrashing;

@property (assign,nonatomic) BOOL isShowShowSheet;
@end

@implementation MLSelectPhotoBrowserViewController

#pragma mark - getter
#pragma mark collectionView
-(NSMutableDictionary *)deleteAssets{
    if (!_deleteAssets) {
        _deleteAssets = [NSMutableDictionary dictionary];
    }
    return _deleteAssets;
}

- (NSMutableArray *)doneAssets{
    if (!_doneAssets) {
        _doneAssets = [NSMutableArray array];
    }
    return _doneAssets;
}

- (ALActionSheetView *)deleteSheetView{
    if (!_deleteSheetView) {
        __weak typeof (self) weakSelf = self;
        _deleteSheetView = [ALActionSheetView showActionSheetWithTitle:@"要删除这张照片吗？" cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [weakSelf trashAsset];
            }
        }];
    }
    return _deleteSheetView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = ZLPickerColletionViewPadding;
        flowLayout.itemSize =  self.view.ml_size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.ml_width + ZLPickerColletionViewPadding ,self.view.ml_height) collectionViewLayout:flowLayout];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.bounces = YES;
        collectionView.delegate = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_cellIdentifier];
        
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
        
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_collectionView]-x-|" options:0 metrics:@{@"x":@(-20)} views:@{@"_collectionView":_collectionView}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_collectionView]-0-|" options:0 metrics:nil views:@{@"_collectionView":_collectionView}]];
        
        if (self.isEditing) {
            self.makeView.hidden = !(self.photos.count && self.isEditing);
            // 初始化底部ToorBar
            [self setupToorBar];
        }
    }
    return _collectionView;
}

#pragma mark Get View
#pragma mark makeView 红点标记View
- (UILabel *)makeView{
    if (!_makeView) {
        UILabel *makeView = [[UILabel alloc] init];
        makeView.textColor = [UIColor whiteColor];
        makeView.textAlignment = NSTextAlignmentCenter;
        makeView.font = [UIFont systemFontOfSize:13];
        makeView.frame = CGRectMake(-5, -5, 20, 20);
        makeView.hidden = YES;
        makeView.layer.cornerRadius = makeView.frame.size.height / 2.0;
        makeView.clipsToBounds = YES;
        makeView.backgroundColor = [UIColor redColor];
        [self.view addSubview:makeView];
        self.makeView = makeView;
        
    }
    return _makeView;
}

- (UIButton *)doneBtn{
    if (!_doneBtn) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.enabled = YES;
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        rightBtn.frame = CGRectMake(0, 0, 45, 45);
        [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn addSubview:self.makeView];
        self.doneBtn = rightBtn;
    }
    return _doneBtn;
}

#pragma mark deleleBtn
- (UIButton *)deleleBtn{
    if (!_deleleBtn) {
        UIButton *deleleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [deleleBtn setImage:[UIImage imageNamed:MLSelectPhotoSrcName(@"AssetsPickerChecked")] forState:UIControlStateNormal];
        deleleBtn.frame = CGRectMake(0, 0, 30, 30);
        [deleleBtn addTarget:self action:@selector(deleteAsset) forControlEvents:UIControlEventTouchUpInside];
        self.deleleBtn = deleleBtn;
    }
    return _deleleBtn;
}

#pragma mark trashBtn
- (UIButton *)trashBtn{
    if (!_trashBtn) {
        UIButton *trashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        trashBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        //[trashBtn setImage:[UIImage imageNamed:MLSelectPhotoSrcName(@"AssetsPickerChecked")] forState:UIControlStateNormal];
        trashBtn.backgroundColor = [UIColor whiteColor];
        trashBtn.frame = CGRectMake(0, 0, 30, 30);
        [trashBtn addTarget:self action:@selector(trashClick) forControlEvents:UIControlEventTouchUpInside];
        self.trashBtn = trashBtn;
    }
    return _trashBtn;
}

- (void)trashClick{
    [self.deleteSheetView show];
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    _doneAssets = [NSMutableArray arrayWithArray:photos];
    
    [self reloadData];
    self.makeView.text = [NSString stringWithFormat:@"%ld",self.photos.count];
}

- (void)setSheet:(UIActionSheet *)sheet{
    _sheet = sheet;
    if (!sheet) {
        self.isShowShowSheet = NO;
    }
}

#pragma mark - Life cycle
- (void)dealloc{
    self.isShowShowSheet = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark -初始化底部ToorBar
- (void) setupToorBar{
    UIToolbar *toorBar = [[UIToolbar alloc] init];
    toorBar.barTintColor = UIColorFromRGB(0x333333);
    toorBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:toorBar];
    self.toolBar = toorBar;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(toorBar);
    NSString *widthVfl =  @"H:|-0-[toorBar]-0-|";
    NSString *heightVfl = @"V:[toorBar(44)]-0-|";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:widthVfl options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:heightVfl options:0 metrics:0 views:views]];
    
    // 左视图 中间距 右视图
    UIBarButtonItem *fiexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.doneBtn];
    
    toorBar.items = @[fiexItem,rightItem];
}

- (void)deleteAsset{
    NSString *currentPage = [NSString stringWithFormat:@"%ld",self.currentPage];
    if ([_deleteAssets valueForKeyPath:currentPage] == nil) {
        [self.deleteAssets setObject:@YES forKey:currentPage];
        [self.deleleBtn setImage:[[UIImage imageNamed:MLSelectPhotoSrcName(@"AssetsPickerChecked") ] imageWithTintColor:[UIColor grayColor]] forState:UIControlStateNormal];
        
        if ([self.doneAssets containsObject:[self.photos objectAtIndex:self.currentPage]]) {
            [self.doneAssets removeObject:[self.photos objectAtIndex:self.currentPage]];
        }
    }else{
        if (![self.doneAssets containsObject:[self.photos objectAtIndex:self.currentPage]]) {
            [self.doneAssets addObject:[self.photos objectAtIndex:self.currentPage]];
        }
        [self.deleteAssets removeObjectForKey:currentPage];
        [self.deleleBtn setImage:[UIImage imageNamed:MLSelectPhotoSrcName(@"AssetsPickerChecked") ] forState:UIControlStateNormal];
    }
    
    self.makeView.text = [NSString stringWithFormat:@"%ld",self.doneAssets.count];
}

- (void)trashAsset{
    NSMutableArray *trashAssets = [NSMutableArray arrayWithArray:self.photos];
    if ([trashAssets containsObject:[self.photos objectAtIndex:self.currentPage]]) {
        [trashAssets removeObject:[self.photos objectAtIndex:self.currentPage]];
        self.photos = [NSArray arrayWithArray:trashAssets];
    }
    self.currentPage --;
    if (self.currentPage < 0) {
        self.currentPage = 0;
    }
    if (self.deleteCallBack) {
        self.deleteCallBack(trashAssets);
    }
    if (trashAssets.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self setPageLabelPage:self.currentPage];
        [self.collectionView reloadData];
    }
}

#pragma mark - reloadData
- (void) reloadData{
    
    [self.collectionView reloadData];
    
    if (self.currentPage >= 0) {
        CGFloat attachVal = 0;
        if (self.currentPage == self.photos.count - 1 && self.currentPage > 0) {
            attachVal = ZLPickerColletionViewPadding;
        }
        
        self.collectionView.ml_x = -attachVal;
        self.collectionView.contentOffset = CGPointMake(self.currentPage * self.collectionView.ml_width, 0);
        
        if (self.currentPage == self.photos.count - 1 && self.photos.count > 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(00.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.collectionView.contentOffset = CGPointMake(self.currentPage * self.collectionView.ml_width, self.collectionView.contentOffset.y);
            });
        }
    }
    
    // 添加自定义View
    [self setPageLabelPage:self.currentPage];
}

- (void)setIsEditing:(BOOL)isEditing{
    _isEditing = isEditing;
    
    if (isEditing) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.deleleBtn];
    }
}

- (void)setIsTrashing:(BOOL)isTrashing{
    _isTrashing = isTrashing;
    
    if (isTrashing) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.trashBtn];
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    
    if (self.photos.count) {
        cell.backgroundColor = [UIColor clearColor];
        MLSelectPhotoAssets *photo = self.photos[indexPath.item]; //[self.dataSource photoBrowser:self photoAtIndex:indexPath.item];
        
        if([[cell.contentView.subviews lastObject] isKindOfClass:[UIView class]]){
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        
        UIView *scrollBoxView = [[UIView alloc] init];
        scrollBoxView.frame = cell.bounds;
        scrollBoxView.ml_y = cell.ml_y;
        [cell.contentView addSubview:scrollBoxView];
        
        MLSelectPhotoPickerBrowserPhotoScrollView *scrollView =  [[MLSelectPhotoPickerBrowserPhotoScrollView alloc] init];
        if (self.sheet || self.isShowShowSheet == YES) {
            scrollView.sheet = self.sheet;
        }
        scrollView.backgroundColor = [UIColor clearColor];
        // 为了监听单击photoView事件
        scrollView.frame = [UIScreen mainScreen].bounds;
        scrollView.photoScrollViewDelegate = self;
        scrollView.photo = photo;
        
        [scrollBoxView addSubview:scrollView];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return cell;
}
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(MLSelectPhotoPickerBrowserPhotoScrollView *)photoScrollView{
    self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.isHidden;
    if (self.isEditing) {
        self.toolBar.hidden = !self.toolBar.isHidden;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.toolBar.hidden = NO;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect tempF = self.collectionView.frame;
    NSInteger currentPage = (NSInteger)((scrollView.contentOffset.x / scrollView.ml_width) + 0.5);
    if (tempF.size.width < [UIScreen mainScreen].bounds.size.width){
        tempF.size.width = [UIScreen mainScreen].bounds.size.width;
    }
    
    if ((currentPage < self.photos.count -1) || self.photos.count == 1) {
        tempF.origin.x = 0;
    }else if(scrollView.isDragging){
        tempF.origin.x = -ZLPickerColletionViewPadding;
    }
    
    if([[self.deleteAssets allValues] count] == 0 || [self.deleteAssets valueForKeyPath:[NSString stringWithFormat:@"%ld",(currentPage)]] == nil){
        [self.deleleBtn setImage:[UIImage imageNamed:MLSelectPhotoSrcName(@"AssetsPickerChecked") ] forState:UIControlStateNormal];
    }else{
        [self.deleleBtn setImage:[[UIImage imageNamed:MLSelectPhotoSrcName(@"AssetsPickerChecked") ] imageWithTintColor:[UIColor grayColor]] forState:UIControlStateNormal];
    }
    
    self.collectionView.frame = tempF;
}

- (void)done{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_TAKE_DONE object:nil userInfo:@{@"selectAssets":self.doneAssets}];
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setPageLabelPage:(NSInteger)page{
    self.title = [NSString stringWithFormat:@"%ld / %ld",page + 1, self.photos.count];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = (NSInteger)scrollView.contentOffset.x / (scrollView.ml_width - ZLPickerColletionViewPadding);
    if (currentPage == self.photos.count - 1 && currentPage != self.currentPage && [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y);
    }
    self.currentPage = currentPage;
    [self setPageLabelPage:currentPage];
}

@end