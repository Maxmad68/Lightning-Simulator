//
//  Functions.swift
//  Lightning
//
//  Created by Maxime on 02/04/2021.
//

import Foundation
import CoreGraphics
import UIKit

/// Returns the nearest point on line of which coordinates are specified from specified point
///
/// - Parameters
///     x, y (Double) : Coordinates of the point
///     x1, y1 (Double) : Coordinates of first point of diagonal of line
///     x2, y2 (Double) : Coordinates of other point of diagonal of line
///
/// - Returns
///     CGPoint
///
func pDistance(x: Double, y: Double, x1: Double, y1: Double, x2: Double, y2: Double) -> CGPoint {
    
    let A = x - x1
    let B = y - y1
    let C = x2 - x1
    let D = y2 - y1
    
    let dot = A * C + B * D
    let len_sq = C * C + D * D
    var param = -1.0
    if (len_sq != 0) { //in case of 0 length line
        param = dot / len_sq
    }
    
    var xx, yy: Double
    
    if (param < 0) {
        xx = x1
        yy = y1
    }
    else if (param > 1) {
        xx = x2
        yy = y2
    }
    else {
        xx = x1 + param * C
        yy = y1 + param * D
    }
    
    return CGPoint(x: xx, y: yy)
    
//    let dx = x - xx
//    let dy = y - yy
//    return (dx * dx + dy * dy).squareRoot()
}

/// Returns the nearest point on line from specified point
///
/// - Parameters
///     point (CGPoint) : Point to get nearest point of
///     line (Line) : Line on which the point to get
///
/// - Returns
///     CGPoint
///
func nearestPoint(point: CGPoint, line: Line) -> CGPoint {
    return pDistance(
        x: Double(point.x),
        y: Double(point.y),
        x1: Double(line.start.x),
        y1: Double(line.start.y),
        x2: Double(line.end.x),
        y2: Double(line.end.y)
    )
}

extension Int {
    public static var noGround = 0
    
    public static var random: Int = -42666 // Any constant
    
}


extension UIImage {
    static func gradientImage(withBounds: CGRect, startPoint: CGPoint, endPoint: CGPoint , colors: [CGColor]) -> UIImage {
        
        // Configure the gradient layer based on input
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = withBounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        // Render the image using the gradient layer
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

extension CGPoint {
    ///
    /// Calculate distance with another point
    ///
    /// - Returns:
    ///     Double
    ///
    func distance(from b: CGPoint) -> Double {
        let xDist = self.x - b.x
        let yDist = self.y - b.y
        return Double(sqrt(xDist * xDist + yDist * yDist))
    }
    
    ///
    /// Returns the square of the distance with another point.
    /// This aims essentialy only to compare with another distance.
    /// This save time of calculating the square root of the value.
    ///
    /// - Returns:
    ///     CGFloat
    ///
    func sqdistance(from b: CGPoint) -> CGFloat {
        let xDist = self.x - b.x
        let yDist = self.y - b.y
        return xDist * xDist + yDist * yDist
    }
}
