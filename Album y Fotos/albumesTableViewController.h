//
//  albumesTableViewController.h
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 06/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface albumesTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *albumes;

- (IBAction)botonAdd:(UIBarButtonItem *)sender;

@end
