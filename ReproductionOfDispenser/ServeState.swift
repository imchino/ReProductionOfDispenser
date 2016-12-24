import GameplayKit

class ServeState: DispenserState {
    
    static let timeScale = 1.0
    
    init(game: GameScene) {
        super.init(game: game, associatedNodeName: "ServeState")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        playDispensingAnimationThenExit()
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is PartiallyFullState.Type, is EmptyState.Type:
            return true
        default:
            return false
        }
    }
    
    func playDispensingAnimationThenExit() {
        let slideCupAction    = SKAction(named: "slideCup",    duration: 3 * ServeState.timeScale)!
        let drainWaterAction  = SKAction(named: "drainWater",  duration: ServeState.timeScale)!
        let resetStreamAction = SKAction(named: "resetStream", duration: 0)!
        let resetCupAction    = SKAction(named: "resetCup",    duration: 0)!
        let fillCupAction     = SKAction(named: "fillCup",     duration: 2 * ServeState.timeScale)!

        let slideCupActionOnNode    = SKAction.run(slideCupAction,    onChildWithName: "//bottle")
        let drainWaterActionOnNode  = SKAction.run(drainWaterAction,  onChildWithName: "//water")
        let resetStreamActionOnNode = SKAction.run(resetStreamAction, onChildWithName: "//stream")
        let resetCupActionOnNode    = SKAction.run(resetCupAction,    onChildWithName: "//bottle")
        let fillCupActionOnNode     = SKAction.run(fillCupAction,     onChildWithName: "//stream")
        
        let waitAction = SKAction.wait(forDuration: ServeState.timeScale)
        let innerSequence = [waitAction, drainWaterActionOnNode,
                             waitAction, resetStreamActionOnNode,
                             waitAction, resetCupActionOnNode]
        let innerSequenceAction = SKAction.sequence(innerSequence)
        
        let group = [slideCupActionOnNode, fillCupActionOnNode, innerSequenceAction]
        let groupAction = SKAction.group(group)
        
        game.scene?.run(groupAction, completion: {
            let waterNode = self.game.childNode(withName: "//water") as! SKSpriteNode
            let restOfWater = waterNode.size.height
            if restOfWater < 1 {
                self.stateMachine?.enter(EmptyState.self)
            } else {
                self.stateMachine?.enter(PartiallyFullState.self)
            }
        })
    }
}
