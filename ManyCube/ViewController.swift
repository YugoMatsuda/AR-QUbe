//
//  ViewController.swift
//  ManyCube
//
//  Created by 松田 悠吾 on 2019-09-30.
//  Copyright © 2019 松田 悠吾. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var minHeight : CGFloat = 0.1
    var maxHeight :CGFloat = 0.2
    var minDispersal : CGFloat = -0.4
    var maxDispersal : CGFloat = 0.4

    func generateRandomVector() -> SCNVector3{
        return SCNVector3(CGFloat.random(in: minDispersal ... maxDispersal),
                          CGFloat.random(in: minDispersal ... maxDispersal),
                          CGFloat.random(in: minDispersal ... maxDispersal))
    }
    
    func generateRandomColor() -> UIColor{
        return UIColor(red: CGFloat.random(in: 0 ... 1),
                       green: CGFloat.random(in: 0 ... 1),
                       blue: CGFloat.random(in: 0 ... 1),
                       alpha: CGFloat.random(in: 0.5 ... 1))
    }
    
    func generateRandomSize() -> CGFloat{
        return CGFloat.random(in: minHeight ... maxHeight)
    }
    
    func generateCube(){
        let s = generateRandomSize()
        let cube = SCNBox(width: s, height: s, length: s, chamferRadius: 0.03)
        let material = SCNMaterial()
        material.diffuse.contents = generateRandomColor()
        cube.materials = [material]
    
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = generateRandomVector()
        let rotateAction = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 3)
        let repeatAction = SCNAction.repeatForever(rotateAction)
        cubeNode.runAction(repeatAction)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    @IBAction func addCube(_ sender: Any) {
        generateCube()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

   
}
