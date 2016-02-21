//
//  MailboxViewController.swift
//  HW3CodePathMailbox
//
//  Created by Matthew Verghese on 2/20/16.
//  Copyright © 2016 Cheeeese. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    
    @IBOutlet weak var rescheduleIconView: UIImageView!
    @IBOutlet weak var archiveIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!
    @IBOutlet weak var listIconView: UIImageView!
    
    let grayColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    let yellowColor = UIColor(red: 249.0/255.0, green: 212.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    let brownColor = UIColor(red: 217.0/255.0, green: 167.0/255.0, blue: 117.0/255.0, alpha: 1.0)
    let greenColor = UIColor(red: 113.0/255.0, green: 217.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    let redColor = UIColor(red: 233.0/255.0, green: 83.0/255.0, blue: 52.0/255.0, alpha: 1.0)
    
    var messageOriginalCenter: CGPoint!
    var archiveIconOriginalCenter: CGPoint!
    var rescheduleIconOriginalCenter: CGPoint!
    var deleteIconOriginalCenter: CGPoint!
    var listIconOriginalCenter: CGPoint!
    
    var messageStaticCenter: CGPoint!
    var messageStaticRight: CGPoint!
    var messageStaticLeft: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: 320, height: 2300)
        
        // Set the initial alpha of the hidden icons at zero
        listIconView.alpha = 0.0
        deleteIconView.alpha = 0.0
        messageStaticCenter = messageView.center
        messageStaticRight = CGPoint(x: 500.0, y: messageView.center.y)
        messageStaticLeft = CGPoint(x: -500.0, y: messageView.center.y)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func didMessagePan(sender: AnyObject) {
//    }
    
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
            // print("Gesture changed at: \(point)")
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)

            // Move the icons as the message pans outside the center range
            if messageView.center.x <= 100 || messageView.center.x >= 220 {
                rescheduleIconView.center = CGPoint(x: messageView.center.x + 180.0, y: rescheduleIconOriginalCenter.y)
                listIconView.center = CGPoint(x: messageView.center.x + 180.0, y: listIconOriginalCenter.y)
                archiveIconView.center = CGPoint(x: messageView.center.x - 180.0, y: archiveIconOriginalCenter.y)
                deleteIconView.center = CGPoint(x: messageView.center.x - 180.0, y: deleteIconOriginalCenter.y)


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
            
            print(messageView.center.x)

        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            
            if messageView.center.x > 100 && messageView.center.x < 220 || messageView.center.x > 100 && velocity.x < 0.0 || messageView.center.x < 220 && velocity.x > 0.0 {

                
                print("velocity is \(velocity)")
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageView.center = self.messageStaticCenter
                    

                })
                
            } else if messageView.center.x >= 220 && messageView.center.x < 420 && velocity.x > 0.0 {

                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageView.center = self.messageStaticRight
                    
                })
                
                
            } else if messageView.center.x >= 420 && velocity.x > 0.0 {

                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageView.center = self.messageStaticRight
                    
                })
                
            } else if messageView.center.x <= 100 && messageView.center.x > -100 && velocity.x < 0.0 {
                
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageView.center = self.messageStaticLeft
                    
                })
                
            } else if messageView.center.x <= -100 && velocity.x < 0.0 {
                
                UIView.animateWithDuration(0.05, animations: { () -> Void in
                    self.messageView.center = self.messageStaticLeft
                    
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
