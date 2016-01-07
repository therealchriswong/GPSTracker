//
//  NSString+MD5.h
//  GPSTracker
//
//  Created by Chris Wong on 2014-10-28.
//  Copyright (c) 2014 Chris Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5)

- (NSString *)MD5;

@end
