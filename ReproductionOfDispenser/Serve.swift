import GameplayKit

class ServeState: DispenserState {
    
    static let timeScale = 1.0
    
    init(game: GameScene) {
        super.init(game: game, associatedNodeName: "ServeState")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        waitAndExit()
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PartiallyFullState.Type
    }
    
    func waitAndExit() {
        let waitAction = SKAction.wait(forDuration: ServeState.timeScale)
        game.scene?.run(waitAction, completion: {
            self.stateMachine?.enter(PartiallyFullState.self)
        })
    }
}
