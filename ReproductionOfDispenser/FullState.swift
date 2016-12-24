import SpriteKit
import GameplayKit

class FullState: DispenserState {
    
    init(game: GameScene) {
        super.init(game: game, associatedNodeName: "FullState")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)

        let green = SKColor.green
        changeIndicatorLightToColor(green)
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        let black = SKColor.black
        changeIndicatorLightToColor(black)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        print("whether next is Serve or ...")
        return stateClass is ServeState.Type
    }

}
