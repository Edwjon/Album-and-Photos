//
//  collectionViewController.h
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 06/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface collectionViewController : UICollectionViewController

@property (strong, nonatomic) NSMutableArray *fotos;

@property (strong, nonatomic) Album *album;

- (IBAction)botonCamara:(UIBarButtonItem *)sender;

@end
