//
//  CoreDateHandler.h
//  W4D4Receipts
//
//  Created by Karlo Pagtakhan on 03/31/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;
@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSFetchedResultsController;
@class Receipt;
@class Tag;

@interface CoreDataHandler : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(instancetype)sharedInstance;

-(void)addReceiptWithAmount:(double)amount
                       note:(NSString *)note
                  timestamp:(NSString *)timestamp
                       tags:(NSSet<Tag *> *)tags;
-(NSArray *)getAllReceipts;
-(NSArray *)getAllTags;
-(NSArray *)getReceiptsWithTag:(Tag *)tag;
-(Tag *)createTagWithName:(NSString *)tagName;
-(Tag *)createTagWithName:(NSString *)tagName receipts:(Receipt *)receipts;
-(void)deleteReceipt:(Receipt *)receipt;
@end
