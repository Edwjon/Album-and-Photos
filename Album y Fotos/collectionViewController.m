//
//  collectionViewController.m
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 06/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import "collectionViewController.h"
#import "collectionViewCell.h"
#import "Fotos.h"
#import "PictureDataTransformer.h"
#import "ayudaNSManagedObject.h"
#import "detalleFotoViewController.h"


@interface collectionViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation collectionViewController

-(NSMutableArray *)fotos
{
    if (!_fotos){
        _fotos = [[NSMutableArray alloc]init];
    }
    return _fotos;
}

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - viewWillAppear (Para que definitivo se remueva la imagen cuando le damos a delete)

//ESTO LO CORTAMOS DE VEWDIDLOAD Y LO PEGAMOS AQUI
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //Metodo para guardado de fotos (y para remover las imagenes, junto con otros metodos)
    NSSet *unorderPhotos = self.album.fotos;
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortedPhotos = [unorderPhotos sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.fotos = [sortedPhotos mutableCopy];
    
    [self.collectionView reloadData];
    
}

#pragma mark - prepareForSegue


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"paraFoto"]){
        if ([segue.destinationViewController isKindOfClass:[detalleFotoViewController class]]){
            detalleFotoViewController *detalleFoto = segue.destinationViewController;
            NSIndexPath *path = [[self.collectionView indexPathsForSelectedItems]lastObject];
            
            Fotos *foto = self.fotos[path.row];
            detalleFoto.foto = foto;
        }
    }
}

#pragma mark - botonCamara

- (IBAction)botonCamara:(UIBarButtonItem *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType= UIImagePickerControllerSourceTypeCamera;
    }
    
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self presentViewController:picker animated:YES completion:nil];

}

#pragma mark - metodoGuardarFoto (y ayuda para el metodo pickerDelegate didFinishPicking...)

-(Fotos *)fotosForImage:(UIImage *)image
{
    Fotos *foto= [NSEntityDescription insertNewObjectForEntityForName:@"Fotos" inManagedObjectContext:[ayudaNSManagedObject managedObjectContext]];
    foto.image = image;
    foto.date= [NSDate date];
    foto.album = self.album;
    
    NSError *error = nil;
    if (![[foto managedObjectContext] save:&error]){
        //Error in saving
        
    }
    return foto;
}

#pragma mark - metodosCollectionViewController

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.fotos count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *item = @"Cell";
    collectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item forIndexPath:indexPath];
    
    //Esta linea de codigo se hace despues de haber implementado varios metodos
    Fotos *foto = self.fotos[indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.image.image = foto.image;
    
    return cell;
}

#pragma mark - metodosUIImagePickerVC

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) image = info[UIImagePickerControllerOriginalImage];
    
    [self.fotos addObject:[self fotosForImage:image]];
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
