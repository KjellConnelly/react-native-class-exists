
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

@end
