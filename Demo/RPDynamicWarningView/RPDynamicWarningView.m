//
//  RPDynamicLocationView.m
//  The MIT License (MIT)
//
//  Copyright (c) 2014 R. Peres
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "RPDynamicWarningView.h"

static NSString *const RPHelveticaNeueFont = @"HelveticaNeue";
static NSString *const RPHorizontalBoundaryName = @"RPHorizontalBoundaryName";

static CGFloat RPDefaultMagnitude = 1.0f;
static CGFloat RPGetOutOfMyWayMagnitude = 2.0f;
static CGFloat RPDefaultElasticity = 0.6f;

#define RPGreyColour [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:205.0f/255.0f alpha:1]
#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface RPDynamicWarningView () <UIDynamicAnimatorDelegate>

@property (nonatomic,strong)IBOutlet UIImageView *locationLoadingView;
@property (nonatomic,strong)IBOutlet UITextView *locationTextView;

@property (nonatomic,strong) UIDynamicAnimator *animator;
@property (nonatomic,strong) UIPushBehavior *pushBehavior;
@property (nonatomic,strong) UIGravityBehavior *gravityBehavior;

@end

@implementation RPDynamicWarningView

#pragma mark - UIView Methods

- (void)didMoveToSuperview
{
    [self setupUIDynamicsOnView:self];
}

#pragma mark - UIDynamics Setup

- (UIGravityBehavior *)gravityBehavior
{
    _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[_locationLoadingView]];
    
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior
{
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[_locationLoadingView]];
    
    CGPoint initialPoint = CGPointMake(0.0f, _locationTextView.frame.origin.y);
    CGPoint endPoint = CGPointMake(_locationTextView.frame.size.width, _locationTextView.frame.origin.y);
    
    [collision addBoundaryWithIdentifier:RPHorizontalBoundaryName fromPoint:initialPoint toPoint:endPoint];
    
    return collision;
}

- (UIPushBehavior *)pushBehavior
{
    if (!_pushBehavior)
    {
        _pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_locationLoadingView] mode:UIPushBehaviorModeInstantaneous];
        [_pushBehavior setAngle:DEGREES_RADIANS(90.0f)];
        _pushBehavior.magnitude = 0.0;
    }
    
    return _pushBehavior;
}

- (UIDynamicItemBehavior *)locationLoadingImageDynamicItem
{
    UIDynamicItemBehavior *loadingImageDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_locationLoadingView]];
    [loadingImageDynamicBehavior setElasticity:RPDefaultElasticity];
    
    return loadingImageDynamicBehavior;
}

- (void)setupUIDynamicsOnView:(UIView *)view
{
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:view];
    _animator.delegate = self;
    
    [_animator addBehavior:[self gravityBehavior]];
    [_animator addBehavior:[self collisionBehavior]];
    [_animator addBehavior:[self pushBehavior]];
    
    [_animator addBehavior:[self locationLoadingImageDynamicItem]];
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator
{
    [_pushBehavior setMagnitude:RPDefaultMagnitude];
    [_pushBehavior setActive:TRUE];
}

#pragma mark - UI Setup

- (NSDictionary *)attributedTextDictionary
{
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont fontWithName:RPHelveticaNeueFont size:14.0f];
    
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : RPGreyColour,
                                 NSFontAttributeName : font,
                                 NSTextEffectAttributeName : NSTextEffectLetterpressStyle,
                                 NSParagraphStyleAttributeName: paragrapStyle
                                 };
    return attributes;
}

- (void)setupUIWithText:(NSString *)text
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text attributes:[self attributedTextDictionary]];
    
    [_locationTextView setAttributedText:attributedString];
}

- (void)setupUIWithImageName:(NSString *)imageName
{
    _locationLoadingView.image = [UIImage imageNamed:imageName];
}

#pragma mark - Initalizers

- (instancetype)initWithText:(NSString *)text imageName:(NSString *)imageName
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    self = [nibContents firstObject];
    
    [self setupUIWithText:text];
    [self setupUIWithImageName:imageName];
    
    return self;
}

#pragma mark - Removal Method (Public)

- (void)stopDynamicLocationWithCompletionBlock:(void(^)(RPDynamicWarningView *dynamicLocationView))completionBlock
{
    [_gravityBehavior removeItem:_locationLoadingView];
    [_gravityBehavior addItem:_locationTextView];

    _animator.delegate = nil;
    
    [_pushBehavior setMagnitude:RPGetOutOfMyWayMagnitude];
    [_pushBehavior setActive:TRUE];
    
    if (completionBlock) completionBlock(self);
}

@end
