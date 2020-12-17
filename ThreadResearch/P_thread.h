//
//  P_thread.h
//  ThreadResearch
//
//  Created by Stan on 2020/9/28.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface P_thread : NSObject
-(void)test;
-(void)destroy;
@property(nonatomic,copy)NSString *str;
@end

NS_ASSUME_NONNULL_END
