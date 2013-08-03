//
//  AmbienceViewController.h
//  CafeCreatium
//
//  Created by Matthew on 7/29/13.
//  Copyright (c) 2013 Matthew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AmbienceViewController : UIViewController <AVAudioPlayerDelegate>

@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) UIButton *button;
@property (nonatomic, retain) UIImageView *backgroundImage;
@property (nonatomic, retain) AVAudioPlayer *theAudio;

@property (nonatomic, retain) UIImageView *imgView;

-(void)specialViewDidLoad;
-(void)setCustomImages;
@end
