//
//  Album.h
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 06/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fotos;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *fotos;
@end

@interface Album (CoreDataGeneratedAccessors)

- (void)addFotosObject:(Fotos *)value;
- (void)removeFotosObject:(Fotos *)value;
- (void)addFotos:(NSSet *)values;
- (void)removeFotos:(NSSet *)values;

@end
