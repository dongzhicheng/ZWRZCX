
#import "ViewController.h"
#import "IQMediaPickerController.h"
#import "IQFileManager.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "AudioTableViewCell.h"
#import "VideoTableViewCell.h"
#import "PhotoTableViewCell.h"
#import "DZCIQViewController.h"
#import "breakRulusPickerModel.h"

@interface DZCIQViewController ()<IQMediaPickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,AVCaptureFileOutputRecordingDelegate,AVPlayerViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,CZToolBarDelegate>


@property (strong, nonatomic) IBOutlet UIPickerView *pickView;
@property (strong, nonatomic) IBOutlet UILabel *Textbouds;
@property (strong, nonatomic) IBOutlet UITextField *repordTestField;
@property (strong, nonatomic) IBOutlet UITextField *detailRepordTestField;

@property (assign, nonatomic)NSInteger row;
@property (assign, nonatomic)NSInteger section;

@property (strong, nonatomic) NSArray *foods;
@property (nonatomic, weak) CZToolBar* toolBar;
@property (strong, nonatomic) IBOutlet UITableView *reportTabelView;
@property (strong,nonatomic)NSMutableDictionary *cellContentDict;
@property (strong,nonatomic) NSMutableArray * imageArray;



@end


@implementation DZCIQViewController

{
    IBOutlet UITableView *tableViewMedia;
    NSMutableDictionary *mediaInfo;
    
    IQMediaPickerControllerMediaType mediaType;
}

-(NSMutableArray *)iamgeArray {

    if (!_imageArray) {
        
            _imageArray = [NSMutableArray array];
        
            NSString *key = [[mediaInfo allKeys] objectAtIndex:self.section];
        
            NSMutableDictionary *dict = [[mediaInfo objectForKey:key] objectAtIndex:self.row];
        
        if ([dict objectForKey:IQMediaImage])
        {
            
            UIImage *image = [dict objectForKey:IQMediaImage];

            [_imageArray addObject:image];
            
        }
        
       
    }

    
    return _imageArray;
}

-(NSMutableDictionary *)cellContentDict{

    if (!_cellContentDict) {

        _cellContentDict = [[NSMutableDictionary alloc] init];
    }
    return _cellContentDict;
}

-(NSArray *)foods{ 
    if (!_foods) {
        NSString *path = [[NSBundle mainBundle ] pathForResource:@"foods" ofType:@"plist"];
        _foods = [NSArray arrayWithContentsOfFile:path];
    }
    return _foods;
}

- (IBAction)sureRepordWordsBtn:(id)sender {
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.repordTestField.delegate = self;
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    
    CZToolBar* toolBar = [CZToolBar toolBar];
    toolBar.toolBarDelegate = self;
    self.toolBar = toolBar;

    self.repordTestField.inputView = self.pickView;
    [self.pickView removeFromSuperview];
    self.repordTestField.inputAccessoryView = toolBar;

    self.reportTabelView.delegate = self;
    self.reportTabelView.dataSource = self;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;

}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return [self.foods[1] count];

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    self.row = row;
    
    return self.foods[1][row];

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    return YES;

}


