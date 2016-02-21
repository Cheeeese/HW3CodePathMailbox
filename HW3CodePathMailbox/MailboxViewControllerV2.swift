//
//  MailboxViewController.swift
//  HW3CodePathMailbox
//
//  Created by Matthew Verghese on 2/20/16.
//  Copyright © 2016 Cheeeese. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    
    @IBOutlet weak var rescheduleIconView: UIImageView!
    @IBOutlet weak var archiveIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var rescheduleOverlayView: UIImageView!
    @IBOutlet weak var listOverlayView: UIImageView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var composeView: UIView!
    
    let grayColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    let yellowColor = UIColor(red: 249.0/255.0, green: 212.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    let brownColor = UIColor(red: 217.0/255.0, green: 167.0/255.0, blue: 117.0/255.0, alpha: 1.0)
    let greenColor = UIColor(red: 113.0/255.0, green: 217.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    let redColor = UIColor(red: 233.0/255.0, green: 83.0/255.0, blue: 52.0/255.0, alpha: 1.0)
    
    var contentOriginalCenter: CGPoint!
    var contentRightOffset: CGFloat!
    var contentRight: CGPoint!
    var contentLeft: CGPoint!
    
    var messageOriginalCenter: CGPoint!
    var archiveIconOriginalCenter: CGPoint!
    var rescheduleIconOriginalCenter: CGPoint!
    var deleteIconOriginalCenter: CGPoint!
    var listIconOriginalCenter: CGPoint!
    
    var contentStaticCenter: CGPoint!
    var messageStaticCenter: CGPoint!
    var messageStaticRight: CGPoint!
    var messageStaticLeft: CGPoint!
    var leftIconsStaticCenter: CGPoint!
    var rightIconsStaticCenter: CGPoint!
    
    var composeOriginalCenter: CGPoint!
    var composeUp: CGPoint!
    var composeDown: CGPoint!
    var composeOffset: CGFloat!
    
    @IBOutlet weak var contentMenuControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Enable Scrolling
        scrollView.contentSize = CGSize(width: 320, height: 2300)
        scrollView.delegate = self
        scrollView.contentInset.bottom = messageView.frame.height
        
        // Enable content offset for Edge Pan Animation
        contentRightOffset = 290
        contentLeft = contentView.center
        contentRight = CGPoint(x: contentView.center.x + contentRightOffset, y: contentView.center.y)
        
        // Instantiate the edge pan gesture
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)

        
        // Set the initial alpha of the hidden icons at zero
        listIconView.alpha = 0.0
        deleteIconView.alpha = 0.0
        rescheduleOverlayView.alpha = 0.0
        listOverlayView.alpha = 0.0
        
        // Set the reset locations of all items
        contentStaticCenter = contentView.center
        messageStaticCenter = messageView.center
        messageStaticRight = CGPoint(x: 600.0, y: messageView.center.y)
        messageStaticLeft = CGPoint(x: -600.0, y: messageView.center.y)
        
        leftIconsStaticCenter = archiveIconView.center
        rightIconsStaticCenter = rescheduleIconView.center
        
        // Enable compose view offset for compose animation
        composeView.alpha = 0.0
        composeUp = composeView.center
        composeOffset = 700
        composeDown = CGPoint(x: composeView.center.x, y: composeView.center.y + composeOffset)
        composeView.center = composeDown
        
        contentMenuControl.selectedSegmentIndex = 1
        
    }
    
    @IBAction func onContentMenuControlChange(sender: UISegmentedControl) {
        print(contentMenuControl.selectedSegmentIndex)
    }

    
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            print("I've been shaken")
        }
    }
    
    private var _undoManager = NSUndoManager()
    override var undoManager: NSUndoManager {
        return _undoManager
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetMessageItems() {
        messageView.center = messageStaticCenter
        archiveIconView.center = leftIconsStaticCenter
        deleteIconView.center = leftIconsStaticCenter
        rescheduleIconView.center = rightIconsStaticCenter
        listIconView.center = rightIconsStaticCenter
        listIconView.alpha = 0.0
        deleteIconView.alpha = 0.0
        archiveIconView.alpha = 1.0
        rescheduleIconView.alpha = 1.0
        
    }
    
    func iconsFollowMessagePan() {
        rescheduleIconView.center = CGPoint(x: messageView.center.x + 180.0, y: rescheduleIconOriginalCenter.y)
        listIconView.center = CGPoint(x: messageView.center.x + 180.0, y: listIconOriginalCenter.y)
        archiveIconView.center = CGPoint(x: messageView.center.x - 180.0, y: archiveIconOriginalCenter.y)
        deleteIconView.center = CGPoint(x: messageView.center.x - 180.0, y: deleteIconOriginalCenter.y)
        
    }
    
//    @IBAction func didMessagePan(sender: AnyObject) {
//    }
    
   
    @IBAction func didPressCompose(sender: AnyObject) {

        composeView.alpha = 1.0
        UIView.animateWithDuration(0.1, delay: 0, options: [], animations: { () -> Void in
            self.composeView.center = self.composeUp
            }) { (Bool) -> Void in
                
        }
        
    }
    
    @IBAction func didPressCancelCompose(sender: AnyObject) {

        UIView.animateWithDuration(0.05, delay: 0, options: [], animations: { () -> Void in
            self.composeView.center = self.composeDown
            }) { (Bool) -> Void in
                self.composeView.alpha = 0.0
                
        }

        
    }
    
    @IBAction func didTapRescheduleOverlay(sender: UITapGestureRecognizer) {
        rescheduleOverlayView.alpha = 0.0

        UIView.animateWithDuration(0.05, delay: 0, options: [], animations: { () -> Void in
            
            self.scrollView.contentOffset.y = self.scrollView.contentInset.bottom
            
            }) { (Bool) -> Void in
                self.resetMessageItems()
                
        }

    }
    
    @IBAction func didTapListOverlay(sender: UITapGestureRecognizer) {
        
        self.listOverlayView.alpha = 0.0
        UIView.animateWithDuration(0.05, delay: 0, options: [], animations: { () -> Void in

            self.scrollView.contentOffset.y = self.scrollView.contentInset.bottom

            }) { (Bool) -> Void in
                self.resetMessageItems()

        }
    }

    @IBAction func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        print("It's edge panning")
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Edge pan began at: \(point)")
            contentOriginalCenter = contentView.center
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Edge pan changed at: \(point)")
            contentView.center = CGPoint(x: contentOriginalCenter.x + translation.x, y: contentOriginalCenter.y)
            
            
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Edge pan ended at: \(point)")
            
            if velocity.x > 0 {
                
                UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: [], animations: { () -> Void in
                    self.contentView.center = self.contentRight
                    }, completion: { (Bool) -> Void in
                        
                })
                
            } else {

                UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: [], animations: { () -> Void in
                    self.contentView.center = self.contentLeft
                    }, completion: { (Bool) -> Void in
                        
                })

                
            }
        }
        
        
        
    }
    
    
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")

            // Initializing the center of each of the items when the pan starts
            messageOriginalCenter = messageView.center
            archiveIconOriginalCenter = archiveIconView.center
            rescheduleIconOriginalCenter = rescheduleIconView.center
            deleteIconOriginalCenter = rescheduleIconView.center
            listIconOriginalCenter = rescheduleIconView.center
            
        
            
        } else if sender.state == UIGestureRecognizerState.Changed {

            // Move the message view as you pan
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)

            // Have the icons follow the message if it pans outside the center range
            if messageView.center.x <= 100 || messageView.center.x >= 220 {
                iconsFollowMessagePan()
            }
            


            // if, else statement to the view color and icons as the message View pans
            
            if messageView.center.x > 100 && messageView.center.x < 220 {
                messageBackgroundView.backgroundColor = grayColor

                
            } else if messageView.center.x <= 100 &&  messageView.center.x > -100 {
                messageBackgroundView.backgroundColor = yellowColor
                
                rescheduleIconView.alpha = 1.0
                listIconView.alpha = 0.0
                
                
            } else if messageView.center.x <= -100 {
                messageBackgroundView.backgroundColor = brownColor
                
                rescheduleIconView.alpha = 0.0
                listIconView.alpha = 1.0
                
            } else if messageView.center.x >= 220 && messageView.center.x < 420 {
                messageBackgroundView.backgroundColor = greenColor
                
                archiveIconView.alpha = 1.0
                deleteIconView.alpha = 0.0

                
                
            } else if messageView.center.x >= 420 {
                messageBackgroundView.backgroundColor = redColor
                
                archiveIconView.alpha = 0.0
                deleteIconView.alpha = 1.0

            }
            

        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")

            
            if messageView.center.x > 100 && messageView.center.x < 220 || messageView.center.x > 100 && velocity.x < 0.0 || messageView.center.x < 220 && velocity.x > 0.0 {

                
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageView.center = self.messageStaticCenter
                    

                })
                
            } else if messageView.center.x >= 220 && messageView.center.x < 420 && velocity.x > 0.0 {

                UIView.animateWithDuration(0.05, delay: 0.0, options: [], animations: { () -> Void in
                    self.messageView.center = self.messageStaticRight
                    self.iconsFollowMessagePan()
                    
                    
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.05, delay: 0, options: [], animations: { () -> Void in
                            self.scrollView.contentOffset.y = self.scrollView.contentInset.bottom
                            }, completion: { (Bool) -> Void in
                                self.resetMessageItems()
                        })
                })
                
                
            } else if messageView.center.x >= 420 && velocity.x > 0.0 {
                
                UIView.animateWithDuration(0.05, delay: 0.0, options: [], animations: { () -> Void in
                    self.messageView.center = self.messageStaticRight
                    self.iconsFollowMessagePan()
                    
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.05, delay: 0, options: [], animations: { () -> Void in
                            self.scrollView.contentOffset.y = self.scrollView.contentInset.bottom
                            }, completion: { (Bool) -> Void in
                                self.resetMessageItems()
                        })
                })

                
            } else if messageView.center.x <= 100 && messageView.center.x > -100 && velocity.x < 0.0 {
                
                UIView.animateWithDuration(0.05, delay: 0.0, options: [], animations: { () -> Void in
                    self.messageView.center = self.messageStaticLeft
                    self.iconsFollowMessagePan()
                    
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.05, animations: { () -> Void in
                            self.rescheduleOverlayView.alpha = 1.0
                        })
                })
                
            } else if messageView.center.x <= -100 && velocity.x < 0.0 {
                
                UIView.animateWithDuration(0.05, delay: 0.0, options: [], animations: { () -> Void in
                    self.messageView.center = self.messageStaticLeft
                    self.iconsFollowMessagePan()
                    
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.05, animations: { () -> Void in
                            self.listOverlayView.alpha = 1.0
                        })
                })
                
            }
            
            
            
        }
        
        
        
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
