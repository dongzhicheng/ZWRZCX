

#import "IQSongsPlaylistViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "IQSongsListViewController.h"
#import "IQAudioPickerUtility.h"
#import "IQAudioPickerController.h"
#import "IQMediaPickerControllerConstants.h"

@implementation IQSongsPlaylistViewController
{
    NSArray *playlists;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Playlists";
        self.tabBarItem.image = [UIImage imageNamed:@"playlists"];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = 60;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];

    MPMediaQuery *query = [MPMediaQuery playlistsQuery];
//    [query setGroupingType:MPMediaGroupingPlaylist];

    playlists = [query collections];

    if (self.audioPickerController.allowsPickingMultipleItems == NO)
    {
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction:)];
        self.navigationItem.rightBarButtonItem = cancelItem;
    }
    else
    {
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
        self.navigationItem.rightBarButtonItem = doneItem;
    }
}

-(void)doneAction:(UIBarButtonItem*)item
{
    if ([self.audioPickerController.delegate respondsToSelector:@selector(audioPickerController:didPickMediaItems:)])
    {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        for (MPMediaItem *item in self.audioPickerController.selectedItems)
        {
            NSDictionary *dict = [NSDictionary dictionaryWithObject:item forKey:IQMediaItem];
            
            [items addObject:dict];
        }
        
        [self.audioPickerController.delegate audioPickerController:self.audioPickerController didPickMediaItems:items];
    }
    
    [self.audioPickerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelAction:(UIBarButtonItem*)item
{
    if ([self.audioPickerController.delegate respondsToSelector:@selector(audioPickerControllerDidCancel:)])
    {
        [self.audioPickerController.delegate audioPickerControllerDidCancel:self.audioPickerController];
    }
    
    [self.audioPickerController dismissViewControllerAnimated:YES completion:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return playlists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    
    MPMediaPlaylist *item = [playlists objectAtIndex:indexPath.row];
    cell.textLabel.text = [item valueForProperty:MPMediaPlaylistPropertyName];
    
    if (item.items.count == 0)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"no songs"];
    }
    else
    {
        NSUInteger totalMinutes = [IQAudioPickerUtility mediaCollectionDuration:item];

        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu %@, %lu %@",(unsigned long)item.count,(item.count>1?@"songs":@"song"),(unsigned long)totalMinutes,(totalMinutes>1?@"mins":@"min")];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IQSongsListViewController *controller = [[IQSongsListViewController alloc] init];
    controller.audioPickerController = self.audioPickerController;
    
    MPMediaPlaylist *item = [playlists objectAtIndex:indexPath.row];
    
    controller.title = [item valueForProperty:MPMediaPlaylistPropertyName];
    controller.collections = @[item];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
