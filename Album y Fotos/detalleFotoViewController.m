//
//  detalleFotoViewController.m
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 07/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import "detalleFotoViewController.h"
#import "Fotos.h"
#import "filtrosCollectionVC.h"

@interface detalleFotoViewController ()

@end

@implementation detalleFotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Filtros"]){
        if ([segue.destinationViewController isKindOfClass:[filtrosCollectionVC class]]){
            filtrosCollectionVC *filtrosCVC = segue.destinationViewController;
            filtrosCVC.foto = self.foto;
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.imageView.image = self.foto.image;
}

- (IBAction)botonAddFilter:(UIButton *)sender
{
    
}


- (IBAction)botonDelete:(id)sender
{
    [[self.foto managedObjectContext]deleteObject:self.foto];
    
    NSError *error = nil;
    
    [[self.foto managedObjectContext]save:&error];

    if (error){
        NSLog(@"error");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
