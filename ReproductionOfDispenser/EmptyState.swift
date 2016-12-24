import GameplayKit

class EmptyState: DispenserState {

    init(game: GameScene) {
        super.init(game: game, associatedNodeName: "EmptyState")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        let red = SKColor.red
        changeIndicatorLightToColor(red)
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        let black = SKColor.black
        changeIndicatorLightToColor(black)
    }
    
}
