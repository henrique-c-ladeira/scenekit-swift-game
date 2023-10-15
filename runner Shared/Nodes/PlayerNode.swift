//
//  Player.swift
//  runner
//
//  Created by Henrique Ladeira on 08/10/23.
//

import SceneKit

class PlayerNode: SCNNode {
    
    init(from scene: String) {
        super.init()
        
        let playerScene = SCNScene(named: "Model.scnassets/\(scene)")!
        let node = playerScene.rootNode
        let collisionGeometry = SCNBox(width: 1, height: 2, length: 1, chamferRadius: 0)
        
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: collisionGeometry))
        self.physicsBody?.allowsResting = true
        self.scale = SCNVector3(0.5, 0.5, 0.5)
        
        addChildNode(node)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveRight() {
        runAction(SCNAction.moveBy(x: -1, y: 0, z: 0, duration: 1))
    }
    
    func moveLeft() {
        runAction(SCNAction.moveBy(x: 1, y: 0, z: 0, duration: 1))
    }
    
    func moveForward() {
        let velocity = Float(2)
        runAction(SCNAction.moveBy(x: velocity * sin(rotation.y), y: 0, z: velocity * cos(rotation.y), duration: 1.0))
    }
    
    func moveBack() {
        runAction(SCNAction.moveBy(x: 0, y: 0, z: -1, duration: 1))
    }
    
    func rotate(by rotationAngle: CGFloat) {
        runAction(SCNAction.rotate(by: rotationAngle, around: SCNVector3(0, 1, 0), duration: 0.2))
//        self.node.rotation = SCNVector4(x: 0, y: 1, z: 0, w: self.node.rotation.w + rotationAngle)
    }
    
    
    func jump() {
        physicsBody?.applyForce(SCNVector3(x: 0, y: 10, z: 0), asImpulse: true)
    }
    
}
