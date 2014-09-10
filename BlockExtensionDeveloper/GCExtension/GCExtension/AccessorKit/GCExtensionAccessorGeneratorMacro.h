//
//  GCExtensionAccessorGeneratorMacro.h
//  GCExtension
//
//  Created by njgarychow on 14-8-22.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#ifndef GCExtension_GCExtensionAccessorGeneratorMacro_h
#define GCExtension_GCExtensionAccessorGeneratorMacro_h

#import <objc/runtime.h>
#import "GCExtensionAccessorWrapper.h"


/**
 *
 *  First, must expand macro: GCExtensionClassAccessorGenerator(ClassName)
 *  Then, there is 6 macro to expand.
 *  GCExtensionClassNonatomicStrongAccessorGenerator(ClassName, ...)
 *  GCExtensionClassNonatomicCopyAccessorGenerator(ClassName, ...)
 *  GCExtensionClassNonatomicWeakAccessorGenerator(ClassName, ...)
 *  GCExtensionClassAtomicStrongAccessorGenerator(ClassName, ...)
 *  GCExtensionClassAtomicCopyAccessorGenerator(ClassName, ...)
 *  GCExtensionClassAtomicWeakAccessorGenerator(ClassName, ...)
 *
 *  ClassName is your Class's name which want to add extension properties.
 *
 *  ... is the properties' names. don't using "" to quote them. Just text them.
 *  for example, GCExtensionClassAtomicWeakAccessorGenerator(UITableView, blockForCanEditRow)
 */



#define GCExtensionClassNonatomicCopyAccessorGenerator(ClassName, ...) \
GCExtensionClassAccessorGeneratorCode(nonatomic_copy_setter, nonatomic_copy_getter, NonatomicCopy, ClassName, __VA_ARGS__)

#define GCExtensionClassNonatomicStrongAccessorGenerator(ClassName, ...)    \
GCExtensionClassAccessorGeneratorCode(nonatomic_strong_setter, nonatomic_strong_getter, NonatomicStrong, ClassName, __VA_ARGS__)

#define GCExtensionClassNonatomicWeakAccessorGenerator(ClassName, ...)    \
GCExtensionClassAccessorGeneratorCode(nonatomic_weak_setter, nonatomic_weak_getter, NonatomicWeak, ClassName, __VA_ARGS__)

#define GCExtensionClassAtomicStrongAccessorGenerator(ClassName, ...)    \
GCExtensionClassAccessorGeneratorCode(atomic_strong_setter, atomic_strong_getter, AtomicStrong, ClassName, __VA_ARGS__)

#define GCExtensionClassAtomicCopyAccessorGenerator(ClassName, ...)    \
GCExtensionClassAccessorGeneratorCode(atomic_copy_setter, atomic_copy_getter, AtomicCopy, ClassName, __VA_ARGS__)

#define GCExtensionClassAtomicWeakAccessorGenerator(ClassName, ...)    \
GCExtensionClassAccessorGeneratorCode(atomic_weak_setter, atomic_weak_getter, AtomicWeak, ClassName, __VA_ARGS__)










