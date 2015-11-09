//
//  FeedViewController.swift
//  Week3Assignment
//
//  Created by David Scoville on 11/5/15.
//  Copyright © 2015 David Scoville. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var messageView: UIImageView!
    
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var rightSideIcons: UIView!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var leftSideIcons: UIView!
    
    var originalCenter: CGPoint!
    var rightsideIconsOriginalCenter: CGPoint!
    var leftsideIconsOriginalCenter: CGPoint!
    var messageStartPosition: CGPoint!
    var startMovingRightSideIcons: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = imageView.image!.size
        rescheduleView.alpha = 0
        listView.alpha = 0
        messageStartPosition = messageView.center
        laterIcon.alpha = 0.3
        listIcon.alpha = 0
        archiveIcon.alpha = 0.3
        deleteIcon.alpha = 0
        startMovingRightSideIcons = false
        rightsideIconsOriginalCenter = rightSideIcons.center
        leftsideIconsOriginalCenter = leftSideIcons.center
        originalCenter = messageView.center

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(messageView)
        var velocity = sender.velocityInView(messageView)
        
        
        
        
        /********** BEGAN ****************/
        
        if sender.state == UIGestureRecognizerState.Began {
            self.originalCenter = messageView.center
            self.rightsideIconsOriginalCenter = rightSideIcons.center
            self.leftsideIconsOriginalCenter = leftSideIcons.center
            if velocity.x < 0 {
                
                // When pulling to left, fade in later icon
                
                
            } else {
                
                
            }
        }
        
        
        
        
        
        
        /************ CHANGED *********/

        if sender.state == UIGestureRecognizerState.Changed {

            messageView.center = CGPoint(x:originalCenter.x + translation.x, y:originalCenter.y)
            if (startMovingRightSideIcons == true) {
                rightSideIcons.center = CGPoint(x:rightsideIconsOriginalCenter.x + translation.x + 60, y:rightsideIconsOriginalCenter.y)
                leftSideIcons.center = CGPoint(x:leftsideIconsOriginalCenter.x + translation.x - 60, y:leftsideIconsOriginalCenter.y)
            }
           
            if messageView.frame.origin.x < -60 && messageView.frame.origin.x > -260 {
                
                //Yellow
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageContainer.backgroundColor = UIColor( red: CGFloat(255/255.0), green: CGFloat(211/255.0), blue: CGFloat(32/255.0), alpha: CGFloat(1.0) )
                })
                self.listIcon.alpha = 0
                self.laterIcon.alpha = 1
                
                startMovingRightSideIcons = true
                
                
            } else if messageView.frame.origin.x <= -260 {
                
                //Brown
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageContainer.backgroundColor = UIColor( red: CGFloat(216/255.0), green: CGFloat(166/255.0), blue: CGFloat(117/255.0), alpha: CGFloat(1.0) )
                })
                self.listIcon.alpha = 1
                self.laterIcon.alpha = 0
                
                startMovingRightSideIcons = true
            
            } else if messageView.frame.origin.x > 60 && messageView.frame.origin.x < 260 {
                
                //GREEN
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageContainer.backgroundColor = UIColor( red: CGFloat(98/255.0), green: CGFloat(217/255.0), blue: CGFloat(98/255.0), alpha: CGFloat(1.0) )
                })
                self.deleteIcon.alpha = 0
                self.archiveIcon.alpha = 1
                
                startMovingRightSideIcons = true
                
                
            } else if messageView.frame.origin.x >= 260 {
                
                //RED
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageContainer.backgroundColor = UIColor( red: CGFloat(239/255.0), green: CGFloat(84/255.0), blue: CGFloat(12/255.0), alpha: CGFloat(1.0) )
                })
                self.archiveIcon.alpha = 0
                self.deleteIcon.alpha = 1
                
                startMovingRightSideIcons = true
                
                
            } else {
                //Gray
                startMovingRightSideIcons = false
                
                rightSideIcons.center = CGPoint(x:rightsideIconsOriginalCenter.x, y:rightsideIconsOriginalCenter.y)
                leftSideIcons.center = CGPoint(x: leftsideIconsOriginalCenter.x, y: leftsideIconsOriginalCenter.y)
                
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageContainer.backgroundColor = UIColor( red: CGFloat(191/255.0), green: CGFloat(191/255.0), blue: CGFloat(191/255.0), alpha: CGFloat(1.0) )
                })
               
                print(messageView.frame.origin.x)
                if messageView.frame.origin.x >= 15 && messageView.frame.origin.x <= 50 {
                    archiveIcon.alpha = convertValue(messageView.frame.origin.x, r1Min: 15, r1Max: 50, r2Min: 0.1, r2Max: 1)
                }
                if messageView.frame.origin.x <= -15 && messageView.frame.origin.x >= -40 {
                    laterIcon.alpha = convertValue(messageView.frame.origin.x, r1Min: -15, r1Max: -40, r2Min: 0.3, r2Max: 1)
                
                } else if messageView.frame.origin.x > -15 {
                    UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
                        self.laterIcon.alpha = 0.3
                    }, completion: nil)
                    
                } else {
                    UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
                        self.laterIcon.alpha = 1
                    }, completion: nil)
                }
            
            
            }
            
            
        }
        
        
        
        
        
        /****************ENDED ****************/
        
        if sender.state == UIGestureRecognizerState.Ended {
            
            
            
            //if let go at gray
            if messageView.frame.origin.x < 60 && messageView.frame.origin.x > -60 {
                UIView.animateWithDuration(0.2, delay: 0, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                    self.messageView.center = self.messageStartPosition
                }, completion: nil)
                
//                //Fadeout icon (still unsure about this section)
//                UIView.animateWithDuration(0.2, delay: 0.1, options: [], animations: { () -> Void in
//                    self.laterIcon.alpha = 0.4
//                }, completion: nil)
            
            //if let go at yellow
            } else if messageView.frame.origin.x < -60 && messageView.frame.origin.x > -260 {
                UIView.animateWithDuration(0.1, delay: 0, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                    self.messageView.frame.origin.x = -1 * self.messageView.frame.width
                    self.laterIcon.transform = CGAffineTransformMakeScale(2, 2)
                    self.laterIcon.alpha = 0
                }, completion: nil)
                UIView.animateWithDuration(0.2, delay: 0.1, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                    self.rescheduleView.alpha = 1
                }, completion: nil)
                
                
                
                
            //if let go at Brown
            } else if messageView.frame.origin.x <= -260 {
                UIView.animateWithDuration(0.1, delay: 0, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                    self.messageView.frame.origin.x = -1 * self.messageView.frame.width
                    self.listIcon.transform = CGAffineTransformMakeScale(2, 2)
                    self.listIcon.alpha = 0
                    
                }, completion: nil)
                UIView.animateWithDuration(0.2, delay: 0.1, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                    self.listView.alpha = 1
                }, completion: nil)
            
            //if let go at green
            } else if messageView.frame.origin.x > 60 && messageView.frame.origin.x < 260 {
                UIView.animateWithDuration(0.1, delay: 0, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                    self.messageView.frame.origin.x = self.messageView.frame.width
                    self.archiveIcon.transform = CGAffineTransformMakeScale(2, 2)
                    self.archiveIcon.alpha = 0
                    }, completion: nil)
                DismissAndResetEverything()

            //if let go at red
            } else if messageView.frame.origin.x >= 260 {
                UIView.animateWithDuration(0.1, delay: 0, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                    self.messageView.frame.origin.x = self.messageView.frame.width
                    self.deleteIcon.transform = CGAffineTransformMakeScale(2, 2)
                    self.deleteIcon.alpha = 0
                    }, completion: nil)
                DismissAndResetEverything()
            }
        
        }
        
    }
    @IBAction func TapRescheduleView(sender: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.rescheduleView.alpha = 0
            self.listView.alpha = 0
        }, completion: nil)
        DismissAndResetEverything()
        
    }
    
    func DismissAndResetEverything() {
        UIView.animateWithDuration(0.2, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.imageView.transform = CGAffineTransformMakeTranslation(0, -86)
            }, completion: nil)
        
        UIView.animateWithDuration(0, delay: 1.6, options: [], animations: { () -> Void in
            self.rightSideIcons.center = CGPoint(x:self.rightsideIconsOriginalCenter.x, y:self.rightsideIconsOriginalCenter.y)
            self.leftSideIcons.center = CGPoint(x:self.leftsideIconsOriginalCenter.x, y:self.leftsideIconsOriginalCenter.y)
            self.messageView.center = CGPoint(x:self.originalCenter.x, y:self.originalCenter.y)
            self.laterIcon.transform = CGAffineTransformMakeScale(1, 1)
            self.archiveIcon.transform = CGAffineTransformMakeScale(1, 1)
            self.deleteIcon.transform = CGAffineTransformMakeScale(1, 1)
            self.listIcon.transform = CGAffineTransformMakeScale(1, 1)
            
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 1.8, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.imageView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
