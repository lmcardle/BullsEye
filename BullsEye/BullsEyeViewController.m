//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Liam on 8/13/12.
//  Copyright (c) 2012 Liam McArdle. All rights reserved.
//

#import "BullsEyeViewController.h"
#import "AboutViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController {
    int currentValue;
    int targetValue;
    int score;
    int round;
}

@synthesize slider = _slider;
@synthesize targetLabel = _targetLabel;
@synthesize scoreLabel = _scoreLabel;
@synthesize roundLabel = _roundLabel;

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}

- (void)startNewRound
{
    targetValue = 1 + (arc4random() % 100);
    currentValue = 50;
    self.slider.value = currentValue;
    round += 1;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewRound];
    [self updateLabels];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.slider = nil;
    self.targetLabel = nil;
    self.scoreLabel = nil;
    self.roundLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)showAlert
{
    int difference = abs(currentValue - targetValue);
    int points = 100 - difference;
    
    score += points;
    
    NSString *title;
    if (difference == 0) {
        title = @"Perfect!";
        score += 100;
    } else if (difference < 5) {
        if (difference == 1) {
            score += 50;
        }
        title = @"You almost hit it!";
    } else if (difference < 10) {
        title = @"Pretty good!";
    } else {
        title = @"Not even close...";
    }
    
    NSString *message = [NSString stringWithFormat:@"The value of the slider is: %d\nThe target value is: %d\nThe difference is %d", currentValue, targetValue, difference];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)sliderMoved:(UISlider *)slider
{
    currentValue = lroundf(slider.value);
}

- (IBAction)startOver
{
    [self startNewGame];
    [self updateLabels];
}

- (void)startNewGame
{
    score = 0;
    round = 0;
    [self startNewRound];
}

- (void)showInfo
{
    AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];

}
@end
