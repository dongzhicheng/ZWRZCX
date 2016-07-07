
#import "IQAudioPickerController.h"
#import <MediaPlayer/MediaPlayer.h>

#import "IQSongsPlaylistViewController.h"
#import "IQSongsArtistListViewController.h"
#import "IQSongsListViewController.h"
#import "IQSongsAlbumListViewController.h"
#import "IQSongsGenreViewController.h"
#import "IQSongsComposersViewController.h"
#import "IQSongsCompilationsViewController.h"

@interface IQAudioPickerController ()<UITabBarControllerDelegate>

@end

@implementation IQAudioPickerController
{
    BOOL _previousNavigationBarHidden;
}

@dynamic delegate;

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setTintColor:[UIColor purpleColor]];
    _selectedItems = [[NSMutableSet alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    _previousNavigationBarHidden = self.navigationController.navigationBarHidden;
    self.navigationController.navigationBarHidden = YES;
    
    IQSongsPlaylistViewController *playlistController = [[IQSongsPlaylistViewController alloc] init];
    IQSongsArtistListViewController *artistController = [[IQSongsArtistListViewController alloc] init];
    IQSongsListViewController *songsController = [[IQSongsListViewController alloc] init];
    IQSongsAlbumListViewController *albumsController = [[IQSongsAlbumListViewController alloc] init];
    IQSongsGenreViewController *genreController = [[IQSongsGenreViewController alloc] init];
    IQSongsCompilationsViewController *compilationsController = [[IQSongsCompilationsViewController alloc] init];
    IQSongsComposersViewController *composersController = [[IQSongsComposersViewController alloc] init];

    playlistController.audioPickerController = self;
    artistController.audioPickerController = self;
    songsController.audioPickerController = self;
    composersController.audioPickerController = self;
    compilationsController.audioPickerController = self;
    genreController.audioPickerController = self;
    albumsController.audioPickerController = self;

    self.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:playlistController],
                             [[UINavigationController alloc] initWithRootViewController:artistController],
                             [[UINavigationController alloc] initWithRootViewController:songsController],
                             [[UINavigationController alloc] initWithRootViewController:albumsController],
                             [[UINavigationController alloc] initWithRootViewController:genreController],
                             [[UINavigationController alloc] initWithRootViewController:compilationsController],
                             [[UINavigationController alloc] initWithRootViewController:composersController],
                             ];
    [self setSelectedIndex:2];
    self.customizableViewControllers = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = _previousNavigationBarHidden;
}

@end
