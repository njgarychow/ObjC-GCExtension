//
//  NSObjectGCJSONExtensionTests.m
//  BlockExtensionDeveloper
//
//  Created by njgarychow on 14-8-26.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "Kiwi.h"

#import "GCExtension.h"



@interface JSONTest : NSObject

@property (nonatomic, strong) NSString* createDate;
@property (nonatomic, assign) int issue;

@end

@implementation JSONTest

+ (Class)getClassForJSONKey:(NSString *)propertyName {
    return [@{}
            objectForKey:propertyName];
}
+ (NSString *)getPropertyNameForJSONKey:(NSString *)key {
    return [@{@"CreateDate" : @"createDate",
              @"Issue" : @"issue"}
            objectForKey:key];
}
- (NSString *)description {
    NSMutableString* desc = [NSMutableString string];
    [desc appendFormat:@"%@     ", [super description]];
    [desc appendFormat:@"CreateDate : %@    ", self.createDate];
    [desc appendFormat:@"Issue : %d", self.issue];
    return desc;
}

@end




@interface JSONArrayTest : NSObject

@property (nonatomic, strong) NSArray* MagazineItems;

@end


@implementation JSONArrayTest

+ (Class)getClassForJSONKey:(NSString *)propertyName {
    return [@{@"MagazineItems" : [JSONTest class]}
            objectForKey:propertyName];
}
+ (NSString *)getPropertyNameForJSONKey:(NSString *)key {
    return key;
}
- (NSString *)description {
    NSMutableString* desc = [NSMutableString string];
    [desc appendFormat:@"%@     ", [super description]];
    [desc appendFormat:@"MagazineItems : %@", self.MagazineItems];
    return desc;
}

@end


SPEC_BEGIN(NSObject_GCJSONExtension_Tests)

describe(@"JSON Extension", ^{
    
    let(JSONString, ^id{
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"JSONTestString" ofType:@"geojson"];
        NSString* JSONString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        return JSONString;
    });
    context(@"string object", ^{
        it(@"object from json string", ^{
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            id result = [JSONTest serailizeFromJSONObject:dic[@"result"][@"MagazineItems"]];
            NSLog(@"JSONTest : %@", result);
        });
        
        it(@"object from json data", ^{
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            id result = [JSONArrayTest serailizeFromJSONObject:dic[@"result"]];
            NSLog(@"JSONArrayTest : %@", result);
        });
    });
    
    context(@"null object", ^{
        
    });
    
    context(@"number object", ^{
        
    });
    
    context(@"bool object", ^{
        
    });
    
    context(@"array object", ^{
        
    });
    
    context(@"dictionary object", ^{
        
    });
});

SPEC_END