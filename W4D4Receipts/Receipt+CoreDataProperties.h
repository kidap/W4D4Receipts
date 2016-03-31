//
//  Receipt+CoreDataProperties.h
//  W4D4Receipts
//
//  Created by Karlo Pagtakhan on 03/31/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Receipt.h"

NS_ASSUME_NONNULL_BEGIN

@interface Receipt (CoreDataProperties)

@property (nonatomic) double amount;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSString *timestamp;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *tag;

@end

@interface Receipt (CoreDataGeneratedAccessors)

- (void)addTagObject:(NSManagedObject *)value;
- (void)removeTagObject:(NSManagedObject *)value;
- (void)addTag:(NSSet<NSManagedObject *> *)values;
- (void)removeTag:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
