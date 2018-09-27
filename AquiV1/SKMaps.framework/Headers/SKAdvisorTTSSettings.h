//
//  SKAdvisorTTSSettings.h
//  SKMaps
//
//  Copyright (c) 2016 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The SKAdvisorTTSSettings is used to store information about the text to speach settings.
 */
@interface SKAdvisorTTSSettings : NSObject

/** Speed rate of TTS.
 */
@property(nonatomic, assign) float rate;

/** Pitch multiplier for the TTS.
 */
@property(nonatomic, assign) float pitchMultiplier;

/** Volume of TTS.
 */
@property(nonatomic, assign) float volume;

/** Whether or not to duck any music or sound that might be playing when a TTS advice is played. Default is YES.
 */
@property(nonatomic, assign) BOOL audioDuckingEnabled;

/** Delay before the string is spoken.
 */
@property(nonatomic, assign) NSTimeInterval preUtteranceDelay;

/** Delay after the string is spoken.
 */
@property(nonatomic, assign) NSTimeInterval postUtteranceDelay;

/** A newly initialized SKAdvisorTTSSettings.
 */
+ (instancetype)advisorTTSSettings;

@end
