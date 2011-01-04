//
//  AUProcessor.h
//  AiffPlayer
//
//  Created by koji on 10/12/17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AUProcessor : NSObject {

}

- (void) listOutputDevices;
- (void) initCoreAudio;
- (void) start;
- (void) stop;

- (void) setFormat;
- (void) setCallback;

- (void)setFreq:(int)freq;

@end
