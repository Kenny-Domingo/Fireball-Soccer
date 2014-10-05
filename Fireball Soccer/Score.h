//
//  Score.h
//  Fireball Soccer
//
//  Created by Kenny Domingo on 05/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Score : SKLabelNode
@property int number;

+(id)points:(NSString *)fontName;
-(void)increment;


@end
