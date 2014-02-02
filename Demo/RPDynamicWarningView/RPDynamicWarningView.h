//
//  RPDynamicLocationView.h
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

#import <UIKit/UIKit.h>

@interface RPDynamicWarningView : UIView

// Designated Initializer
- (instancetype)initWithText:(NSString *)text imageName:(NSString *)imageName;

// Method that should be called to remove this view gracefully
// It's also provided a completionBlock, that is of course optinal. A reference to the DynamicLocationView
// Is passed on it, so you can remove it or hide it.
- (void)stopDynamicLocationWithCompletionBlock:(void(^)(RPDynamicWarningView *dynamicLocationView))completionBlock;

@end
