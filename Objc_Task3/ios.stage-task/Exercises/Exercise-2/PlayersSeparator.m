#import "PlayersSeparator.h"

@implementation PlayersSeparator

- (NSInteger)dividePlayersIntoTeams:(NSArray<NSNumber *>*)ratingArray {
    NSInteger count = 0;
    NSInteger ratingArrCount = [ratingArray count];
    
    if (ratingArrCount < 3) {
        return count;
    }
    
    NSInteger i = 0;
    NSInteger j = 1;
    NSInteger k = 2;
    
    NSInteger lastIndex = ratingArrCount - 1;
    
    while (i <= ratingArrCount - 3) {
        NSInteger iValue = [ratingArray[i] integerValue];
        NSInteger jValue = [ratingArray[j] integerValue];
        NSInteger kValue = [ratingArray[k] integerValue];
        
        BOOL lessThanCondition = iValue < jValue && jValue < kValue;
        BOOL moreThanCondition = iValue > jValue && jValue > kValue;
        
        if (lessThanCondition || moreThanCondition) {
            count++;
        }
        
        
        if (j == lastIndex - 1) {
            i++;
            j = i + 1;
            k = j + 1;
            
            continue;
        }
        
        if (k == lastIndex) {
            j++;
            k = j + 1;
            
            continue;
        }
        
        k++;
    }
    
    return count;
}

@end
