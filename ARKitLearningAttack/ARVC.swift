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
        self.sceneView.autoenablesDefaultLighting = true
        
        }
    
    
//    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
//        guard let pointOfView = sceneView.pointOfView else {return}
//        let transform = pointOfView.transform
//        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
//        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
//        let currentPositionOfCamera = orientation + location
//        DispatchQueue.main.async {
//            if self.draw.isHighlighted {
//                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
//                sphereNode.position = currentPositionOfCamera
//                self.sceneView.scene.rootNode.addChildNode(sphereNode)
//                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
//                print("button Pressed")
//            }else{
//                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
//                pointer.name = "pointer"
//                pointer.position = currentPositionOfCamera
//                self.sceneView.scene.rootNode.enumerateChildNodes({ (node, _) in
//                    if node.name == "pointer"{
//                        node.removeFromParentNode()
//                    }
//                })
//                self.sceneView.scene.rootNode.addChildNode(pointer)
//                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//
//        }
//        }
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let sun = SCNNode()
        let parentEarth = SCNNode()
        let parentVenus = SCNNode()
        let moonParent = SCNNode()
        
        sun.geometry = SCNSphere(radius: 0.3)
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun")
        
        sun.position = SCNVector3(0, 0, -1.5)
        parentEarth.position = SCNVector3(0, 0, -1.5)
        parentVenus.position = SCNVector3(0, 0, -1.5)
        moonParent.position = SCNVector3(1.2, 0, 0)
        
        let earth = placePlanet(geometry: SCNSphere(radius: 0.2), position: SCNVector3(1.2, 0, 0), diffuse: #imageLiteral(resourceName: "Earth Daymap"), normal: #imageLiteral(resourceName: "Earth Normal"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Cloud"), duration: 12)
        let venus = placePlanet(geometry: SCNSphere(radius:0.1), position: SCNVector3(0.7,0,0), diffuse: #imageLiteral(resourceName: "venus atmosphere"), normal: nil, specular: nil, emission: #imageLiteral(resourceName: "venus surface"), duration: 8)
        let venusMoon = placePlanet(geometry: SCNSphere(radius: 0.03), position: SCNVector3(0.15,0.01,0), diffuse: #imageLiteral(resourceName: "moon"), normal: nil, specular: nil, emission: nil, duration: 10)
        let earthMoon = placePlanet(geometry: SCNSphere(radius: 0.05), position: SCNVector3(0.3,0.01,0), diffuse: #imageLiteral(resourceName: "moon"), normal: nil, specular: nil, emission: nil, duration: 10)
        
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(parentEarth)
        self.sceneView.scene.rootNode.addChildNode(parentVenus)
        
        let sunAction = Rotation(time: 8)
//        let venusParentRotation = Rotation(time: 10)
//        let earthParentRotation = Rotation(time: 14)
//        let earthRotation = Rotation(time: 8)
//        let venusRotation = Rotation(time: 8)
//        let venusMoonAction = Rotation(time: 1)
//        let earthMoonAction = Rotation(time: 1)
        
        sun.runAction(sunAction)
//        parentVenus.runAction(venusParentRotation)
//        parentEarth.runAction(earthParentRotation)
//        earth.runAction(earthRotation)
//        venus.runAction(venusRotation)
//        venus.runAction(venusMoonAction)
//        moonParent.runAction(earthMoonAction)
        
        parentEarth.addChildNode(earth)
        parentVenus.addChildNode(venus)
        earth.addChildNode(earthMoon)
        venus.addChildNode(venusMoon)
//        parentEarth.addChildNode(moonParent)
        
//        moonParent.addChildNode(earthMoon)
        
        
        
    }
    
    func placePlanet(geometry: SCNSphere, position: SCNVector3, diffuse: UIImage, normal: UIImage?, specular: UIImage?, emission: UIImage?, duration: Int)-> SCNNode{
        let planet = SCNNode(geometry: geometry)
        planet.position = position
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: TimeInterval(duration))
        let forever = SCNAction.repeatForever(action)
        planet.runAction(forever)
        return planet

    }
    
    func Rotation (time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        let rotationForever = SCNAction.repeatForever(Rotation)
        return rotationForever
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
extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

//func + (lhs: SCNVector3 , rhs: SCNVector3)-> SCNVector3{
//
//    return SCNVector3Make(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
//}

