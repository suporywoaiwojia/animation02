//
//  ViewController.swift
//  animation02
//
//  Created by supory on 16/3/2.
//  Copyright © 2016年 supory. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {

    var imageView :UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let viewSun = SunAnimateView(frame: CGRectMake(10,10,100,100))
//        self.view.addSubview(viewSun)
       drawSimpleBezierLine()
//          imageAnimation()
    }
    
    func imageAnimation(){
    
        self.imageView = UIImageView(frame:self.view.bounds)
        //        imageView?.backgroundColor = UIColor.greenColor()
        //
               self.imageView?.image = UIImage(named: "round_")
        
                self.view.addSubview(self.imageView!)
                self.view.bringSubviewToFront(self.imageView!)
        //

        //
                self.performSelector("scale_1", withObject: nil, afterDelay: 0.5)
                self.performSelector("scale_2", withObject: nil, afterDelay: 1.0)
                self.performSelector("scale_3", withObject: nil, afterDelay: 1.5)
                self.performSelector("scale_4", withObject: nil, afterDelay: 2.0)
                self.performSelector("scale_5", withObject: nil, afterDelay: 2.5)
                self.performSelector("showWord", withObject: nil, afterDelay: 3.0)
    
    }
    
    func scale_1()
    {
        let round_1 = UIImageView(frame: CGRectMake(100, 350, 15, 15))
        round_1.image = UIImage(named: "round_")
        imageView?.addSubview(round_1)
        setAnimation(round_1)
    }
    
    func scale_2()
    {
        let round_2 = UIImageView(frame:CGRectMake(105, 310, 20, 20))
        round_2.image = UIImage(named: "round_")
        imageView?.addSubview(round_2)
        setAnimation(round_2)
    }
    
    func scale_3()
    {
        let round_3 = UIImageView(frame:CGRectMake(125, 280, 30, 30))
        round_3.image = UIImage(named: "round_")
        imageView?.addSubview(round_3)
        setAnimation(round_3)
    }
    
    func scale_4()
    {
        let round_4 = UIImageView(frame:CGRectMake(160, 255, 40, 40))
        round_4.image = UIImage(named: "round_")
        imageView?.addSubview(round_4)
        setAnimation(round_4)
    }
    
    func scale_5()
    {
        let round_5 = UIImageView(frame:CGRectMake(135, 210, 100, 100))
        round_5.image = UIImage(named: "round_")
        imageView?.addSubview(round_5)
        setAnimation(round_5)
    }
    
    func setAnimation(nowView:UIImageView)
    {
        let x =  nowView.frame.origin.x
        let y = nowView.frame.origin.y
        let width = nowView.frame.size.width
        let height = nowView.frame.size.height
        
        let rect = CGRectMake(x - width*0.1, y-height*0.1, width*1.2, height*1.2)
        UIView.animateWithDuration(0.6, delay: 0.0, options: [], animations: { () -> Void in
            nowView.frame = rect
            }) { (Bool) -> Void in
                nowView.removeFromSuperview()
        }
        
    }
    
    func showWord()
    {
        let word_ = UIImageView(frame: CGRectMake(5, 440, 320, 200))
        
        word_.image = UIImage(named: "word")
        imageView!.addSubview(word_)
        
        word_.alpha = 0.0;
        UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: { () -> Void in
            word_.alpha = 1.0
            }) { (Bool) -> Void in
                
                // 完成后执行code
                NSThread.sleepForTimeInterval(1.0)
                self.imageView?.removeFromSuperview()
        }
        
    }



    
    
    //simple animation drawing and translate position
    func calculateSunXPosition(){
         let sunX = self.view.frame.size.width
 //       let sunY = self.view.frame.size.height
       let viewSun = SunAnimateView(frame: CGRectMake(10,10,100,100))
//        var newX:CGFloat = viewSun.frame.origin.x
//        let newY:CGFloat = viewSun.frame.origin.y
        self.view.addSubview(viewSun)
        UIView.animateWithDuration(15, delay: 0.0, options:.BeginFromCurrentState, animations: { () -> Void in
            
//           newX = newX < sunX ? viewSun.frame.origin.x++ : 0
//            newY = newY < sunY ? viewSun.frame.origin.y++ : 0
            
            
            viewSun.frame.origin = CGPointMake(sunX-100, 10)
            }) { (Bool) -> Void in
                 UIView.animateWithDuration(15.0, delay: 0.0, options: .BeginFromCurrentState, animations: { () -> Void in
                     viewSun.frame.origin = CGPointMake(10, 10)
                    }, completion: { (Bool) -> Void in
                        
                 })
        }
    }
    
    
    //draw bezier line
    func drawSimpleBezierLine(){
        
        //create an attrstring by the unique fontname and string
        let font = CTFontCreateWithName("ArialMT", 55, nil)
        let attrString = NSAttributedString(string: "123412351235开机页面动画", attributes: [kCTFontAttributeName as String: font])
        // create line by attrstring
        let line = CTLineCreateWithAttributedString(attrString)
        // create array make up of line
        let runArray = CTLineGetGlyphRuns(line)
        
        let letters = CGPathCreateMutable()
        
        for runindex in 0..<CFArrayGetCount(runArray){
            let run = CFArrayGetValueAtIndex(runArray, runindex)
            let newRun = unsafeBitCast(run, CTRunRef.self)
            
            for runGlyphIndex in 0..<CTRunGetGlyphCount(newRun) {
                let thisGlyphRange = CFRangeMake(runGlyphIndex, 1)
                
                var glyph: CGGlyph = CGGlyph()
                var position: CGPoint = CGPoint()
                
                CTRunGetGlyphs(newRun, thisGlyphRange, &glyph)
                CTRunGetPositions(newRun, thisGlyphRange, &position)
                
                let letter = CTFontCreatePathForGlyph(font, glyph, nil)
                // original xy transform yx
                var t = CGAffineTransformMakeTranslation(position.x, position.y);
                // user t to transfrom xy to yx then add to new path
                CGPathAddPath(letters, &t, letter)
            }
        }
        
        
        
        
        //1make sure close path
//    let bezierLinePath = UIBezierPath()
//        bezierLinePath.moveToPoint(CGPointMake(0, 0))
//        bezierLinePath.addLineToPoint(CGPointMake(200, 200))
//        bezierLinePath.closePath()
        
        //add shaperlayer to draw bezier 
        let shapLayer = CAShapeLayer()
        shapLayer.frame = CGRectMake(0, 0, 300, 400)
        shapLayer.path = letters
       shapLayer.strokeColor = UIColor.redColor().CGColor
        shapLayer.fillColor = UIColor.greenColor().CGColor
        shapLayer.lineWidth = 3.0
        //xy transform
       shapLayer.geometryFlipped = true
        
        self.view.layer.addSublayer(shapLayer)
        
        //add baseAnimation named strokeEnd
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.fromValue = 0.0
        baseAnimation.toValue = 1.0
        baseAnimation.byValue = 0.1
        baseAnimation.duration = 20.0
        
        shapLayer.addAnimation(baseAnimation, forKey: "strokeEnd")
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

