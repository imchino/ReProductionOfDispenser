import GameplayKit

class PartiallyFullState: DispenserState {
    
    init(game: GameScene) {
        super.init(game: game, associatedNodeName: "PartiallyFullState")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("water is partially full...")
    }
    
}
