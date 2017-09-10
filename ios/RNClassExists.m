
#import "RNClassExists.h"

@implementation RNClassExists

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(exists: (NSString *)className : (RCTResponseSenderBlock)callback) {
    BOOL doesExist = NSClassFromString(className) == nil ? false : true;
    callback(@[[NSNumber numberWithBool:doesExist]]);
}

RCT_EXPORT_METHOD(classMethodResponse: (NSString *)className : (NSString *)methodName : (NSString *) responseType : (RCTResponseSenderBlock)callback) {
    Class myClass = NSClassFromString(className);
    BOOL doesExist = myClass == nil ? false : true;
    
    if (doesExist) {
        SEL selector = NSSelectorFromString(methodName);
        if ([myClass respondsToSelector:selector]) {
            NSString *type = [responseType uppercaseString];
            if ([type isEqualToString:@"BOOL"]) {
                BOOL response = [myClass performSelector:selector];
                callback(@[[NSNumber numberWithBool:true],[NSNumber numberWithBool:response]]);
            } else if ([type isEqualToString:@"NSNUMBER"]) {
                NSNumber *response = [myClass performSelector:selector];
                callback(@[[NSNumber numberWithBool:true],response]);
            } else if ([type isEqualToString:@"INT"]) {
                int response = [myClass performSelector:selector];
                callback(@[[NSNumber numberWithBool:true],[NSNumber numberWithInt:response]]);
            } else if ([type isEqualToString:@"FLOAT"]) {
                float response = [myClass performSelector:selector];
                callback(@[[NSNumber numberWithBool:true],[NSNumber numberWithFloat:response]]);
            } else if ([type isEqualToString:@"DOUBLE"]) {
                double response = [myClass performSelector:selector];
                callback(@[[NSNumber numberWithBool:true],[NSNumber numberWithDouble:response]]);
            } else if ([type isEqualToString:@"NSSTRING"] || [type isEqualToString:@"STRING"]) {
                NSString *response = [myClass performSelector:selector];
                callback(@[[NSNumber numberWithBool:true],response]);
            }
        } else {
            callback(@[[NSNumber numberWithBool:false],@""]);
        }
    } else {
        callback(@[[NSNumber numberWithBool:false],@""]);
    }
}

/*
BOOL exists = [self classExists:field1.text];
if (exists) {
    Class myClass = NSClassFromString(field1.text);
    SEL selector = NSSelectorFromString(field2.text);
    if ([myClass respondsToSelector:selector]) {
        BOOL works = [myClass performSelector:selector];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@", works ? @"Works" : @"Doesn't"] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    } else {
    }
    
}
 */

@end
