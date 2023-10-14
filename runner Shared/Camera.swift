//
//  Camera.swift
//  runner
//
//  Created by Henrique Ladeira on 09/10/23.
//

import SceneKit

class Camera {
    let node: SCNNode
    let pointOfView: SCNNode
    let camera: SCNCamera
    
    init() {
        node = SCNNode()
        node.position = SCNVector3(0, 2 , -5)
        node.eulerAngles = SCNVector3(0, Double.pi, 0)
        
        pointOfView = SCNNode()
        pointOfView.position =  SCNVector3(0, 2, 0)
        pointOfView.eulerAngles = SCNVector3(0, 0, Double.pi)
        pointOfView.addChildNode(node)
        
        camera  = SCNCamera()
        node.camera = camera
    }
    
    func addToNode(_ node: SCNNode) {
        node.addChildNode(self.pointOfView)
//        self.node.constraints = [SCNLookAtConstraint(target: node)]
    }
    
//    func anchor(to node: SCNNode) {
//        self.node.anchor(to: node)
//    }
    
    func rotate(by rotationAngle: CGFloat) {
//        let action = SCNAction.group([
//            SCNAction.moveBy(x: 0, y: 0, z: rotationAngle > 0 ? rotationAngle : -rotationAngle, duration: 0.2),
//            SCNAction.rotate(by: rotationAngle, around: SCNVector3(0, 1, 0), duration: 0.2)
//        ])
//        self.node.rotate(by: SCNQ, aroundTarget: <#T##SCNVector3#>)
//        let action = SCNAction.rotate(by: rotationAngle, around: pointOfView.worldPosition, duration: 0.2)
//        node.runAction(action)
//        self.node.rotation = SCNVector4(x: 0, y: 1, z: 0, w: self.node.rotation.w + rotationAngle)
//        self.node.rotate(by: SCNQuaternion(x: 0, y: 1, z: 0, w: 0), aroundTarget: pointOfView.position)
        
    }
    func rotateOnPointOfView(dx: CGFloat, dy: CGFloat, sensitivite: CGFloat = 0.01) {
//        self.node.rotate(by: SCNQuaternion(x: dx / (dx*dx + dy*dy), y: dy / (dx*dx + dy*dy), z: 0, w: sensitivite / (dx*dx + dy*dy)), aroundTarget: pointOfView.worldPosition)
        let action = SCNAction.sequence([
            SCNAction.rotate(by: dx * sensitivite, around: SCNVector3(0,-1,0), duration: 0.2),
            SCNAction.rotate(by: dy * sensitivite, around: SCNVector3(1,0,0), duration: 0.2)
        ])
        pointOfView.runAction(action)
    }
}
