# HW3CodePathMailbox

Homework 3 CodePath: Mailbox Project

This is an iOS demo that creates an example app using Swift to create animations and gestures based on an example app (Mailbox).  I utilized the example step by step Tutorials in the [CodePath Week 3 Project Folder] (http://courses.codepath.com/courses/ios_for_designers/unit/3#!assignment) to create this app.  

Time spent: ~12 hours developing required pieces

Completed user stories:
* [x] User can drag a message left to either reschedule or show the list overlay 
  * The later icon will fade in as the user pans 
  * At 60 pts, the later icon moves with the drag and the background changes to yellow
  * Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
  * After 260 pts, the icon should change to the list icon and the background color should change to brown.
  * Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
  * User can tap to dismissing the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.
* [x] User can drag a message right to either archive or delete the message
  * The archive icon will fade in as the user pans
  * After 60 pts, the archive icon should start moving with the translation and the background should change to green.
  * Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
  * After 260 pts, the icon should change to the delete icon and the background color should change to red.
  * Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.
* [x] Optional: Panning from the edge reveals the menu
* [x] Optional: If the menu is being revealed when the user lifts their finger, it should continue revealing.
* [x] Optional: If the menu is being hidden when the user lifts their finger, it should continue hiding.
* [x] Optional: Tapping on compose should animate to reveal the compose view.
* [x] Optional: Tapping the segmented control in the title should swipe views in from the left or right.

![Video Walkthrough](HW3_withOptionals.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).
