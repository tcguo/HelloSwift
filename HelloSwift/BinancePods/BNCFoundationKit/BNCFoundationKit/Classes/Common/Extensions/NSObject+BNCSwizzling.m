//
//  NSObject+BNCSwizzling.m
//  Monitor
//
//  Created by cathy on 2020/6/24.
//

#import "NSObject+BNCSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (BNCSwizzling)


+ (void)bnc_swizzleOriginalClass:(Class)originalCls originalSEL:(SEL)originalSEL targetClass:(Class)targetClass targetSEL:(SEL)targetSEL{


    NSParameterAssert(originalCls);
    NSParameterAssert(originalSEL);
    NSParameterAssert(targetClass);
    NSParameterAssert(targetSEL);

    if ([originalCls instancesRespondToSelector:targetSEL]) return;


    Method targetMethod   = class_getInstanceMethod(targetClass, targetSEL);
    BOOL didAddMethod     = class_addMethod(originalCls,targetSEL,method_getImplementation(targetMethod),method_getTypeEncoding(targetMethod));

    if (didAddMethod) {

        Method originalMethod = class_getInstanceMethod(originalCls, originalSEL);
        Method swizzledMethod = class_getInstanceMethod(originalCls, targetSEL);
        method_exchangeImplementations(originalMethod, swizzledMethod);

    }

}

+ (void)bnc_swizzleClassMethodClass:(Class)originalCls
                           originalSEL:(SEL)originalSEL
                           targetClass:(Class)targetClass
                             targetSEL:(SEL)targetSEL{


    NSParameterAssert(originalCls);
    NSParameterAssert(targetClass);
    NSParameterAssert(originalSEL);
    NSParameterAssert(targetSEL);

    if ([originalCls instancesRespondToSelector:targetSEL]){
        return;
    }

    Method targetMethod = class_getClassMethod(targetClass, targetSEL);

    BOOL didAddMethod  = class_addMethod(object_getClass(originalCls),targetSEL,method_getImplementation(targetMethod),method_getTypeEncoding(targetMethod));

    if (didAddMethod) {

        Method originalMethod = class_getClassMethod(object_getClass(originalCls), originalSEL);
        Method swizzledMethod = class_getClassMethod(object_getClass(originalCls), targetSEL);
        method_exchangeImplementations(originalMethod, swizzledMethod);

    }

}

+ (void)bnc_swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL {
    Class class = [self class];

    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);

    BOOL didAddMethod =
    class_addMethod(class,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (SEL)swizzledSelectorForSelector:(SEL)selector
{
  return NSSelectorFromString([NSString stringWithFormat:@"_bnc_swizzle_%x_%@", arc4random(), NSStringFromSelector(selector)]);
}

+ (BOOL)instanceRespondsButDoesNotImplementSelector:(SEL)selector class:(Class)cls
{
  if ([cls instancesRespondToSelector:selector]) {
    unsigned int numMethods = 0;
    Method *methods = class_copyMethodList(cls, &numMethods);

    BOOL implementsSelector = NO;
    for (int index = 0; index < numMethods; index++) {
      SEL methodSelector = method_getName(methods[index]);
      if (selector == methodSelector) {
        implementsSelector = YES;
        break;
      }
    }

    free(methods);

    if (!implementsSelector) {
      return YES;
    }
  }

  return NO;
}

+ (void)replaceImplementationOfKnownSelector:(SEL)originalSelector onClass:(Class)cls withBlock:(id)block swizzledSelector:(SEL)swizzledSelector
{
  // This method is only intended for swizzling methods that are know to exist on the class.
  // Bail if that isn't the case.
  Method originalMethod = class_getInstanceMethod(cls, originalSelector);
  if (!originalMethod) {
    return;
  }

  IMP implementation = imp_implementationWithBlock(block);
  class_addMethod(cls, swizzledSelector, implementation, method_getTypeEncoding(originalMethod));
  Method newMethod = class_getInstanceMethod(cls, swizzledSelector);
  method_exchangeImplementations(originalMethod, newMethod);
}

+ (void)replaceImplementationOfSelector:(SEL)selector withSelector:(SEL)swizzledSelector forClass:(Class)cls withMethodDescription:(struct objc_method_description)methodDescription implementationBlock:(id)implementationBlock undefinedBlock:(id)undefinedBlock
{
  if ([self instanceRespondsButDoesNotImplementSelector:selector class:cls]) {
    return;
  }

  IMP implementation = imp_implementationWithBlock((id)([cls instancesRespondToSelector:selector] ? implementationBlock : undefinedBlock));

  Method oldMethod = class_getInstanceMethod(cls, selector);
  if (oldMethod) {
    class_addMethod(cls, swizzledSelector, implementation, methodDescription.types);

    Method newMethod = class_getInstanceMethod(cls, swizzledSelector);

    method_exchangeImplementations(oldMethod, newMethod);
  } else {
    class_addMethod(cls, selector, implementation, methodDescription.types);
  }
}



@end
