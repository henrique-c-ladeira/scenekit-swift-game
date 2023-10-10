//
//  Stage.swift
//  runner
//
//  Created by Henrique Ladeira on 09/10/23.
//

import SceneKit

class Stage {
    let scene: SCNScene
    
    init() {
        scene = SCNScene()
        
        let lightNode = SCNNode()
        let light = SCNLight()
        light.type = .omni
        lightNode.light = light
        light.intensity = 10000
        lightNode.position = SCNVector3(x: 0, y: 5, z: 0)
        scene.rootNode.addChildNode(lightNode)
        
        let floorGeometry = SCNBox(width: 50, height: 0.1, length: 500, chamferRadius: 0)
        let floor = SCNNode(geometry: floorGeometry)
        let material = SCNMaterial()
        material.diffuse.contents =  NSColor.lightGray
        floor.geometry?.firstMaterial = material
        floor.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: floorGeometry))
        floor.position = SCNVector3(0,0,0)
        
        let blockScene = SCNScene(named: "Art.scnassets/obstacle.scn")!
        let block = blockScene.rootNode.childNode(withName: "obstacle", recursively: true)!
        
        for index in (0...1000) {
            let newBlock = SCNNode(geometry: block.geometry);
            newBlock.name = "block\(index)"
            newBlock.position.x = CGFloat.random(in: -5...5)
            newBlock.position.y = 10
            newBlock.position.z =  10 * CGFloat(index + 1)
            newBlock.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: newBlock.geometry!))
            scene.rootNode.addChildNode(newBlock)
        }
        
        scene.rootNode.addChildNode(floor)
    }
}
