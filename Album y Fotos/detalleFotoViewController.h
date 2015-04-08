//
//  detalleFotoViewController.h
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 07/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Fotos;

@interface detalleFotoViewController : UIViewController

@property (strong, nonatomic) Fotos *foto;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)botonAddFilter:(UIButton *)sender;

- (IBAction)botonDelete:(UIButton *)sender;

@end
