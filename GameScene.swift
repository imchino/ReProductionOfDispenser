import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var stateMachine: GKStateMachine!
    var previousUpdateTime: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        let fullState = FullState(game: self)
        let serveState = ServeState(game: self)
        let partiallyFullState = PartiallyFullState(game: self)
        let emptyState = EmptyState(game: self)
        let refillingState = RefillingState(game: self)
        
        stateMachine = GKStateMachine(states: [fullState,
                                               serveState,
                                               partiallyFullState,
                                               emptyState,
                                               refillingState])
        stateMachine.enter(FullState.self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        
        stateMachine.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime
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
            refillButton?.run(SKAction(named: "buttonPressed", duration: 0.6)!)
            stateMachine.enter(RefillingState.self)
        } else {
            print("attempt to dispense")
            stateMachine.enter(ServeState.self)
        }
    }
}
