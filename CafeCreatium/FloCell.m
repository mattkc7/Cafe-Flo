//
//  FloCell.m
//  CafeCreatium
//
//  Created by Matthew on 7/31/13.
//  Copyright (c) 2013 Matthew. All rights reserved.
//


#import "FloCell.h"

@implementation FloCell

-(id)init{
    self = [super init];
    
    if (self) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(74, 0, 175, 65)];
        imgView.image = [UIImage imageNamed:@"cafeFlo-c.png"];
        [self.contentView addSubview:imgView];
    }
    
    return self;
}

- (void)layoutSubViews
{

}

@end
