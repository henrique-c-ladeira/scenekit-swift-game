//
//  GameController.swift
//  runner Shared
//
//  Created by Henrique Ladeira on 05/10/23.
//

import SceneKit

#if os(macOS)
    typealias SCNColor = NSColor
#else
    typealias SCNColor = UIColor
#endif

class GameController: NSObject, SCNSceneRendererDelegate {
    
    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    
    let player: Player
    let camera: SCNNode
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        scene = SCNScene(named: "Art.scnassets/stage1.scn")!
//        scene = SCNScene()
        let lightNode = SCNNode()
        let light = SCNLight()
        light.type = .omni // Isso cria uma luz omnidirecional
        lightNode.light = light
        light.intensity = 10000 // Ajuste o valor conforme necessário
        lightNode.position = SCNVector3(x: 0, y: 5, z: 0) // Ajuste a posição da luz conforme necessário
        scene.rootNode.addChildNode(lightNode)
        
        self.camera = scene.rootNode.childNode(withName: "camera", recursively: true)!
        player = Player(from: "player.scn")
//        camera = Camera()
        
        super.init()
        
        sceneRenderer.delegate = self
        
        camera.anchor(to: player.node)
        
        let floorGeometry = SCNBox(width: 50, height: 0.1, length: 500, chamferRadius: 0)
        let floor = SCNNode(geometry: floorGeometry)
        let material = SCNMaterial()
        material.diffuse.contents =  NSColor.red// Configurar a cor do material
        floor.geometry?.firstMaterial = material
        
        floor.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: floorGeometry))
        floor.position = SCNVector3(0,0,0)
        
        let blockScene = SCNScene(named: "Art.scnassets/obstacle.scn")!
        let block = blockScene.rootNode.childNode(withName: "obstacle", recursively: true)!
        
        for index in (0...100) {
            let newBlock = SCNNode(geometry: block.geometry);
            newBlock.name = "block\(index)"
            
//            newBlock.rotation = SCNVector4(Double.pi,0,Double.pi,Double.pi)
            newBlock.position.x = CGFloat.random(in: -1...1)
            newBlock.position.y = 10
            newBlock.position.z =  10 * CGFloat(index + 1)
            newBlock.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: newBlock.geometry!))
            scene.rootNode.addChildNode(newBlock)
        }
        
        
        player.addToScene(scene)
//        camera.addToScene(scene)
        scene.rootNode.addChildNode(floor)
        sceneRenderer.scene = scene
    }
    
    func highlightNodes(atPoint point: CGPoint) {
        let hitResults = self.sceneRenderer.hitTest(point, options: [:])
        for result in hitResults {
            // get its material
            guard let material = result.node.geometry?.firstMaterial else {
                return
            }
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = SCNColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = SCNColor.red
            
            SCNTransaction.commit()
        }
    }
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
        if(player.node.position.z > 80) {
            player.node.position.z = 0
        }
        camera.anchor(to: player.node)
        
    }

}
