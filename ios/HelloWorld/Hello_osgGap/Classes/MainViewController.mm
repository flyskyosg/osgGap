/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  Hello_osgGap
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

//@synthesize osgWebView;

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.
    UIView* rootView = [[[[UIApplication sharedApplication] keyWindow] rootViewController] view];
    [rootView setBackgroundColor:[UIColor clearColor]];
    [rootView setOpaque:NO];
    
    CGRect webViewFrame = [[[rootView subviews] objectAtIndex:0] frame];  // first subview is the UIWebView
    
    if (CGRectEqualToRect(webViewFrame, CGRectZero)) { // UIWebView is sized according to its parent, here it hasn't been sized yet
        self.view.frame = [[UIScreen mainScreen] applicationFrame]; // size UIWebView's parent according to application frame, which will in turn resize the UIWebView
    }

    NSLog(@"rootView : %@", rootView);
    NSLog(@"webViewFrame Rect x: %d, y: %d", webViewFrame.size.width, webViewFrame.size.height);
    //self.view = rootView;

    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
 
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

/* Comment out the block below to over-ride */

/*
- (UIWebView*) newCordovaViewWithFrame:(CGRect)bounds
{
    return[super newCordovaViewWithFrame:bounds];
}
*/

#pragma mark UIWebDelegate implementation

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    // Black base color for background matches the native apps
    
    //[self.view addSubview:theWebView];
    
    return [super webViewDidFinishLoad:theWebView];

    
}

/* Comment out the block below to over-ride */



- (void) webViewDidStartLoad:(UIWebView*)theWebView
{
    [theWebView setOpaque:NO];
    [theWebView setBackgroundColor:[UIColor clearColor]];
    
    theWebView.scrollView.bounces = NO;
    theWebView.scrollView.scrollEnabled = NO;
    [self hideGradientBackground:theWebView];
    [theWebView setTag: 200];
    theWebView.layer.zPosition = 1;
    
    
    id webDocumentView = [theWebView performSelector:@selector(_browserView)];
    id backingWebView = [webDocumentView performSelector:@selector(webView)];
   // [backingWebView _setWebGLEnabled:YES];
    
    //webview 자체기능 방지
    //webview 자체기능 방지
    for (id subview in theWebView.subviews){
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]){
			((UIScrollView *)subview).bounces = NO;
        }
    }
    
    [self.webView setOpaque:NO];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    
    //[self.view bringSubviewToFront:theWebView];
    [self.view bringSubviewToFront:theWebView];

    osgWebView = theWebView;

    NSLog(@"self View in webViewDidFinishLoad : %@", theWebView);
    [theWebView setScalesPageToFit:NO];
    return [super webViewDidStartLoad:theWebView];
}

- (void) hideGradientBackground:(UIView *)theView
{
    for(UIView * subview in theView.subviews)
    {
        if([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
}

- (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    return [super webView:theWebView didFailLoadWithError:error];
}

- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    if([[url scheme] isEqualToString:@"http"] || [[url scheme] isEqualToString:@"https"]) {
        return YES;
    }
    else{
        return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
}


@end

