//
//  Score.m
//  Fireball Soccer
//
//  Created by Kenny Domingo on 05/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import "Score.h"

@implementation Score

+(id)points:(NSString *)fontName
{
    
    Score *points1 = [Score labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    points1.name = @"score1";
    points1.position = CGPointMake(-50, 200);
    points1.fontColor = [UIColor yellowColor];
    points1.fontSize = 50.0f;
    points1.zPosition = 1;
    points1.text = @"0";
    points1.number = 0;
    return points1;
    
    Score *points2 = [Score labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    points2.position = CGPointMake(-49, 199);
    points2.fontColor = [UIColor redColor];
    points2.fontSize = 50.0f;
    points2.zPosition = 2;
    points2.text = @"0";
    points2.number = 0;
    return points2;

    Score *points3 = [Score labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    points3.position = CGPointMake(39, 199);
    points3.fontColor = [UIColor yellowColor];
    points3.fontSize = 50.0f;
    points3.zPosition = 1;
    points3.text = @"0";
    points3.number = 0;
    return points3;
    
    Score *points4 = [Score labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
    points4.position = CGPointMake(40, 200);
    points4.fontColor = [UIColor greenColor];
    points4.fontSize = 50.0f;
    points4.zPosition = 1;
    points4.text = @"0";
    points4.number = 0;
    return points4;
}

-(void)increment
{
    self.number = (self.number)+1;
    self.text = [NSString stringWithFormat:@"%i", self.number];
}

@end
