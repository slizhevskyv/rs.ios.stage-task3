#import "LexicographicallyMinimal.h"

@interface LexicographicallyMinimal()

@property (nonatomic, strong) NSMutableString *resultString;

@end

@implementation LexicographicallyMinimal

-(NSString *)findLexicographicallyMinimalForString1:(NSString *)string1 andString2:(NSString *)string2 {
    NSMutableString *result = [NSMutableString new];
    
    NSUInteger string1Length = string1.length;
    NSUInteger string2Length = string2.length;
    
    NSInteger leftStringIndex = 0;
    NSInteger rightStringIndex = 0;
    
    while (leftStringIndex < string1Length && rightStringIndex < string2Length) {
        unichar leftStringCharacter = [string1 characterAtIndex:leftStringIndex];
        unichar rightStringCharacter = [string2 characterAtIndex:rightStringIndex];
        
        if (leftStringCharacter < rightStringCharacter) {
            [result appendFormat:@"%c", leftStringCharacter];
            leftStringIndex++;
        } else if (leftStringCharacter == rightStringCharacter) {
            NSInteger tempLeftStringIndex = leftStringIndex + 1;
            NSInteger tempRightStringIndex = rightStringIndex + 1;
            
            unichar tempLeftCharacter = 0, tempRightCharacter = 0;
            
            while(tempLeftStringIndex < string1Length && tempRightStringIndex < string2Length && tempLeftCharacter == tempRightCharacter) {
                tempLeftCharacter = [string1 characterAtIndex:tempLeftStringIndex];
                tempRightCharacter = [string2 characterAtIndex:tempRightStringIndex];
                
                tempLeftStringIndex++;
                tempRightStringIndex++;
            }
            
            [result appendFormat:@"%c", tempLeftCharacter < tempRightCharacter ? leftStringCharacter : rightStringCharacter];
            tempLeftCharacter < tempRightCharacter ? leftStringIndex++ : rightStringIndex++;
            
        } else {
            [result appendFormat:@"%c", rightStringCharacter];
            rightStringIndex++;
        }
    }
    
    NSInteger substringIndex = leftStringIndex < string1Length
        ? leftStringIndex
        : rightStringIndex;
    NSString *stringToSubstring = leftStringIndex < string1Length
        ? string1
        : string2;
    
    [result appendString: [stringToSubstring substringFromIndex:substringIndex]];
    
    return [result copy];
}

@end
