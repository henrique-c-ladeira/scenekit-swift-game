//
//  Camera.swift
//  runner
//
//  Created by Henrique Ladeira on 09/10/23.
//

import SceneKit

class CameraNode: SCNNode {
    
    override init() {
        let node = SCNNode()
        node.position = SCNVector3(0, 2 , -5)
        node.eulerAngles = SCNVector3(0, Double.pi, 0)
        
        let camera = SCNCamera()
        node.camera = camera
        
        super.init()
        
        addChildNode(node)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(to node: SCNNode) {
        runAction(SCNAction.move(to: node.worldPosition, duration: 0.1))
//        node.addChildNode(self)
//        runAction(SCNAction.move(to: node.position, duration: 0.1))
    }
}
