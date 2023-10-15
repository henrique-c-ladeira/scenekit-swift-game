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
        
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: collisionGeometry))
        node.physicsBody?.allowsResting = true
        node.scale = SCNVector3(0.5, 0.5, 0.5)
//        node.runAction(SCNAction.repeatForever(SCNAction.moveBy(x: 0, y: 0, z: 5, duration: 1)))
        
        addChildNode(node)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveRight() {
        physicsBody?.velocity.x = -2
    }
    
    func moveLeft() {
        physicsBody?.velocity.x = 2
    }
    
    func rotate(by rotationAngle: CGFloat) {
        runAction(SCNAction.rotate(by: rotationAngle, around: SCNVector3(0, 1, 0), duration: 0.2))
//        self.node.rotation = SCNVector4(x: 0, y: 1, z: 0, w: self.node.rotation.w + rotationAngle)
    }
    
    func jump() {
        physicsBody?.applyForce(SCNVector3(x: 0, y: 10, z: 0), asImpulse: true)
    }
    
}
