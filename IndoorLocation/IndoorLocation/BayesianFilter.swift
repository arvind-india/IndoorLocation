//
//  BayesianFilter.swift
//  IndoorLocation
//
//  Created by Dennis Hirschgänger on 14.04.17.
//  Copyright © 2017 Hirschgaenger. All rights reserved.
//

import Accelerate

class BayesianFilter {
    
    /**
     Execute the algorithm of the filter.
     - Parameter anchors: The set of active anchors
     - Parameter distances: A vector containing distances to all active anchors
     - Parameter acceleration: A vector containing the accelerations in x and y direction
     - Parameter successCallback: A closure which is called when the function returns successfully
     - Parameter position: The position determined by the algorithm
     */
    func computeAlgorithm(anchors: [Anchor], distances: [Float], acceleration: [Float], successCallback: @escaping (_ position: CGPoint) -> Void) {
        // Compute least squares algorithm
        if let position = leastSquares(anchors: anchors.map { $0.position }, distances: distances) {
            successCallback(position)
        }
    }
}
