//
//  filtrosCollectionVC.m
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 26/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import "filtrosCollectionVC.h"
#import "collectionViewCell.h"
#import "Fotos.h"

@interface filtrosCollectionVC ()

@property (strong, nonatomic) NSMutableArray *filtros;
@property (strong, nonatomic) CIContext *context;

@end

@implementation filtrosCollectionVC


-(NSMutableArray *)filtros
{
    if (!_filtros){
        _filtros = [[NSMutableArray alloc]init];
    }
    return _filtros;
}

-(CIContext *)context
{
    if (!_context){
        _context = [CIContext contextWithOptions:nil];
    }
    return _context;
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
    
    self.filtros = [[[self class] photosFilters] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - metodosAyuda

//UNO
+ (NSArray *)photosFilters
{
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:nil];
    
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:nil];
    
    CIFilter *colorClamp = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputMaxComponents", [CIVector vectorWithX:0.9 Y:0.9 Z:0.9 W:0.9], @"inputMinComponents", [CIVector vectorWithX:0.2 Y:0.2 Z:0.2 W:0.2], nil];
    
    CIFilter *instant = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues: nil];
    
    CIFilter *noir = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues:nil];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette" keysAndValues:nil];
    
    CIFilter *colorControls = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputSaturationKey, @0.5, nil];
    
    CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues:nil];
    
    CIFilter *unsharpen = [CIFilter filterWithName:@"CIunsharpenMask" keysAndValues:nil];
    
    CIFilter *monochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:nil];
    
    NSArray *filters = [[NSArray alloc]initWithObjects:sepia, blur, colorClamp, instant, noir, vignette, colorControls, transfer, unsharpen, monochrome, nil];
    
    return filters;
    
}

-(UIImage *)filteredImageFromImage:(UIImage *)image andFilter:(CIFilter *)filter
{
    CIImage *unfilteredImage = [[CIImage alloc]initWithCGImage:image.CGImage];
    
    [filter setValue:unfilteredImage forKey:kCIInputImageKey];
    
    CIImage *filteredImage = [filter outputImage];
    
    CGRect extent = [filteredImage extent];
    
    CGImageRef cgImage = [self.context createCGImage:filteredImage fromRect:extent];
    
    UIImage *finalImage = [UIImage imageWithCGImage:cgImage];
    
    NSLog(@"%@", UIImagePNGRepresentation(finalImage));
    
    return finalImage;
}

#pragma mark - metodosCollectionVC

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celda = @"Item";
    collectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:celda forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    dispatch_queue_t filterQueue = dispatch_queue_create("filter queue", NULL);
    
    dispatch_async(filterQueue, ^{
        UIImage *filterImage = [self filteredImageFromImage:self.foto.image andFilter:self.filtros[indexPath.row]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.image.image = filterImage;
        });
    });
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.filtros count];
}

#pragma mark - UICollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    collectionViewCell *selectedObject = (collectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.foto.image = selectedObject.image.image;
    
    if (self.foto.image){
    
    NSError *error = nil;
    
    if (![[self.foto managedObjectContext]save:&error]){
        //Handle error
    
    
    [self.navigationController popViewControllerAnimated:YES];
          }
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
