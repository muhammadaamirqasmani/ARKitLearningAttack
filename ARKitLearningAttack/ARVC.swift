//
//  ViewController.swift
//  ARKitLearningAttack
//
//  Created by admin on 27/10/2017.
//  Copyright © 2017 MuhammadAamir. All rights reserved.
//

import UIKit
import ARKit

class ARVC: UIViewController, ARSCNViewDelegate {
    
    // Variables and Constants
   // var sceneView: ARSCNView!
    let configration = ARWorldTrackingConfiguration()
    
    @IBOutlet weak var draw: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.sceneView = ARSCNView(frame: self.view.frame)
        sceneView.delegate = self
 //       view.addSubview(self.sceneView)
        self.sceneView.session.run(configration)
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.showsStatistics = true
        }
    
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let currentPositionOfCamera = orientation + location
        DispatchQueue.main.async {
            if self.draw.isHighlighted {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
                sphereNode.position = currentPositionOfCamera
                self.sceneView.scene.rootNode.addChildNode(sphereNode)
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
                print("button Pressed")
            }else{
                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
                pointer.name = "pointer"
                pointer.position = currentPositionOfCamera
                self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if node.name == "pointer"{
                        node.removeFromParentNode()
                    }
                })
                self.sceneView.scene.rootNode.addChildNode(pointer)
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                
        }
        }
        
    }
    
    
    func placeObject(x:CGFloat, y:CGFloat, z:CGFloat, r:CGFloat, a:CGFloat)
    {
        let node = SCNNode(geometry: SCNBox(width: x, height: y , length: z, chamferRadius: r))
        
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        
        node.position = SCNVector3(a, 0, -0.2)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(node)
        print("Object Place")
    }
}

func + (lhs: SCNVector3 , rhs: SCNVector3)-> SCNVector3{
    
    return SCNVector3Make(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
}

