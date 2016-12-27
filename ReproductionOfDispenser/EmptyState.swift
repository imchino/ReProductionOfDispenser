import GameplayKit

class EmptyState: DispenserState {

    var flashTimeCounter: TimeInterval = 0
    static let flashingInterval: TimeInterval = 0.6
    
    var lightOn = true {
        didSet {
            let color = (lightOn ? SKColor.red : SKColor.black)
            changeIndicatorLightToColor(color)
        }
    }
    
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
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass is RefillingState.Type)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        flashTimeCounter += seconds
        
        if flashTimeCounter > EmptyState.flashingInterval {
            lightOn = !lightOn
            flashTimeCounter = 0
        }
    }
    
}
