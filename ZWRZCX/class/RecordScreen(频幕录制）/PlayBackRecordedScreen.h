


@interface PlayBackRecordedScreen : UIView{
    UIView *header;
}

@property(retain,nonatomic)MPMoviePlayerController *player;

-(id)initWithFrame:(CGRect)frame andParentView:(UIView*)parentView;
@end
