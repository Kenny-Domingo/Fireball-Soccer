//
//  AppDelegate.h
//  Fireball Soccer
//
//  Created by Kenny Domingo on 02/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    AVAudioPlayer *startupPlayer;
}

@property (strong, nonatomic) UIWindow *window;

@end
