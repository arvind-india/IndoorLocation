//
//  PointView.swift
//  IndoorLocation
//
//  Created by Dennis Hirschgänger on 27.06.17.
//  Copyright © 2017 Hirschgaenger. All rights reserved.
//

import UIKit

enum PointType {
    case position(CGPoint)
    case anchor(Anchor)
    case particle(Particle)
}

class PointView: UIView {
    
    var pointSize: CGFloat
    let pointType: PointType
    
    init(pointType: PointType) {
        self.pointType = pointType
        
        var width: CGFloat
        var pointPosition: CGPoint
        
        switch pointType {
        case .position(let position):
            pointSize = 20
            width = pointSize
            pointPosition = position
        case .anchor(let anchor):
            pointSize = 20
            width = 5 * pointSize
            pointPosition = anchor.position
        case .particle(let particle):
            pointSize = 5
            width = pointSize
            pointPosition = particle.position
        }
        
        let frameRect = CGRect(x: pointPosition.x - pointSize / 2, y: pointPosition.y - pointSize / 2, width: width, height: pointSize)
        super.init(frame: frameRect)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let pointPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: pointSize, height: pointSize))
        
        let pointLayer = CAShapeLayer()
        pointLayer.path = pointPath.cgPath
        
        switch pointType {
        case .position:
            pointLayer.fillColor = UIColor.green.cgColor
            
        case .anchor(let anchor):
            pointLayer.fillColor = UIColor.red.cgColor
            
            // Label
            let attributes = [
                NSFontAttributeName: UIFont.systemFont(ofSize: pointSize),
                NSForegroundColorAttributeName: UIColor.red,
                ] as [String : Any]
            
            let idString = NSString(format: "%2X", anchor.id)
            idString.draw(at: CGPoint(x: 1.25 * pointSize, y: 0), withAttributes: attributes)
            
        case .particle:
            pointLayer.fillColor = UIColor.blue.cgColor
        }
        
        layer.addSublayer(pointLayer)
    }
    
    func updatePoint(withPointType pointType: PointType) {
        var width: CGFloat
        var pointPosition: CGPoint
        
        switch pointType {
        case .position(let position):
            width = pointSize
            pointPosition = position
        case .anchor(let anchor):
            width = 5 * pointSize
            pointPosition = anchor.position
        case .particle(let particle):
            width = pointSize
            pointPosition = particle.position
        }
        
        frame = CGRect(x: pointPosition.x - pointSize / 2, y: pointPosition.y - pointSize / 2, width: width, height: pointSize)
    }
}
