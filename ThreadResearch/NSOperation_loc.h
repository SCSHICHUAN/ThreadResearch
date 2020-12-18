//
//  NSOperation_loc.h
//  ThreadResearch
//
//  Created by Stan on 2020/12/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSOperation_loc : NSObject
-(void)invocation;
-(void)cancel_loc;
-(void)cancel_loc_3;

-(void)sync_operation;
-(void)async_operation;
@end

NS_ASSUME_NONNULL_END
