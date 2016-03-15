//
//  sunAnimateVController.swift
//  animation02
//
//  Created by supory on 16/3/2.
//  Copyright © 2016年 supory. All rights reserved.
//

import Foundation
import UIKit

class SunAnimateView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
         //
        drawSimpleBezierLine()
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
//    override func drawRect(rect: CGRect) {
//        //        let ctx = UIGraphicsGetCurrentContext()
//        //        CGContextAddRect(ctx, CGRectMake(100, 100, 50, 50))
//        //        CGContextStrokePath(ctx)
//        //1
//        let ctx = UIGraphicsGetCurrentContext()
//        //2
//        CGContextSetFillColorWithColor(ctx, UIColor.greenColor().CGColor)
//        let endAngle = CGFloat(2*M_PI)
//        CGContextAddArc(ctx, 50, 50, 25, 0, endAngle, 1)
//        
//        CGContextFillPath(ctx)
//    }
    
    func drawSimpleBezierLine(){
        
        //create an attrstring by the unique fontname and string
        let font = CTFontCreateWithName("PingFangSC-Light", 72, nil)
        let attrString = NSAttributedString(string: "开机页面动画", attributes: [kCTFontAttributeName as String: font])
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
                var t = CGAffineTransformMakeTranslation(position.x, position.y);
                
                CGPathAddPath(letters, &t, letter)
            }
        }
        
        
        
        
        //1make sure close path
        let bezierLinePath = UIBezierPath()
        bezierLinePath.moveToPoint(CGPointMake(0, 0))
        bezierLinePath.addLineToPoint(CGPointMake(200, 200))
        bezierLinePath.closePath()
        
        //add shaperlayer to draw bezier
        let shapLayer = CAShapeLayer()
        shapLayer.frame = CGRectMake(0, 0, 300, 400)
        shapLayer.path = letters
        shapLayer.strokeColor = UIColor.redColor().CGColor
        shapLayer.fillColor = UIColor.greenColor().CGColor
        shapLayer.lineWidth = 3.0
        //xy transform
        shapLayer.geometryFlipped = true
        
        self.layer.addSublayer(shapLayer)
        
        //add baseAnimation
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.fromValue = 0.0
        baseAnimation.toValue = 1
        baseAnimation.byValue = 0.1
        baseAnimation.duration = 10.0
        
        shapLayer.addAnimation(baseAnimation, forKey: "strokeEnd")
        
    }
}