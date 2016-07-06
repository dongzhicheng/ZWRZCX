//
//  travelInformationVC.m
//  ZWRZCX
//
//  Created by 董志成 on 16/7/5.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "travelInformationVC.h"
#import "DZCNavigationController.h"

@interface travelInformationVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *travelCellModelArray;

@property (strong, nonatomic) IBOutlet UIButton *testBtnBordColorBtn0;
@property (strong, nonatomic) IBOutlet UIButton *testBtnBordColorBtn1;
@property (strong, nonatomic) IBOutlet UIButton *testBtnBordColorBtn2;
@property (strong, nonatomic) IBOutlet UIButton *testBtnBordColorBtn3;
@property (strong, nonatomic) IBOutlet UIButton *testBtnBordColorBtn4;
@property (strong, nonatomic) IBOutlet UIButton *testBtnBordColorBtn5;


@end

@implementation travelInformationVC

- (IBAction)testBtnClick:(id)sender {
    
    [self testBtnClick];

}
- (IBAction)testBtnBordColorBtn1:(id)sender {
    
    [self testBtnClick];
    
}
- (IBAction)testBtnBordColorBtn2:(id)sender {
    
    [self testBtnClick];
}
- (IBAction)testBtnBordColorBtn3:(id)sender {
    
    [self testBtnClick];
    
}
- (IBAction)testBtnBordColorBtn4:(id)sender {
    
    [self testBtnClick];
    
}
- (IBAction)testBtnBordColorBtn5:(id)sender {
    
    [self testBtnClick];
    
}

-(void)testBtnClick{

    UIViewController * TestViewController = [[UIViewController alloc] init];
    TestViewController.view.backgroundColor = [UIColor yellowColor];
    TestViewController.title  = @"0测试按钮点击跳转0";
    [self.navigationController pushViewController:TestViewController animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    [self btnBorderColorAndWidth:2.5f andCornerRadius:30]; //方法调用
    
    __weak typeof(self) weakself = self;
    
    [travelInformationTableCellModel travesArrayInfCellWithCompletion:^(NSArray *travesArrayInCell) {
        
        weakself.travelCellModelArray = travesArrayInCell;
        
    }];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    
    [self.tableView.header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    
}
-(void)btnBorderColorAndWidth: (CGFloat)bordeWith andCornerRadius: (CGFloat )CornerRadius{

    
    self.testBtnBordColorBtn0.layer.borderColor = [[UIColor grayColor] CGColor];
    self.testBtnBordColorBtn0.layer.borderWidth = bordeWith;
    self.testBtnBordColorBtn0.layer.cornerRadius = CornerRadius;
    self.testBtnBordColorBtn0.layer.masksToBounds = YES;
    
    self.testBtnBordColorBtn1.layer.borderColor = [[UIColor grayColor] CGColor];
    self.testBtnBordColorBtn1.layer.borderWidth = bordeWith;
    self.testBtnBordColorBtn1.layer.cornerRadius = CornerRadius;
    self.testBtnBordColorBtn1.layer.masksToBounds = YES;
    
    
    self.testBtnBordColorBtn2.layer.borderColor = [[UIColor grayColor] CGColor];
    self.testBtnBordColorBtn2.layer.borderWidth = bordeWith;
    self.testBtnBordColorBtn2.layer.cornerRadius = CornerRadius;
    self.testBtnBordColorBtn2.layer.masksToBounds = YES;

    self.testBtnBordColorBtn3.layer.borderColor = [[UIColor grayColor] CGColor];
    self.testBtnBordColorBtn3.layer.borderWidth = bordeWith;
    self.testBtnBordColorBtn3.layer.cornerRadius = CornerRadius;
    self.testBtnBordColorBtn3.layer.masksToBounds = YES;
    
    self.testBtnBordColorBtn4.layer.borderColor = [[UIColor grayColor] CGColor];
    self.testBtnBordColorBtn4.layer.borderWidth = bordeWith;
    self.testBtnBordColorBtn4.layer.cornerRadius = CornerRadius;
    self.testBtnBordColorBtn4.layer.masksToBounds = YES;
    
    self.testBtnBordColorBtn5.layer.borderColor = [[UIColor grayColor] CGColor];
    self.testBtnBordColorBtn5.layer.borderWidth = bordeWith;
    self.testBtnBordColorBtn5.layer.cornerRadius = CornerRadius;
    self.testBtnBordColorBtn5.layer.masksToBounds = YES;
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 108;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"message";
    travelInformationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[travelInformationTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.hearImageView.image = [UIImage imageNamed:@"1"];
    cell.detailLabel.numberOfLines = 0;
    cell.textLabe.numberOfLines = 0;
    cell.textLabe.text = @"DZC";
    cell.detailLabel.text =  @"2012年的那个冬天，寒冷的小风吹着，我那个心是那个激动";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPat--%d",indexPath.row);
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"webViewController" bundle:nil];
    webViewController *webVC = [storyBoard instantiateViewControllerWithIdentifier:@"webViewController"];
    NSLog(@"-----%@",webVC);
    [self.navigationController pushViewController:webVC animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
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
