import SpriteKit

class GameScene: SKScene {
    
    override func didChangeSize(_ oldSize: CGSize) {
        let dispenser = childNode(withName: "dispenser")
        dispenser?.position.x = size.width / 2
    }
    
}
