//
//  NSArray+YPSafeAccess.h
//  YPCoreKit
//
//  Created by Else on 2021/4/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (YPSafeAccess)

- (nullable ObjectType)yp_objectAtIndex:(NSUInteger)index;

- (NSUInteger)yp_indexOfObject:(id)object;

- (nullable NSString *)yp_stringAtIndex:(NSUInteger)index;

- (nullable NSNumber *)yp_numberAtIndex:(NSUInteger)index;

- (nullable NSDecimalNumber *)yp_decimalNumberAtIndex:(NSUInteger)index;

- (nullable NSArray *)yp_arrayAtIndex:(NSUInteger)index;

- (nullable NSDictionary *)yp_dictionaryAtIndex:(NSUInteger)index;

- (NSInteger)yp_integerAtIndex:(NSUInteger)index;

- (NSUInteger)yp_unsignedIntegerAtIndex:(NSUInteger)index;

- (BOOL)yp_boolAtIndex:(NSUInteger)index;

- (int16_t)yp_int16AtIndex:(NSUInteger)index;

- (int32_t)yp_int32AtIndex:(NSUInteger)index;

- (int64_t)yp_int64AtIndex:(NSUInteger)index;

- (char)yp_charAtIndex:(NSUInteger)index;

- (short)yp_shortAtIndex:(NSUInteger)index;

- (float)yp_floatAtIndex:(NSUInteger)index;

- (double)yp_doubleAtIndex:(NSUInteger)index;

- (CGFloat)yp_CGFloatAtIndex:(NSUInteger)index;

- (CGPoint)yp_pointAtIndex:(NSUInteger)index;

- (CGSize)yp_sizeAtIndex:(NSUInteger)index;

- (CGRect)yp_rectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (RMSafeAccess)

- (void)yp_addObject:(id)value;

- (void)yp_addObjectsFromArray:(NSArray *)value;

- (void)yp_addString:(NSString *)value;

- (void)yp_addBool:(BOOL)value;

- (void)yp_addInt:(int)value;

- (void)yp_addInteger:(NSInteger)value;

- (void)yp_addUnsignedInteger:(NSUInteger)value;

- (void)yp_addCGFloat:(CGFloat)value;

- (void)yp_addChar:(char)value;

- (void)yp_addFloat:(float)value;

- (void)yp_addPoint:(CGPoint)value;

- (void)yp_addSize:(CGSize)value;

- (void)yp_addRect:(CGRect)value;

- (void)yp_removeObject:(id)value;

- (void)yp_removeObjectAtIndex:(NSUInteger)index;

- (void)yp_insertObject:(id)anObject atIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
