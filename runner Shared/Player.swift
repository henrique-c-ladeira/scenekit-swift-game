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
        let playerScene = SCNScene(named: "Art.scnassets/\(scene)")!
        let node = playerScene.rootNode.childNode(withName: "shipMesh", recursively: true)!
        let playerCollisionBox = playerScene.rootNode.childNode(withName: "collision", recursively: true)!
        
        self.node = node;
        
        node.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: playerCollisionBox.geometry!))
        node.position = SCNVector3(x: 0, y: 0.2, z: 0)
        
        node.runAction(SCNAction.repeatForever(SCNAction.moveBy(x: 0, y: 0, z: 5, duration: 1)))
    }
    
    func addToScene(_ scene: SCNScene) {
        scene.rootNode.addChildNode(node)
    }
    
    func moveRight() {
        if(node.position.x <= -1.5) { return }
        node.runAction(SCNAction.moveBy(x: -1.5, y: 0, z: 0, duration: 0.3))
    }
    
    func moveLeft() {
        if(node.position.x >= 1.5) { return }
        node.runAction(SCNAction.moveBy(x: 1.5, y: 0, z: 0, duration: 0.3))
    }
    
    func jump() {
        let upAction = SCNAction.moveBy(x: 0, y: 1.5, z: 0, duration: 0.5)
        upAction.timingMode = .easeInEaseOut
        let downAction = SCNAction.moveBy(x: 0, y: -1.5, z: 0, duration: 0.4)
        downAction.timingMode = .easeIn
        let sequence = [upAction,
                        downAction]
        let action = SCNAction.sequence(sequence)
        node.runAction(action)
    }
    
}
