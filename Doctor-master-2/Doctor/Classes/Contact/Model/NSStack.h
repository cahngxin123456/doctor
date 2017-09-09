//
//  NSStack.h
//  Conedot
//
//  Created by 范超 on 14-10-15.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStack : NSObject {
    NSMutableArray *stack;
}

@property (nonatomic, retain) NSMutableArray *stack;    // The NSMutableArray that acts as the stack

- (int)size;                        // Get size of stack
- (void)printStack;                 // Print stack to logs
- (void)push:(id)object;     // Push object into stack
- (void)clearStack;                 // Clears the stack of all objects
- (id)pop;                          // Pop object off stack
- (BOOL)isEmpty;                    // Check if stack is empty


@end
