//
//  collectionViewCell.m
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 06/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import "collectionViewCell.h"
#define IMAGE_BORDER_LENGHT 5

@implementation collectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.image = [[UIImageView alloc]initWithFrame:CGRectInset(self.bounds, IMAGE_BORDER_LENGHT, IMAGE_BORDER_LENGHT)];
    [self.contentView addSubview:self.image];
}

@end
