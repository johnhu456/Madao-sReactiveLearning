//
//  RWViewController.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWViewController.h"
#import "RWDummySignInService.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FHTool.h"

@interface RWViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;

@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation RWViewController

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self updateUIState];
  @WEAKSELF;
  self.signInService = [RWDummySignInService new];
  
  // initially hide the failure message
  self.signInFailureText.hidden = YES;
    
  [self.usernameTextField.rac_textSignal subscribeNext:^(id x){
        NSLog(@"%@",x);
  }];
    RACSignal *validNameSignal = [self.usernameTextField.rac_textSignal map:^id(NSString *text) {
        return @(text.length > 3);
    }];

    RACSignal *validPasswordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *text) {
        return @(text.length > 3);
    }];

    RAC(self.usernameTextField,backgroundColor) = [validNameSignal map:^id(NSNumber *valid) {
        return [valid boolValue]? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(self.passwordTextField,backgroundColor) = [validPasswordSignal map:^id(NSNumber *valid) {
        return [valid boolValue]? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RACSignal *signupActiveSingal = [RACSignal combineLatest:@[validNameSignal,validPasswordSignal] reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    
    [signupActiveSingal subscribeNext:^(NSNumber *signupActive) {
        weakSelf.signInButton.enabled = [signupActive boolValue];
    }];
    
//    RACSignal *signInSignal = [self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside];
//    [signInSignal flattenMap:^id(NSNumber *signedIn) {
//        BOOL success = [signedIn boolValue];
//        self.signInFailureText.hidden = success;
//        if (success) {
//            [weakSelf performSegueWithIdentifier:@"signInSuccess" sender:weakSelf];
//            return @(NO);
//        }
//        return  @(YES);
//    }];
//    RACCommand *enableCommand = [[RACCommand alloc] initWithEnabled:signInSignal signalBlock:^RACSignal *(id input) {
//        return [weakSelf signInSignal];
//    }];
//    self.signInButton.rac_command = enableCommand;
    
    [[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        weakSelf.signInButton.enabled = NO;
        weakSelf.signInFailureText.hidden = YES;
    }]
    flattenMap:^id(id value){
        return [weakSelf signInSignal];
    }] subscribeNext:^(NSNumber *signedIn) {
        BOOL success = [signedIn boolValue];
        self.signInFailureText.hidden = success;
        if (success) {
            [weakSelf performSegueWithIdentifier:@"signInSuccess" sender:weakSelf];
        }
    }];
    
}
- (BOOL)isValidUsername:(NSString *)username {
  return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
  return password.length > 3;
}

- (RACSignal *)signInSignal{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.signInService signInWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
            
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
//- (IBAction)signInButtonTouched:(id)sender {
//  // disable all UI controls
//  self.signInButton.enabled = NO;
//  self.signInFailureText.hidden = YES;
//  
//  // sign in
//  [self.signInService signInWithUsername:self.usernameTextField.text
//                            password:self.passwordTextField.text
//                            complete:^(BOOL success) {
//                              self.signInButton.enabled = YES;
//                              self.signInFailureText.hidden = success;
//                              if (success) {
//                                [self performSegueWithIdentifier:@"signInSuccess" sender:self];
//                              }
//                            }];
//}


// updates the enabled state and style of the text fields based on whether the current username
// and password combo is valid
//- (void)updateUIState {
//  self.usernameTextField.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//  self.passwordTextField.backgroundColor = self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//  self.signInButton.enabled = self.usernameIsValid && self.passwordIsValid;
//}


@end
