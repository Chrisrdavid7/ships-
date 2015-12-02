//
//  ViewController.h
//  Ships
//
//  Created by Chris David on 11/29/15.
//  Copyright © 2015 Chris David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    IBOutlet UIImageView *friendlyShip;
    IBOutlet UIImageView *enemyShip;
    IBOutlet UIImageView *motherShip;
    IBOutlet UIImageView *missleShip;
    
    IBOutlet UILabel *livesLabel;
    IBOutlet UILabel *scoreLabel;
    
    UITouch *touch;
    
    NSString *livesString;
    NSString *scoreString;
    
    NSTimer *enemyMovementTimer;
    NSTimer *missleMovementTimer;
    
}
- (IBAction)startGame:(id)sender;

@end

