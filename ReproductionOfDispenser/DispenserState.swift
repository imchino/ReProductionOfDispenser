import SpriteKit
import GameplayKit

class DispenserState: GKState {

    let game: GameScene
    let associatedNodeName: String
    
    init(game: GameScene, associatedNodeName: String) {
        self.game = game
        self.associatedNodeName = associatedNodeName
    }

    override func didEnter(from previousState: GKState?) {
        let associatedNode = game.childNode(withName: "//\(associatedNodeName)") as? SKSpriteNode
        guard let node = associatedNode else { return }
        node.color = SKColor.lightGray
    }
    
    override func willExit(to nextState: GKState) {
        let associatedNode = game.childNode(withName: "//\(associatedNodeName)") as? SKSpriteNode
        guard let node = associatedNode else { return }
        node.color = SKColor.darkGray
    }
    
    func changeIndicatorLightToColor(_ color: SKColor) {
        let indicator = game.childNode(withName: "//indicator") as! SKSpriteNode
        indicator.color = color
    }
}
