//
//  PhotoEditor+Drawing.swift
//  Photo Editor
//
//  Created by Mohamed Hamed on 6/16/17.
//
//

import UIKit

//var startPoint = CGPoint(x: 0, y: 0);

extension PhotoEditorViewController {
    
    override public func touchesBegan(_ touches: Set<UITouch>,
                                      with event: UIEvent?){
        if isDrawing {
            swiped = false
            if let touch = touches.first {
                lastPoint = touch.location(in: self.canvasImageView)
                firstPoint = touch.location(in: self.canvasImageView) // for rectangle
            }
        }
            //Hide stickersVC if clicked outside it
        else if stickersVCIsVisible == true {
            if let touch = touches.first {
                let location = touch.location(in: self.view)
                if !stickersViewController.view.frame.contains(location) {
                    removeStickersView()
                }
            }
        }
        
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>,
                                      with event: UIEvent?){
        if isDrawing {
            // 6
            swiped = true
            if let touch = touches.first {
                let currentPoint = touch.location(in: canvasImageView)
                drawLineFrom(lastPoint, toPoint: currentPoint) // , firstPoint: firstPoint) // for rectangle
                
                // 7
                lastPoint = currentPoint
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>,
                                      with event: UIEvent?){
        if isDrawing {
            if !swiped {
                // draw a single point
                drawLineFrom(lastPoint, toPoint: lastPoint) // , firstPoint: firstPoint) // for rectangle
            }
        }
        
    }

    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) { // pencil and marker
        // 1
        let canvasSize = canvasImageView.frame.integral.size
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            canvasImageView.image?.draw(in: CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height))
            // 2
            context.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
            context.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
            // 3
            context.setLineCap( CGLineCap.butt)
            // TODO@Nikonets: test brush size width
            context.setLineWidth(12.0)

            let red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 0.5) // opaciti is for marker

            context.setStrokeColor(red.CGColor)
            context.setBlendMode( CGBlendMode.normal)
            // 4
            context.strokePath()
            // 5
            canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
    }
    
//     func drawRectangle(_ fromPoint: CGPoint, toPoint: CGPoint) { //, firstPoint: CGPoint) { // for rectangle
//         // 1
//         let canvasSize = canvasImageView.frame.integral.size
//         UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
//         if let context = UIGraphicsGetCurrentContext() {
//             canvasImageView.image?.draw(in: CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height))
                        
//             print("from-> ", firstPoint.x, firstPoint.y)
//             print("  to-> ", toPoint.x, toPoint.y)
            
//             context.clear(CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height))
            
//             context.setLineCap(CGLineCap.round)
//             // TODO@Nikonets: test brush size width
//             context.setLineWidth(12.0)
//             // 2
// //            context.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
// //            context.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
            
//             // add lines
//             context.move(to: CGPoint(x: firstPoint.x, y: firstPoint.y))
//             context.addLine(to: CGPoint(x: toPoint.x, y: firstPoint.y))
            
//             context.move(to: CGPoint(x: toPoint.x, y: firstPoint.y))
//             context.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
            
//             context.move(to: CGPoint(x: toPoint.x, y: toPoint.y))
//             context.addLine(to: CGPoint(x: firstPoint.x, y: toPoint.y))
            
//             context.move(to: CGPoint(x: firstPoint.x, y: toPoint.y))
//             context.addLine(to: CGPoint(x: firstPoint.x, y: firstPoint.y))
            
//             // 3

//             let markerColor = UIColor(red: drawColor.cgColor.components?[0] ?? 0, green: drawColor.cgColor.components?[1] ?? 0, blue: drawColor.cgColor.components?[2] ?? 0, alpha: 0.5)
            
//             context.setStrokeColor(markerColor.cgColor)
//             context.setBlendMode( CGBlendMode.normal)
//             // 4
//             context.strokePath()
//             // 5
//             canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//         }
//         UIGraphicsEndImageContext()
//     }
}
