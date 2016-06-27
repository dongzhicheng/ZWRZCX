//
//  traveIInformationTableVC.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/3.
//  Copyright © 2016年 董志成. All rights reserved.
//下面几行需要接口给数据：
//    cell.textLabe.text = self.travelCellModelArray[indexPath.row].cellLabelText;
//    cell.detailLabel.text = self.travelCellModelArray[indexPath.row].cellDetailLabelText;
//    NSString * heardNameStr = self.travelCellModelArray[indexPath.row].cellImageNameText;




@interface traveIInformationTableVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong , nonatomic) IBOutlet UIImageView *iamg;
@property (strong , nonatomic) NSArray * travelCellModelArray;

@end

@implementation traveIInformationTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) weakself = self;
    
    [travelInformationTableCellModel travesArrayInfCellWithCompletion:^(NSArray *travesArrayInCell) {
        
        weakself.travelCellModelArray = travesArrayInCell;
        
    }];
    
    
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
    cell.hearImageView.image = [UIImage imageNamed:@"DZC"];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
