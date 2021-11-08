#import "AudioTap.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@implementation AudioTap

@synthesize leftVolume;
@synthesize rightVolume;
@synthesize channel;
@synthesize numberOfChannels;

- (instancetype) init:(int)channel
                 numberOfChannels:(int)numberOfChannels {
    self = [super init];
    if (self) {
        self.leftVolume = 1;
        self.rightVolume = 1;
        self.channel = channel;
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
    float *bufferLeft = (float*)bufferListInOut->mBuffers[0].mData;
    float *bufferRight = (float*)bufferListInOut->mBuffers[1].mData;
    for (int j=0; j<*numberFramesOut; j++) {
        for (int i = 0; i < context.numberOfChannels; i++) {
            if (i != context.channel) {
                float *bufferNotCurrentChannel = (float*)bufferListInOut->mBuffers[i].mData;
                bufferNotCurrentChannel[j] = bufferNotCurrentChannel[j] * 0;
            } else {
                float *bufferCurrentChannel = (float*)bufferListInOut->mBuffers[i].mData;
                bufferLeft[j] = bufferCurrentChannel[j] * context.leftVolume;
                bufferRight[j] = bufferCurrentChannel[j] * context.rightVolume;
            }
        }
    }
}

@end
