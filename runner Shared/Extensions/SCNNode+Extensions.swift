//
//  SCNNode+Extensions.swift
//  runner
//
//  Created by Henrique Ladeira on 08/10/23.
//

import SceneKit

extension SCNNode {
    func anchor(to node: SCNNode) {
        self.position = SCNVector3(x: node.position.x, y: node.position.y + 1, z: node.position.z - 3)
        self.rotation = SCNVector4(x: 0, y: Double.pi, z: 0, w: Double.pi)
        let pointOfView = SCNNode()
        pointOfView.position = node.position
        pointOfView.position.z = node.position.z + 20
        
        constraints = [SCNLookAtConstraint(target: pointOfView)]
        
    }
}
