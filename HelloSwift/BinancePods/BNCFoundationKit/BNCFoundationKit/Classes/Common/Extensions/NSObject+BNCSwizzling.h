//
//  NSObject+BNCSwizzling.h
//  Monitor
//
//  Created by cathy on 2020/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BNCSwizzling)

+ (void)bnc_swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;

+ (void)bnc_swizzleOriginalClass:(Class)originalCls
                     originalSEL:(SEL)originalSEL
                     targetClass:(Class)targetClass
                       targetSEL:(SEL)targetSEL;

+ (void)bnc_swizzleClassMethodClass:(Class)originalCls
                        originalSEL:(SEL)originalSEL
                        targetClass:(Class)targetClass
                          targetSEL:(SEL)targetSEL;



+ (SEL)swizzledSelectorForSelector:(SEL)selector;

+ (BOOL)instanceRespondsButDoesNotImplementSelector:(SEL)selector class:(Class)cls;

+ (void)replaceImplementationOfKnownSelector:(SEL)originalSelector
                                     onClass:(Class)cls
                                   withBlock:(id)block
                            swizzledSelector:(SEL)swizzledSelector;
+ (void)replaceImplementationOfSelector:(SEL)selector
                           withSelector:(SEL)swizzledSelector
                               forClass:(Class)cls
                  withMethodDescription:(struct objc_method_description)methodDescription
                    implementationBlock:(id)implementationBlock
                         undefinedBlock:(id)undefinedBlock;

@end

NS_ASSUME_NONNULL_END
