//
//  AmbienceViewController.m
//  CafeCreatium
//
//  Created by Matthew on 7/29/13.
//  Copyright (c) 2013 Matthew. All rights reserved.
//

#import "AppDelegate.h"
#import "AmbienceViewController.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "DKLiveBlurView.h"
#import "FloCell.h"

#define kDKTableViewDefaultCellHeight 50.0f
#define kDKTableViewDefaultContentInset 420.0f

@interface AmbienceViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation AmbienceViewController
{
    BOOL audioPlaying;
}
@synthesize button, backgroundImage;
@synthesize imgView;
@synthesize tableView = _tableView;
@synthesize items = _items;
@synthesize theAudio = _theAudio;

-(id)init
{
    self = [super init];
    
    if (self) {
        //self.view.backgroundColor = [UIColor redColor];
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        CGFloat screenWidth = screenSize.width;
        CGFloat screenHeight = screenSize.height;
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(200.0, screenHeight-240, 90.0, 165.0);
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"grande-cup-play.png"];
        [self.button setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"grande-cup-pause.png"] forState:UIControlStateSelected];
        [self.button addTarget:self action:@selector(doStuff) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.button];
        
        self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3z.jpeg"]];
        self.backgroundImage.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        [self.view addSubview:self.backgroundImage];
        [self.view sendSubviewToBack:self.backgroundImage];
        
        audioPlaying = NO;
        
    }
    
    return self;
}

-(void)setCustomImages
{
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    //CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    if (self.index == 0) {
        [self theAudio];
    }
    
    if (self.index == 1) {
        UIImage *buttonImageNormal = [UIImage imageNamed:@"coffee-cup-ipod.png"];
        [self.button setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
        self.button.frame = CGRectMake(200.0, screenHeight-225, 99.0, 160.0);
        
        self.backgroundImage.image = [UIImage imageNamed:@"2z.jpeg"];
    }
    
    if (self.index == 2) {
        [self.button removeFromSuperview];
    }
}

-(void)modifyButtonState
{
    self.button.imageView.image = nil;
    
    if ([self.button isSelected]) {
        [self.button setImage:[UIImage imageNamed:@"grande-cup-play.png"] forState:UIControlStateNormal];
        [self.button setSelected:NO];
    } else {
        [self.button setImage:[UIImage imageNamed:@"grande-cup-pause.png"] forState:UIControlStateSelected];
        [self.button setSelected:YES];
    }
}

-(void)playOrStopAudio
{

    if ([self.theAudio isPlaying]) {
        [self.theAudio stop];
    } else {
        [self.theAudio play];
    }

}

-(void)doStuff
{
    if (self.index == 0) {
        [self modifyButtonState];
        [self playOrStopAudio];
    } else if (self.index == 1) {
        //open itunes app http://itunes.apple.com/
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"music://"]];
        
    }
    
}

-(AVAudioPlayer *)theAudio
{
    if (_theAudio == nil) {
        NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"cafeC" ofType:@"mp3"];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        NSError *error;
        _theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
        [_theAudio setDelegate:self];
        [_theAudio setNumberOfLoops:-1];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        UInt32 doSetProperty = 1;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof(doSetProperty), &doSetProperty);
        
        [_theAudio setVolume:1.0];
        [_theAudio prepareToPlay];
        
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
    
    return _theAudio;
}

-(void)viewDidLoad
{
    
}

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray new];

        [_items addObject:@"Cafe.Flo"];
        NSString *bio = @"It's about you and the flow. Nothing else.\n";
        [_items addObject:bio];
        
        NSString *by = @"Brought to you by\nMatthew Chan and Jonathan Sevold";
        [_items addObject:by];
        
    }
    return _items;
}

-(void)specialViewDidLoad
{
    self.theAudio = nil;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = kDKTableViewDefaultCellHeight;
    
    DKLiveBlurView *backgroundView = [[DKLiveBlurView alloc] initWithFrame: self.view.bounds];
    
    backgroundView.originalImage = [UIImage imageNamed:@"photo 2a.JPG"];
    backgroundView.scrollView = self.tableView;
    backgroundView.isGlassEffectOn = YES;
    
    self.tableView.backgroundView = backgroundView;
    self.tableView.contentInset = UIEdgeInsetsMake(kDKTableViewDefaultContentInset, 0, 0, 0);
    
    [self.view addSubview: self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    FloCell *floCell = [tableView dequeueReusableCellWithIdentifier:@"flo"];
    
    if ([indexPath row] == 0) {
        if (floCell == nil) {
            floCell = [[FloCell alloc] init];
            //[floCell layoutSubviews];
            return floCell;
        } else {
            return floCell;
        }
    }
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = self.items[indexPath.row];
    
//    if ([indexPath row] == 0) {
//        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        cell.textLabel.numberOfLines = 0;
//        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40.0];
//    }
    
    if ([indexPath row] == 1) {
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    }
    
    if ([indexPath row] == 2) {
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0) {
        return 53;
    } else {
        return 90;
    }
}



@end
