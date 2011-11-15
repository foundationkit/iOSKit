//
//  UIWebView+FKAdditions.h
//  iOSKit
//
//  Created by Tretter Matthias on 15.11.11.
//  Copyright (c) 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This category adds various shortcuts to UIWebView for dealing with javascript.
 */
@interface UIWebView (FKAdditions)

/** The title of the document, evaluates javascript 'document.title' */
@property (nonatomic, readonly) NSString *documentTitle;

/**
 Adjusts the scale-factor of the content of the webView.
 
 @param scaleFactor the scaleFactor of the content in percent. 100 means standard scale.
 */
- (void)setContentTextSizeScaleFactor:(NSInteger)scaleFactor;

@end