- (void)toolBar:(CZToolBar*)toolBar withButtonType:(CZToolBarButtonType)type
{
    switch (type) {
        case CZToolBarButtonTypePre:
            [self.repordTestField resignFirstResponder];
            self.repordTestField.text = @"";
            break;
        case CZToolBarButtonTypeDone:
            NSLog(@"CZToolBarButtonTypeDone");
            NSString* str = self.foods[1][self.row];
            NSString *brithStr = str;
            brithStr = [NSString stringWithFormat:@"%@%@",self.repordTestField.text,str];
            self.repordTestField.text = brithStr;
            [self.repordTestField resignFirstResponder];
            [self.view endEditing:YES];
            break;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.repordTestField resignFirstResponder];
    [self.detailRepordTestField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [tableViewMedia reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (IBAction)pickAction:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"慎重选取返回后不能删除" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"取本地图片", @"取本地视频", @"取本地音频", @"拍图片取证", @"录视频取证", @"录音频取证", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        if (actionSheet.tag == 1)
        {
            mediaType = buttonIndex;
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否进行证据多项选择" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
            actionSheet.tag = 2;
            [actionSheet showInView:self.view];
        }
        else if (actionSheet.tag == 2)
        {
            IQMediaPickerController *controller = [[IQMediaPickerController alloc] init];
            controller.delegate = self;
            [controller setMediaType:mediaType];
            controller.allowsPickingMultipleItems = (buttonIndex == 0);
            [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

- (void)mediaPickerController:(IQMediaPickerController*)controller didFinishMediaWithInfo:(NSDictionary *)info;
{
    NSLog(@"Info: %@",info);

    mediaInfo = [info copy];
    [tableViewMedia reloadData];
}

- (void)mediaPickerControllerDidCancel:(IQMediaPickerController *)controller;
{
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [mediaInfo count];
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [[mediaInfo allKeys] objectAtIndex:section]; //组头
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        
        NSString *key = [[mediaInfo allKeys] objectAtIndex:indexPath.section];
        
        NSMutableDictionary *dict = [[mediaInfo objectForKey:key] objectAtIndex:indexPath.row];
        
        self.cellContentDict = dict; //记录字典内容
        
        if ([dict objectForKey:IQMediaImage])
        {

            [self.imageArray removeObjectAtIndex:indexPath.row];
   
            [self.reportTabelView reloadData];
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.row = indexPath.row;
    self.section = indexPath.section;
    
    NSString *key = [[mediaInfo allKeys] objectAtIndex:indexPath.section];
    
    NSMutableDictionary *dict = [[mediaInfo objectForKey:key] objectAtIndex:indexPath.row];
    
    self.cellContentDict = dict; //记录字典内容

    if ([dict objectForKey:IQMediaItem])
    {
        MPMediaItem *item = [dict objectForKey:IQMediaItem];
        
        MPMediaItemArtwork *artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
        UIImage *image = [artwork imageWithSize:artwork.bounds.size];
        
        AudioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AudioTableViewCell class])];

        cell.imageViewAudio.image = image;
        cell.labelTitle.text = [item valueForProperty:MPMediaItemPropertyAlbumTitle];
        cell.labelSubtitle.text = [[item valueForProperty:MPMediaItemPropertyAssetURL] relativePath];
        
        return cell;
    }
    else if([dict objectForKey:IQMediaAssetURL])
    {
        VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoTableViewCell class])];
        cell.imageViewVideo.image = nil;
        NSURL *url = [dict objectForKey:IQMediaAssetURL];
        cell.labelTitle.text = [url relativePath];
        cell.labelSubtitle.text = nil;
        return cell;
    }
    else if ([dict objectForKey:IQMediaImage])
    {
    
       UIImage *image = [dict objectForKey:IQMediaImage];
    
        PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PhotoTableViewCell class])];
        
       [self.imageArray addObject:image];
    
        cell.imageViewPhoto.image = image;
        
        return cell;
    }
    else if ([dict objectForKey:IQMediaURL])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        }
        
        NSString *key = [[mediaInfo allKeys] objectAtIndex:indexPath.section];
        
        NSURL *url = [[[mediaInfo objectForKey:key] objectAtIndex:indexPath.row] objectForKey:IQMediaURL];
        cell.textLabel.text = [[NSFileManager defaultManager] displayNameAtPath:url.relativePath];
        
        return cell;
    }
    else
    {
        return nil;
    }
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"如下是获取到的图片和音视频证据:";
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [[mediaInfo allKeys] objectAtIndex:section];
    return [[mediaInfo objectForKey:key] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[mediaInfo allKeys] objectAtIndex:indexPath.section];
    
    if ([key isEqualToString:IQMediaTypeImage])
    {
        return 80;
    }
    else
    {
        return tableView.rowHeight;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[mediaInfo allKeys] objectAtIndex:indexPath.section];
    
    NSDictionary *dict = [[mediaInfo objectForKey:key] objectAtIndex:indexPath.row];
    
    if ([dict objectForKey:IQMediaItem])
    {
        MPMediaItem *item = [dict objectForKey:IQMediaItem];

        NSURL *url = [item valueForProperty:MPMediaItemPropertyAssetURL];
        
        MPMoviePlayerViewController *controller = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [self presentMoviePlayerViewControllerAnimated:controller];
    }
    else if([dict objectForKey:IQMediaAssetURL])
    {
        NSURL *url = [dict objectForKey:IQMediaAssetURL];

        MPMoviePlayerViewController *controller = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [self presentMoviePlayerViewControllerAnimated:controller];
    }
    else if ([dict objectForKey:IQMediaImage])
    {
//        UIImage *image = [dict objectForKey:IQMediaImage];
    }
    else if ([dict objectForKey:IQMediaURL])
    {
        NSURL *url = [[[mediaInfo objectForKey:key] objectAtIndex:indexPath.row] objectForKey:IQMediaURL];

        MPMoviePlayerViewController *controller = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [self presentMoviePlayerViewControllerAnimated:controller];
    }
//
//    NSString *key = [[mediaInfo allKeys] objectAtIndex:indexPath.section];
//    
//    NSURL *url = [[[mediaInfo objectForKey:key] objectAtIndex:indexPath.row] objectForKey:IQMediaURL];
//    
//    if ([key isEqualToString:IQMediaTypeVideo])
//    {
//        MPMoviePlayerViewController *controller = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
//        [self presentMoviePlayerViewControllerAnimated:controller];
//    }
//    else if ([key isEqualToString:IQMediaTypeAudio])
//    {
//        MPMoviePlayerViewController *controller = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
//        [self presentMoviePlayerViewControllerAnimated:controller];
//    }
//    else if ([key isEqualToString:IQMediaTypeImage])
//    {
//        
//    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end

