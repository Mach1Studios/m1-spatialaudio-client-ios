#import "AudioTap.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@implementation AudioTap

@synthesize one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, sqrtNumberChannels;
@synthesize numberOfChannels;
- (instancetype) init:(int)numberOfChannels {
    self = [super init];
    if (self) {
        one = 1;
        two = 1;
        three = 1;
        four = 1;
        five = 1;
        six = 1;
        seven = 1;
        eight = 1;
        nine = 1;
        ten = 1;
        eleven = 1;
        twelve = 1;
        thirteen = 1;
        fourteen = 1;
        sixteen = 1;
        seventeen = 1;
        eighteen = 1;
        sqrtNumberChannels = sqrtf(numberOfChannels);
        self.numberOfChannels = numberOfChannels;
    }
    return self;
}

- (MTAudioProcessingTapCallbacks)callbacks {
    MTAudioProcessingTapCallbacks callbacks;
    callbacks.version = kMTAudioProcessingTapCallbacksVersion_0;
    callbacks.clientInfo = (__bridge void *)(self);
    callbacks.init = init;
    callbacks.prepare = prepare;
    callbacks.process = process;
    callbacks.unprepare = unprepare;
    callbacks.finalize = finalize;
    return callbacks;
}

void init(MTAudioProcessingTapRef tap, void *clientInfo, void **tapStorageOut) {
    *tapStorageOut = clientInfo;
}

void finalize(MTAudioProcessingTapRef tap) {}

void prepare(MTAudioProcessingTapRef tap, CMItemCount maxFrames, const AudioStreamBasicDescription *processingFormat) {}

void unprepare(MTAudioProcessingTapRef tap) {}

void process(MTAudioProcessingTapRef tap,
             CMItemCount numberFrames,
             MTAudioProcessingTapFlags flags,
             AudioBufferList *bufferListInOut,
             CMItemCount *numberFramesOut,
             MTAudioProcessingTapFlags *flagsOut) {
    OSStatus status;
    status = MTAudioProcessingTapGetSourceAudio(tap, numberFrames, bufferListInOut, flagsOut, NULL, numberFramesOut);
    AudioTap *context = (__bridge AudioTap *)MTAudioProcessingTapGetStorage(tap);
    float left   = 0;
    float right  = 0;
    float *one    = (float*)bufferListInOut->mBuffers[0].mData;
    float *two    = (float*)bufferListInOut->mBuffers[1].mData;
    float *three  = (float*)bufferListInOut->mBuffers[2].mData;
    float *four   = (float*)bufferListInOut->mBuffers[3].mData;
    float *five   = (float*)bufferListInOut->mBuffers[4].mData;
    float *six    = (float*)bufferListInOut->mBuffers[5].mData;
    float *seven  = (float*)bufferListInOut->mBuffers[6].mData;
    float *eight  = (float*)bufferListInOut->mBuffers[7].mData;

    for (int j=0; j<*numberFramesOut; j++) {
          left = ((one[j] * context.one + two[j] * context.three + three[j] * context.five + four[j] * context.seven + five[j] * context.nine + six[j] * context.eleven + seven[j] * context.thirteen + eight[j] * context.fifteen) / context.sqrtNumberChannels) * context.seventeen;
          right = ((one[j] * context.two + two[j] * context.four + three[j] * context.six + four[j] * context.eight + five[j] * context.ten + six[j] * context.twelve + seven[j] * context.fourteen + eight[j] * context.sixteen) / context.sqrtNumberChannels) * context.eighteen;
          three[j] = 0;
          four[j] = 0;
          five[j] = 0;
          six[j] = 0;
          seven[j] = 0;
          eight[j] = 0;
          one[j] = left;
          two[j] = right;
      }
}

@end
