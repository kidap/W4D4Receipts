//
//  Tag+CoreDataProperties.h
//  W4D4Receipts
//
//  Created by Karlo Pagtakhan on 03/31/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tagName;
@property (nullable, nonatomic, retain) NSSet<Receipt *> *receipts;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addReceiptsObject:(Receipt *)value;
- (void)removeReceiptsObject:(Receipt *)value;
- (void)addReceipts:(NSSet<Receipt *> *)values;
- (void)removeReceipts:(NSSet<Receipt *> *)values;

@end

NS_ASSUME_NONNULL_END
