//
//  albumesTableViewController.m
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 06/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import "albumesTableViewController.h"
#import "Album.h"
#import "ayudaNSManagedObject.h"
#import "collectionViewController.h"

@interface albumesTableViewController ()

@end

@implementation albumesTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - prepareForSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Album escogido"]){
        if ([segue.destinationViewController isKindOfClass:[collectionViewController class]]){
            NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            
            collectionViewController *collectionVC = segue.destinationViewController;
            collectionVC.album = self.albumes[path.row];
            
        }
    }
}

#pragma mark - botonAdd

- (IBAction)botonAdd:(UIBarButtonItem *)sender
{
    UIAlertView *alerta = [[UIAlertView alloc]initWithTitle:@"Album" message:@"Enter the name of a new album" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [alerta setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alerta show];
}

#pragma mark - metodosUIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){
        NSString *alertText = [alertView textFieldAtIndex:0].text;
        
        [self.albumes addObject:[self albumWithName:alertText]];
        NSIndexPath *path = [NSIndexPath indexPathForRow:[self.albumes count] -1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - guardarAlbum (y ayuda para el metodo clickedbutton...)

-(Album *)albumWithName:(NSString *)name
{
    NSManagedObjectContext *context = [ayudaNSManagedObject managedObjectContext];
    
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error = nil;
    
    if ([context save:&error]){
        //we have an error
    }
    return album;
}

#pragma mark - coreData

-(void)viewWillAppear:(BOOL)animated
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    NSManagedObjectContext *context = [ayudaNSManagedObject managedObjectContext];
    
    NSError *error = nil;
    
    NSArray *fetchedAlbumes = [context executeFetchRequest:fetchRequest error:&error];
    
    self.albumes = [fetchedAlbumes mutableCopy];
    
    [self.tableView reloadData];
}

#pragma mark - metodosTableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.albumes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celda = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celda forIndexPath:indexPath];
    
    Album *album = self.albumes[indexPath.row];
    cell.textLabel.text = album.name;
    
    
    return cell;
}


@end
