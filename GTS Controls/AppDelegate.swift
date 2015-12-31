//
//  AppDelegate.swift
//  GTS Controls
//
//  Created by jeremiah espinosa on 12/19/15.
//  Copyright © 2015 gts-controls. All rights reserved.
//

import UIKit
import Onboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let onboardStatus = "user_has_onboarded"

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    let defaults = NSUserDefaults.standardUserDefaults()
    let onboarded = defaults.boolForKey(onboardStatus) as Bool!
    
    if onboarded == false{
      print("not nil or onboarded == false -> \(onboarded)")
      //start onboard process first
      
      defaults.setBool(true, forKey: onboardStatus)
      self.window!.rootViewController = generateFirstOnboardedController()
    }
    else{
      print("onboarded is something: \(onboarded)")
      //start storyboard as usual
      print("start storyboard as usual")
      handleOnboardingCompletion()

    }
    
    
    return true
  }
  
  func generateFirstOnboardedController() -> OnboardingViewController {
    // Generate the first page...
    let firstPage: OnboardingContentViewController = OnboardingContentViewController(title: "What A Beautiful Photo", body: "This city background image is so beautiful", image: UIImage(named:
      "blue"), buttonText: "Enable Location Services") {
        print("Do something here...");
    }
    
    // Generate the second page...
    let secondPage: OnboardingContentViewController = OnboardingContentViewController(title: "I'm So Sorry", body: "I can't get over the nice blurry background photo.", image: UIImage(named:
      "red"), buttonText: "Connect With Facebook") {
        print("Do something else here...");
    }
    
    // Generate the third page, and when the user hits the button we want to handle that the onboarding
    // process has been completed.
    let thirdPage: OnboardingContentViewController = OnboardingContentViewController(title: "Seriously Though", body: "Kudos to the photographer.", image: UIImage(named:
      "yellow"), buttonText: "Let's Get Started") {
        self.handleOnboardingCompletion()
    }
    
    // Create the onboarding controller with the pages and return it.
    let onboardingVC: OnboardingViewController = OnboardingViewController(backgroundImage: UIImage(named: "street"), contents: [firstPage, secondPage, thirdPage])
        onboardingVC.shouldFadeTransitions = true
        onboardingVC.fadePageControlOnLastPage = true
        onboardingVC.fadeSkipButtonOnLastPage = true
        onboardingVC.allowSkipping = true
        onboardingVC.swipingEnabled = true
    
    return onboardingVC
  }
  
  func handleOnboardingCompletion() {
    print("onboarding is being set to complete!")
    
    // Now that we are done onboarding, we can set in our NSUserDefaults that we've onboarded now, so in the
    // future when we launch the application we won't see the onboarding again.
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: onboardStatus)
    
    // Setup the normal root view controller of the application, and set that we want to do it animated so that
    // the transition looks nice from onboarding to normal app.
    setupNormalRootVC(true)
  }
  
  func setupNormalRootVC(animated : Bool) {

    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Slide)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateInitialViewController() as UIViewController!
    self.window?.rootViewController = controller
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

