//
//  GameViewController.swift
//  runner macOS
//
//  Created by Henrique Ladeira on 05/10/23.
//

import Cocoa
import SceneKit

class GameViewController: NSViewController {
    
    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameController: GameController!
    var lastMouseLocation: NSPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameController = GameController(sceneRenderer: gameView)
        
        // Allow the user to manipulate the camera
        self.gameView.allowsCameraControl = false
        
        // Show statistics such as fps and timing information
        self.gameView.showsStatistics = true
        self.gameView.debugOptions = SCNDebugOptions(arrayLiteral: .showPhysicsShapes)
        
        // Configure the view
        self.gameView.backgroundColor = NSColor.black
        
        // Add a click gesture recognizer
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        var gestureRecognizers = gameView.gestureRecognizers
        gestureRecognizers.insert(clickGesture, at: 0)
        self.gameView.gestureRecognizers = gestureRecognizers
    }
    
    @objc
    func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
        // Highlight the clicked nodes
        let p = gestureRecognizer.location(in: gameView)
        gameController.highlightNodes(atPoint: p)
    }
    
    @objc
    override func mouseDragged(with event: NSEvent) {
        
        print(event)
        guard let lastLocation = lastMouseLocation else {
            lastMouseLocation = event.locationInWindow
            return
        }

        let location = event.locationInWindow
        let deltaX = event.deltaX
        let deltaY = event.deltaY

        let sensitivity: CGFloat = 0.005
//        gameController.camera.rotate(by: -deltaX * sensitivity, around: SCNVector3(0,1,0))
//        gameController.camera.rotate(by: deltaY * sensitivity, around: SCNVector3(1,0,0))
        gameController.camera.rotateOnPointOfView(dx: deltaX, dy: deltaY)
        lastMouseLocation = location

        if event.type == .leftMouseUp {
            lastMouseLocation = nil
        }
        
        lastMouseLocation = lastLocation
    }
    
    @objc
    override func keyDown(with event: NSEvent) {
        print(event.keyCode)
        switch (event.keyCode) {
        case 0: gameController.player.moveLeft(); break
        case 2: gameController.player.moveRight(); break
        case 12: gameController.player.rotate(by: 0.1); break
        case 13: gameController.player.jump(); break
        case 14:gameController.player.rotate(by: -0.1); break
        default:
            break
        }
            
    }
    
}
