import GameplayKit

class RefillingState: DispenserState {
    
    static let waterNodeHeight: CGFloat = 280
    
    init(game: GameScene) {
        super.init(game: game, associatedNodeName: "RefillingState")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        playRefillAnimationThenExit()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass is FullState.Type)
    }
    
    func playRefillAnimationThenExit() {
        let waterNode = game.scene?.childNode(withName: "//water") as! SKSpriteNode
        let consumptionOfwater = RefillingState.waterNodeHeight - waterNode.size.height
        let waterRatio = consumptionOfwater / RefillingState.waterNodeHeight
        let refillTime = TimeInterval(waterRatio)
        
        let refillAction = SKAction(named: "refillDispenser", duration: refillTime)!
        waterNode.run(refillAction, completion: {
            self.stateMachine?.enter(FullState.self)
        })
    }
    
}
