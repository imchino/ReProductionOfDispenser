import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    let scene = SKScene(fileNamed: "GameScene")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        
        let scaleFactor = scene.size.height / view.bounds.height
        scene.scaleMode = .aspectFit
        scene.size.width = view.bounds.width * scaleFactor
        
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true   //兄弟ノード順を無視して描画効率UP
    }
}

