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
        
        let blockScene = SCNScene(named: "Art.scnassets/obstacle.scn")!
        
        self.camera = scene.rootNode.childNode(withName: "camera", recursively: true)!
        player = Player(from: "player.scn")
        
        super.init()
        
        sceneRenderer.delegate = self
        
        camera.anchor(to: player.node)
        
        let floor = scene.rootNode.childNode(withName: "plane", recursively: true)!
        
        floor.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: floor.geometry!))
        
        let block = blockScene.rootNode.childNode(withName: "obstacle", recursively: true)!
        
        for index in (0...100) {
            let newBlock = SCNNode(geometry: block.geometry);
            newBlock.name = "block\(index)"
            newBlock.rotation = SCNVector4(Double.pi,0,Double.pi,Double.pi)
            newBlock.position.x = CGFloat.random(in: -1...1)
            newBlock.position.y = 0.5
            newBlock.position.z =  10 * CGFloat(index + 1)
            newBlock.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: newBlock.geometry!))
            scene.rootNode.addChildNode(newBlock)
        }
        
        
        player.addToScene(scene)
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
