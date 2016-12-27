import GameplayKit

class PartiallyFullState: DispenserState {
    
    init(game: GameScene) {
        super.init(game: game, associatedNodeName: "PartiallyFullState")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("water is partially full...")
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is ServeState.Type, is RefillingState.Type:
            return true
        default:
            return false
        }
    }
    
}
