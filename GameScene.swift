import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var stateMachine: GKStateMachine!
    
    override func didMove(to view: SKView) {
        let fullState = FullState(game: self)
        let serveState = ServeState(game: self)
        let partiallyFullState = PartiallyFullState(game: self)
        
        stateMachine = GKStateMachine(states: [fullState,
                                               serveState,
                                               partiallyFullState])
        
        stateMachine.enter(FullState.self)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        let dispenser = childNode(withName: "dispenser")
        dispenser?.position.x = size.width / 2
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let locationInView = touches.first?.location(in: view)
        let locationInScene = convertPoint(fromView: locationInView!)
        
        let refillButton = childNode(withName: "//refillButton")
        let location = locationInScene
        
        if atPoint(location) == refillButton {
            print("attempt to refill.")
        } else {
            print("attempt to dispense")
            stateMachine.enter(ServeState.self)
        }
    }
}
