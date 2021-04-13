//
//  NSArray+YPSafeAccess.m
//  YPCoreKit
//
//  Created by Else on 2021/4/7.
//

#import "NSArray+YPSafeAccess.h"

@implementation NSArray (YPSafeAccess)

- (nullable id)yp_objectAtIndex:(NSUInteger)index {
    if (index >= 0 && index < self.count) {
        return [self objectAtIndex:index];
    } else {
        return nil;
    }
}

- (NSUInteger)yp_indexOfObject:(id)object {
    if (object) {
        return [self indexOfObject:object];
    }
    return NSNotFound;
}

- (nullable NSString *)yp_stringAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:[NSString class]] && ![[value description] isEqualToString:@"<null>"]) {
        return (NSString *)value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

- (nullable NSNumber *)yp_numberAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSNumber.class]) {
        return (NSNumber *)value;
    } else if ([value isKindOfClass:NSString.class]) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        return [formatter numberFromString:(NSString *)value];
    }
    return nil;
}

- (nullable NSDecimalNumber *)yp_decimalNumberAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:NSNumber.class]) {
        NSNumber *number = (NSNumber *)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:NSString.class]) {
        NSString *str = (NSString *)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}

- (nullable NSArray *)yp_arrayAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSArray.class]) {
        return value;
    } else if ([value isKindOfClass:NSString.class]) {
        NSArray *newValue = [NSJSONSerialization JSONObjectWithData:[((NSString *)value) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if ([newValue isKindOfClass:NSArray.class]) {
            return newValue;
        }
    }
    return nil;
}

- (nullable NSDictionary *)yp_dictionaryAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSDictionary.class]) {
        return value;
    } else if ([value isKindOfClass:NSString.class]) {
        NSDictionary *newValue = [NSJSONSerialization JSONObjectWithData:[((NSString *)value) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if ([newValue isKindOfClass:NSDictionary.class]) {
            return newValue;
        }
    }
    return nil;
}

- (NSInteger)yp_integerAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSString.class] || [value isKindOfClass:NSNumber.class]) {
        return [value integerValue];
    }
    return 0;
}

- (NSUInteger)yp_unsignedIntegerAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSString.class] || [value isKindOfClass:NSNumber.class]) {
        return [value unsignedIntegerValue];
    }
    return 0;
}

- (BOOL)yp_boolAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSString.class] || [value isKindOfClass:NSNumber.class]) {
        return [value boolValue];
    }
    return NO;
}

- (int16_t)yp_int16AtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSNumber.class]) {
        return [value shortValue];
    } else if ([value isKindOfClass:NSString.class]) {
        return [value intValue];
    }
    return 0;
}

- (int32_t)yp_int32AtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:NSString.class]) {
        return [value intValue];
    }
    return 0;
}

- (int64_t)yp_int64AtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:NSString.class]) {
        return [value longLongValue];
    }
    return 0;
}

- (char)yp_charAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:NSString.class]) {
        return [value charValue];
    }
    return 0;
}

- (short)yp_shortAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSNumber.class]) {
        return [value shortValue];
    } else if ([value isKindOfClass:NSString.class]) {
        return [value intValue];
    }
    return 0;
}

- (float)yp_floatAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:NSString.class]) {
        return [value floatValue];
    }
    return 0;
}

- (double)yp_doubleAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:NSString.class]) {
        return [value doubleValue];
    }
    return 0;
}

- (CGFloat)yp_CGFloatAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:NSString.class]) {
#if CGFLOAT_IS_DOUBLE
        return [value doubleValue];
#else
        return [value floatValue];
#endif
    }
    return 0;
}

- (CGPoint)yp_pointAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSValue.class]) {
        return [value CGPointValue];
    }
    return CGPointMake(0, 0);
}

- (CGSize)yp_sizeAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSValue.class]) {
        return [value CGSizeValue];
    }
    return CGSizeMake(0, 0);
}

- (CGRect)yp_rectAtIndex:(NSUInteger)index {
    id value = [self yp_objectAtIndex:index];
    if ([value isKindOfClass:NSValue.class]) {
        return [value CGRectValue];
    }
    return CGRectZero;
}

@end

@implementation NSMutableArray (RMSafeAccess)

- (void)yp_addObjectsFromArray:(NSArray *)value {
    if (value && [value isKindOfClass:NSArray.class]) {
        [self addObjectsFromArray:value];
    }
}

- (void)yp_addObject:(id)value {
    if (value) {
        [self addObject:value];
    }
}

- (void)yp_addString:(NSString *)value {
    if (value && [value isKindOfClass:[NSString class]]) {
        [self yp_addObject:value];
    }
}

- (void)yp_addBool:(BOOL)value {
    [self yp_addObject:@((BOOL)value)];
}

- (void)yp_addInt:(int)value {
    [self yp_addObject:@(value)];
}

- (void)yp_addInteger:(NSInteger)value {
    [self yp_addObject:@(value)];
}

- (void)yp_addUnsignedInteger:(NSUInteger)value {
    [self yp_addObject:@(value)];
}

- (void)yp_addCGFloat:(CGFloat)value {
    [self yp_addObject:@(value)];
}

- (void)yp_addChar:(char)value {
    [self yp_addObject:@(value)];
}

- (void)yp_addFloat:(float)value {
    [self yp_addObject:@(value)];
}

- (void)yp_addPoint:(CGPoint)value {
    [self yp_addObject:[NSValue valueWithCGPoint:value]];
}

- (void)yp_addSize:(CGSize)value {
    [self yp_addObject:[NSValue valueWithCGSize:value]];
}

- (void)yp_addRect:(CGRect)value {
    [self yp_addObject:[NSValue valueWithCGRect:value]];
}

- (void)yp_removeObject:(id)value {
    if (value) {
        [self removeObject:value];
    }
}

- (void)yp_removeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

- (void)yp_insertObject:(id)object atIndex:(NSUInteger)index {
    if (object && index <= self.count) {
        [self insertObject:object atIndex:index];
    }
}

@end
