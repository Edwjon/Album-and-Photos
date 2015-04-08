//
//  Fotos.h
//  Album y Fotos
//
//  Created by Edward Pizzurro Fortun on 06/08/14.
//  Copyright (c) 2014 Edwjon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Fotos : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Album *album;

@end
