#import "LevelOrderTraversal.h"

@interface TreeNode : NSObject
@property(nonatomic, nullable) NSNumber *value;
@property(nonatomic, nullable) TreeNode *leftNode;
@property(nonatomic, nullable) TreeNode *rightNode;

-(TreeNode *)recoverTree: (NSArray *)arr;
-(NSArray *)traverseTree;

@end

@implementation TreeNode

-(instancetype)init {
    self = [super init];
    if (self) {
        _value = nil;
        _leftNode = nil;
        _rightNode = nil;
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Tree Value: %d", [self.value intValue]];
}

- (TreeNode *)recoverTree:(NSMutableArray *)arr {
    if(arr.count == 0) {
        return nil;
    }

    id value = [arr firstObject];
    [arr removeObjectAtIndex:0];
    
    if (value == [NSNull null]) {
        return nil;
    }
    
    TreeNode *root = [TreeNode new];
    
    root.value = value;
    root.leftNode = [[TreeNode new] recoverTree: arr];
    root.rightNode = [[TreeNode new] recoverTree: arr];
    return root;
}

- (NSArray *)traverseTree {
    NSMutableArray *result = [NSMutableArray new];
    
    NSMutableArray *queue = [NSMutableArray arrayWithArray:@[self]];
    
    while(queue.count > 0) {
        NSMutableArray *array = [NSMutableArray new];
        NSInteger queueCount = queue.count;
        for (NSInteger i = 0; i < queueCount; i++) {
            TreeNode *node = queue[0];
            [queue removeObjectAtIndex:0];
        
            [array addObject:node.value];
            
            if (node.leftNode) {
                [queue addObject:node.leftNode];
            }
            if (node.rightNode) {
                [queue addObject:node.rightNode];
            }
        }
        
        [result addObject:array];
    }

    return result;
}

@end

NSArray *LevelOrderTraversalForTree(NSArray *tree) {
    if (!tree || !tree.count || [tree firstObject] == [NSNull null]) {
        return @[];
    }
    
    TreeNode *recoveredTree = [[TreeNode new] recoverTree:[tree mutableCopy]];
    
    return [recoveredTree traverseTree];
}
