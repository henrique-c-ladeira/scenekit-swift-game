//
//  Player.swift
//  runner
//
//  Created by Henrique Ladeira on 08/10/23.
//

import SceneKit

class Player: Actor {
    
    let node: SCNNode
    
    init(from scene: String) {
        let playerScene = SCNScene(named: "Model.scnassets/\(scene)")!
        let node = playerScene.rootNode.childNode(withName: "node", recursively: true)!
//        let collisionGeometry = SCNBox(width: 1, height: 2, length: 1, chamferRadius: 0)
        
        self.node = node;
        
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        node.physicsBody?.allowsResting = true
        node.position = SCNVector3(x: 0, y: 0, z: 0)
//        node.physicsBody?.velocity.z = 5
        node.runAction(SCNAction.repeatForever(SCNAction.moveBy(x: 0, y: 0, z: 5, duration: 1)))
    }
    
    func addToScene(_ scene: SCNScene) {
        scene.rootNode.addChildNode(node)
    }
    
    func moveRight() {
//        if(node.position.x <= -1.5) { return }
//        node.runAction(SCNAction.moveBy(x: -1.5, y: 0, z: 0, duration: 0.3))
        node.physicsBody?.velocity.x = -2
    }
    
    func moveLeft() {
//        if(node.position.x >= 1.5) { return }
//        node.runAction(SCNAction.moveBy(x: 1.5, y: 0, z: 0, duration: 0.3))
        node.physicsBody?.velocity.x = 2
//        node.position.z -= 2
    }
    
    func jump() {
        node.physicsBody?.applyForce(SCNVector3(x: 0, y: 10, z: 0), asImpulse: true)
//        let upAction = SCNAction.moveBy(x: 0, y: 1.5, z: 0, duration: 0.5)
//        upAction.timingMode = .easeInEaseOut
//        let downAction = SCNAction.moveBy(x: 0, y: -1.5, z: 0, duration: 0.4)
//        downAction.timingMode = .easeIn
//        let sequence = [upAction,
//                        downAction]
//        let action = SCNAction.sequence(sequence)
//        node.runAction(action)
    }
    
}
