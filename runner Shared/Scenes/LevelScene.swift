//
//  Stage.swift
//  runner
//
//  Created by Henrique Ladeira on 09/10/23.
//

import SceneKit

class LevelScene: SCNScene {
    
    let player: PlayerNode
    let camera: CameraNode
    
    override init() {
        player = PlayerNode(from: "abra.scn")
        camera = CameraNode()
        super.init()
        
        let lightNode = SCNNode()
        let light = SCNLight()
        light.type = .omni
        lightNode.light = light
        light.intensity = 10000
        lightNode.position = SCNVector3(x: 0, y: 5, z: 0)
        rootNode.addChildNode(lightNode)
        
        let floorGeometry = SCNBox(width: 50, height: 0.1, length: 500, chamferRadius: 0)
        let floor = SCNNode(geometry: floorGeometry)
        let material = SCNMaterial()
        material.diffuse.contents =  NSColor.lightGray
        floor.geometry?.firstMaterial = material
        floor.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: floorGeometry))
        floor.position = SCNVector3(0,0,0)
        
        let blockScene = SCNScene(named: "Art.scnassets/obstacle.scn")!
        let block = blockScene.rootNode.childNode(withName: "obstacle", recursively: true)!
        
        for index in (0...100) {
            let newBlock = SCNNode(geometry: block.geometry);
            newBlock.name = "block\(index)"
            newBlock.position.x = CGFloat.random(in: -10...5)
            newBlock.position.y = CGFloat.random(in: 10...20)
            newBlock.position.z =  CGFloat.random(in: 5...200)
            newBlock.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: newBlock.geometry!))
            rootNode.addChildNode(newBlock)
        }
        
        rootNode.addChildNode(floor)
        rootNode.addChildNode(camera)
        rootNode.addChildNode(player)
    }
    
    func update() {
        bindCamera()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindCamera() {
        camera.bind(to: player)
    }
}