#define GCExtensionClassAccessorGenerator(ClassName)    \
@implementation ClassName (GCExtensionAccessor)     \
- (NSMutableDictionary *)properties {           \
static char const PropertyDictionaryKey;        \
NSMutableDictionary* propertiesDic = objc_getAssociatedObject(self, &PropertyDictionaryKey);        \
if (!propertiesDic) {       \
propertiesDic = [NSMutableDictionary dictionary];           \
objc_setAssociatedObject(self, &PropertyDictionaryKey, propertiesDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);   \
}       \
return propertiesDic;       \
}       \
- (void)_setPropertyThroughoutSelector:(SEL)selector property:(id)property {        \
NSString* propertyKey = getPropertiesKeyStringWithGetOrSetSelector(selector);   \
if (property) {         \
[[self properties] setObject:property forKey:propertyKey];      \
}       \
else {          \
[[self properties] removeObjectForKey:propertyKey];     \
}   \
}       \
- (id)_getPropertyThroughoutSelector:(SEL)selector {        \
NSString* blockKey = getPropertiesKeyStringWithGetOrSetSelector(selector);      \
return [[self properties] objectForKey:blockKey];           \
}       \
static NSString * getPropertiesKeyStringWithGetOrSetSelector(SEL selector) {       \
NSString* selectorName = [NSStringFromSelector(selector) lowercaseString];  \
return [selectorName    \
stringByReplacingOccurrencesOfString:@"(^set|:)"    \
withString:@""  \
options:NSRegularExpressionSearch       \
range:NSMakeRange(0, [selectorName length])];       \
}           \
static void nonatomic_strong_setter(id self, SEL _cmd, id property) {      \
GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];    \
wrapper.nonatomic_strong_property = property;       \
[self _setPropertyThroughoutSelector:_cmd property:wrapper];        \
}       \
static id nonatomic_strong_getter(id self, SEL _cmd) {     \
GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];   \
return wrapper.nonatomic_strong_property;   \
}   \
static void nonatomic_copy_setter(id self, SEL _cmd, id property) {    \
GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];    \
wrapper.nonatomic_copy_property = property; \
[self _setPropertyThroughoutSelector:_cmd property:wrapper];    \
}   \
static id nonatomic_copy_getter(id self, SEL _cmd) {   \
GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];   \
return wrapper.nonatomic_copy_property; \
}   \
static void nonatomic_weak_setter(id self, SEL _cmd, id property) {        \
GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];    \
wrapper.nonatomic_weak_property = property; \
[self _setPropertyThroughoutSelector:_cmd property:wrapper];    \
}   \
static id nonatomic_weak_getter(id self, SEL _cmd) {   \
GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];   \
return wrapper.nonatomic_weak_property; \
}   \
static void atomic_strong_setter(id self, SEL _cmd, id property) { \
GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];    \
wrapper.atomic_strong_property = property;  \
[self _setPropertyThroughoutSelector:_cmd property:wrapper];    \
}   \
static id atomic_strong_getter(id self, SEL _cmd) {    \
GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];   \
return wrapper.atomic_strong_property;  \
}   \
static void atomic_copy_setter(id self, SEL _cmd, id property) {   \
GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];    \
wrapper.atomic_copy_property = property;    \
[self _setPropertyThroughoutSelector:_cmd property:wrapper];    \
}   \
static id atomic_copy_getter(id self, SEL _cmd) {  \
GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];   \
return wrapper.atomic_copy_property;    \
}   \
static void atomic_weak_setter(id self, SEL _cmd, id property) {   \
GCExtensionAccessorWrapper* wrapper = [[GCExtensionAccessorWrapper alloc] init];    \
wrapper.atomic_weak_property = property;    \
[self _setPropertyThroughoutSelector:_cmd property:wrapper];    \
}   \
static id atomic_weak_getter(id self, SEL _cmd) {  \
GCExtensionAccessorWrapper* wrapper = [self _getPropertyThroughoutSelector:_cmd];   \
return wrapper.atomic_weak_property;    \
}   \
static SEL propertyGetterSelector(NSString* propertyString) {  \
return NSSelectorFromString(propertyString);    \
}   \
static SEL propertySetterSelector(NSString* propertyString) {  \
NSString* head = [propertyString substringToIndex:1];   \
NSString* rest = [propertyString substringFromIndex:1]; \
return NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [head uppercaseString], rest]); \
};  \
\
@end

#define GCExtensionClassAccessorGeneratorCode(setterName, getterName, type, ClassName, ...)  \
@implementation ClassName (GCExtension ## type ## Accessor)      \
+ (void)load {              \
const char* propertiesNames = #__VA_ARGS__;    \
NSArray* propertiesNamesArray = [[[NSString stringWithCString:propertiesNames encoding:NSUTF8StringEncoding]    \
stringByReplacingOccurrencesOfString:@" " withString:@""]          \
componentsSeparatedByString:@","];     \
for (NSString* propertyString in propertiesNamesArray) {    \
SEL getterSEL = propertyGetterSelector(propertyString); \
SEL setterSEL = propertySetterSelector(propertyString); \
class_addMethod(self, setterSEL, (IMP)(setterName), "v@:@"); \
class_addMethod(self, getterSEL, (IMP)(getterName), "@@:");   \
}   \
}   \
@end







#endif
