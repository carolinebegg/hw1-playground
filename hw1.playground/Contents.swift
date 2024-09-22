import SwiftUI

// MARK: - Protocols and Enums

protocol Location {
    var name: String { get }
    var description: String { get }
    var exits: [String: String] { get set }
    var actions: [Action] { get set }
    var items: [Item] { get set }
}

enum ActionType: String {
    case idle
    case listen
    case look
    case investigate
    case feel
}

// MARK: - Structs

struct Action {
    let type: ActionType
    let message: String
}

struct Item {
    let name: String
}

struct Court: Location {
    let name: String
    let description: String
    var exits: [String: String]
    var actions: [Action]
    var items: [Item]
    
    init(
        name: String,
        description: String,
        exits: [String: String] = [:],
        actions: [Action] = [],
        items: [Item] = []
    ) {
        self.name = name
        self.description = description
        self.exits = exits
        self.actions = actions
        self.items = items
    }
}

// MARK: - YourGame

struct YourGame: AdventureGame {
    // MARK: - Properties
    
    var title: String {
        return "A Court of Thorns and Roses"
    }
    
    var currentLocationName: String
    var locations: [String: Location]
    var inventory: [Item]
    var isWearingAmulet: Bool
    var hasDagger: Bool
    var hasToken: Bool
    
    // MARK: - Initializer
    
    init() {
        // Initialize properties
        currentLocationName = "The Wall"
        locations = [:]
        inventory = []
        isWearingAmulet = false
        hasDagger = false
        hasToken = false
        
        // Define actions
        let wallListen = Action(
            type: .listen,
            message: "You close your eyes and focus on the faint sounds beyond the Wall. The soft hum of magic fills the air, broken only by distant rustling from the other side, as if something is waiting."
        )
        let wallLook = Action(
            type: .look,
            message: "Your eyes trace the weathered surface of the Wall, its cracked stone worn by time. Vines snake up the sides, their twisting forms hinting at the magic pulsing just beneath the surface."
        )
        let wallInvestigate = Action(
            type: .investigate,
            message: "As you inspect the Wall closely, your fingers brush over the cracks, feeling the magic thrumming beneath the stone. In one spot, the mortar seems weaker, almost as if the Wall is hiding something."
        )
        let wallFeel = Action(
            type: .feel,
            message: "You press your hand against the cold stone, and the Wall seems to pulse faintly in response. The magic hums under your skin, alive and ancient, as if it's aware of your presence."
        )
        
        let faerieListen = Action(
            type: .listen,
            message: "The faerie’s voice is soft, barely above a whisper, but you hear the amusement in their tone. A low hum of magic fills the space between you, as if the very air is holding its breath."
        )
        let faerieLook = Action(
            type: .look,
            message: "The faerie’s glowing eyes watch you intently, their smile sharp and knowing. Every movement they make seems deliberate, as if they’re sizing you up for the bargain yet to come."
        )
        let faerieInvestigate = Action(
            type: .investigate,
            message: "You take in every detail—the shimmer of the faerie’s skin, the slight glow of magic surrounding them. Their presence radiates both danger and allure, tempting you to move closer despite the risks."
        )
        let faerieFeel = Action(
            type: .feel,
            message: "As you stand near the faerie, a strange warmth fills the air, wrapping around you like an invisible force. It feels heavy, almost tangible, as if the magic itself is waiting for your decision."
        )
        
        let forestListen = Action(
            type: .listen,
            message: "The forest is eerily quiet, save for the occasional rustle of leaves above. Faint whispers seem to drift through the trees, carried by a breeze that feels more magical than natural."
        )
        let forestLook = Action(
            type: .look,
            message: "The trees loom tall and twisted, their branches forming a dense canopy that blocks out the light. Shadows flicker across the ground, and between them, you notice subtle movements—perhaps something is watching you."
        )
        let forestInvestigate = Action(
            type: .investigate,
            message: "You crouch down, running your fingers over the forest floor. Hidden beneath the leaves, you notice faint tracks, too delicate to be human, leading deeper into the darkness."
        )
        let forestFeel = Action(
            type: .feel,
            message: "The air in the forest is thick with a magical charge, making your skin tingle. As you brush past the trees, their bark feels rough and alive, as if the forest itself is aware of your presence."
        )
        
        // Define items
        let ironDagger = Item(name: "iron dagger")
        let magicAmulet = Item(name: "magic amulet")
        let faerieToken = Item(name: "faerie token")
        
        // Define locations
        let spring = Court(
            name: "Spring Court",
            description: "Lush meadows stretch under a golden sun, surrounded by vibrant forests alive with birdsong. The air is thick with the scent of blossoms, and clear streams wind through the land. Though peaceful, a wild energy hums beneath the surface, hinting at untamed secrets.",
            exits: ["north": "Autumn Court", "south": "The Wall", "west": "Summer Court"]
        )
        
        let wall = Court(
            name: "The Wall",
            description: "You find yourself once again before the towering barrier of weathered stone, its surface cracked and pulsing with that familiar, faint magical hum. Vines continue to twist along its edges, and the air feels just as charged as before, thick with the knowledge that this Wall separates two very different worlds. The sense of foreboding that clings to it hasn't faded—it lingers, waiting.",
            exits: ["east": "East Wall", "west": "West Wall", "south": "Forest Bordering The Wall"],
            actions: [wallListen, wallLook, wallInvestigate, wallFeel]
        )
        
        let wallEast = Court(
            name: "East Wall",
            description: "You move east, tracing the length of the Wall as it rises imposingly above you. The air grows heavier with the scent of damp earth and old magic. As your fingers brush against the cold stone, you notice a small gap, just large enough to slip through. The stones here are worn and cracked, the magic weaker. It would be risky, but you could try to squeeze through.",
            exits: ["cross": "Spring Court", "west": "The Wall"],
            actions: [wallListen, wallLook, wallInvestigate, wallFeel]
        )
        
        let wallWest = Court(
            name: "West Wall",
            description: "As you walk west along The Wall, the dark shadows of the forest grow denser. The trees close in around you, their branches reaching like skeletal fingers. Deeper into the woods, the faint glow of a faerie catches your eye. The faerie watches you from a distance, their glowing eyes betraying no emotion. There’s something both inviting and dangerous about their presence, inexplicably tempting you to approach.",
            exits: ["approach": "Approach the Wall Faerie", "east": "The Wall"],
            actions: [wallListen, wallLook, wallInvestigate, wallFeel]
        )
        
        let wallFaerie = Court(
            name: "Approach the Wall Faerie",
            description: "You cautiously move toward the faerie, their glowing eyes flickering with amusement. A sly smile curls at their lips as you draw nearer. 'Ah,' they murmur, 'another mortal bold enough to seek passage. But nothing in this world comes without a price.' Their words hang in the air, the weight of a bargain not yet spoken.",
            exits: ["bargain": "Bargaining with the Wall Faerie", "retreat": "West Wall"],
            actions: [faerieListen, faerieLook, faerieInvestigate, faerieFeel]
        )
        
        let faerieBargain = Court(
            name: "Bargaining with the Wall Faerie",
            description: "The faerie’s smile sharpens as they step closer. 'I will guide you through the Wall unharmed,' they purr, 'but in return, you will owe me a favor. Not today, but when I come to collect, you must fulfill it, no matter the cost. Do you dare strike such a deal?'",
            exits: ["accept": "Spring Court", "reject": "West Wall"]
        )
        
        let forestWall = Court(
            name: "Forest Bordering The Wall",
            description: "You retreat from the Wall and into the dark forest. The trees close in around you, casting long shadows that make it difficult to see the path ahead, but impossible to stray off of it. The magic of the Wall still lingers, making the air feel heavy. There’s something watching you, but it’s unclear if it’s human or fae.",
            exits: ["north": "The Wall", "south": "Forest Clearing", "east": "Edge of Forest"],
            actions: [forestListen, forestLook, forestInvestigate, forestFeel]
        )
        
        let clearing = Court(
            name: "Forest Clearing",
            description: "As you continue exploring, you come upon a clearing in the forest, where something catches your eye. Hidden beneath a thick layer of leaves, you spot the glint of metal. You kneel down and uncover a worn, iron dagger, its blade rough but sturdy. Iron—the one thing that can cut through faerie magic. You sense that this weapon may be the key to surviving whatever dangers lie ahead.",
            exits: ["north": "Forest Bordering The Wall", "south": "Forest", "east": "Dark Forest"],
            actions: [forestListen, forestLook, forestInvestigate, forestFeel],
            items: [ironDagger]
        )
        
        let darkForest = Court(
            name: "Dark Forest",
            description: "The forest around you grows darker, the trees closing in like a cage. Suddenly, a low growl rumbles from the shadows. A massive beast, its eyes glowing with feral hunger, emerges from the underbrush. Its fur bristles as it bares its teeth, ready to strike. You know instinctively that magic alone won’t save you here.",
            exits: ["north": "Edge of Forest", "west": "Forest Clearing"]
        )
        
        let forestEdge = Court(
            name: "Edge of Forest",
            description: "You break through the dense undergrowth, the darkness of the forest thinning as you move north. The towering Wall looms ahead, visible through gaps in the trees, its surface faintly glowing with magic. The forest is still thick around you, but the air feels different—lighter, as if you're nearing the forest’s edge. Vines and roots tangle at your feet, but beyond the trees, the open space near the Wall beckons.",
            exits: ["north": "East Wall", "west": "Forest Bordering The Wall"],
            actions: [forestListen, forestLook, forestInvestigate, forestFeel]
        )
        
        let forest = Court(
            name: "Forest",
            description: "As you venture deeper into the forest, the shadows grow thicker, and the air feels charged with an eerie stillness. Suddenly, a glint of light catches your eye—a delicate amulet hangs from the branch of an old, twisted tree. Its surface shimmers with a faint, ethereal glow, pulsing in time with the slow rustling of the leaves. The magic radiating from it feels both inviting and unsettling. You pause, wondering if the amulet was placed here intentionally as a gift—or a trap.",
            exits: ["north": "Forest Clearing", "south": "The Mortal Lands"],
            actions: [forestListen, forestLook, forestInvestigate, forestFeel],
            items: [magicAmulet]
        )
        
        let mortal = Court(
            name: "The Mortal Lands",
            description: "You continue along the path, and the thick trees gradually give way to open space. As you emerge from the edge of the forest, the Mortal Lands unfold before you—rolling green hills stretch under a vast, open sky. Small villages are scattered across the landscape, nestled between fields and winding rivers. The scene is peaceful, yet an unseen barrier holds you back, the magic pressing against you like a wall. Just as you start to turn back, something catches your eye—half-buried in the grass, a small, glowing Faerie Token rests near the tree line, its faint light pulsing with ancient magic. Perhaps this is the key to crossing into Prythian.",
            exits: ["north": "Forest"],
            items: [faerieToken]
        )
        
        
        // Add locations to the dictionary
        locations = [
            "Spring Court": spring,
            "The Wall": wall,
            "East Wall": wallEast,
            "West Wall": wallWest,
            "Approach the Wall Faerie": wallFaerie,
            "Bargaining with the Wall Faerie": faerieBargain,
            "Forest Bordering The Wall": forestWall,
            "Forest": forest,
            "Forest Clearing": clearing,
            "Edge of Forest": forestEdge,
            "Dark Forest": darkForest,
            "The Mortal Lands": mortal,
        ]
    }
    
    // MARK: - AdventureGame Protocol Methods
    
    mutating func start(context: AdventureGameContext) {
        var attributedString = AttributedString("Your journey to the Spring Court begins here.")
        attributedString.swiftUI.foregroundColor = .green
        attributedString.inlinePresentationIntent = .emphasized // This applies italics
        context.write(attributedString)
        context.write("You stand in the shadow of The Wall, its towering presence both ancient and foreboding. The air hums with faint traces of magic, a reminder that just beyond this invisible barrier lies the faerie realm of Prythian—specifically, the Spring Court, a place of both beauty and danger. The Mortal Lands stretch behind you, but your heart is set on what lies ahead. Crossing the Wall comes at a great cost, but you know it’s the only way to reach the Spring Court. The choice is yours.")
    }
    
    mutating func handle(input: String, context: AdventureGameContext) {
        let arguments = input.split(separator: " ")
        guard !arguments.isEmpty else {
            context.write("Please enter a command.")
            return
        }
        let command = arguments[0].lowercased()
        switch command {
        case "north", "south", "east", "west", "approach", "retreat", "bargain", "accept", "reject", "cross":
            move(direction: command, context: context)
        case "listen", "investigate", "look", "feel":
            if let actionType = ActionType(rawValue: command) {
                performAction(type: actionType, context: context)
            } else {
                context.write("Invalid action.")
            }
        case "take":
            handleTakeCommand(arguments: arguments, context: context)
        case "wear":
            handleWearCommand(arguments: arguments, context: context)
        case "inventory":
            displayInventory(context: context)
        case "lost":
            lost(context: context)
        case "help":
            displayHelp(context: context)
        default:
            context.write("Invalid command.")
        }
    }
    
    // MARK: - Game Logic Methods
    
    mutating func move(direction: String, context: AdventureGameContext) {
        if let currentLocation = locations[currentLocationName],
           let nextLocationName = currentLocation.exits[direction],
           locations[nextLocationName] != nil {
            
            // Check if the player is attempting to make a bargain
            if currentLocationName == "Bargaining with the Wall Faerie" && direction == "accept" {
                makeBargain(context: context)
            } else if currentLocationName == "East Wall" && direction == "cross" {
                attemptToCrossWall(context: context)
            } else if nextLocationName == "Dark Forest" {
                encounterBeast(context: context)
            } else {
                currentLocationName = nextLocationName
                // Check if the player has reached the Spring Court
                if currentLocationName == "Spring Court" {
                    winGame(context: context)
                } else {
                    describe(context: context)
                }
            }
        } else {
            context.write("You can't go that way.")
        }
    }

    mutating func attemptToCrossWall(context: AdventureGameContext) {
        let hasFaerieToken = inventory.contains { $0.name.lowercased() == "faerie token" }
        
        if hasFaerieToken {
            context.write("You hold up the faerie token, and the magic around the gap in the Wall shimmers and parts, allowing you to pass through safely.")
            currentLocationName = "Spring Court"
            winGame(context: context)
        } else {
            context.write("You attempt to squeeze through the gap, but an invisible force repels you. It seems you need something special to pass through here.")
        }
    }

    mutating func makeBargain(context: AdventureGameContext) {
        if isWearingAmulet {
            context.write("The faerie’s smile falters as dark magic swirls around you. The amulet around your neck flares with light, shielding you from the curse. The faerie scowls but waves their hand, opening a shimmering passage through the Wall.")
            context.write("'It seems you’re protected, mortal. Safe passage, for now,' they mutter, disappearing as you step into the Spring Court, unharmed.")
            currentLocationName = "Spring Court"
            winGame(context: context)
        } else {
            var attributedString = AttributedString("The faerie’s smile fades into something darker as the curse takes hold. Your strength drains away, and you realize too late that the bargain was a trap. Bound to the fae, your life slips away, claimed by forces beyond your control.")
            attributedString.swiftUI.foregroundColor = .red
            context.write("The faerie’s grin widens as you accept. Dark magic wraps around you, sharp and cold. A curse sinks into your soul, freezing you in place.")
            context.write("'You should’ve known better,' the faerie whispers. 'You’ll remain here, bound to me forever'. The world fades as you realize you’re trapped in the faerie’s thrall for eternity.")
            context.write(attributedString)
            context.endGame()
        }
    }
    
    mutating func encounterBeast(context: AdventureGameContext) {
        context.write("The forest around you grows darker, the trees closing in like a cage. Suddenly, a low growl rumbles from the shadows. A massive beast, its eyes glowing with feral hunger, emerges from the underbrush. Its fur bristles as it bares its teeth, ready to strike. You know instinctively that magic alone won’t save you here.")
        hasDagger = inventory.contains { $0.name.lowercased() == "iron dagger" }
        if hasDagger {
            context.write("You draw the iron dagger, the weight of the weapon steadying your hand. The beast lunges, but the moment the iron blade slices through the air, the creature recoils, howling in pain. With a final blow, the beast falls, and the forest falls silent once more. The dagger’s iron edge has saved your life.")
            currentLocationName = "Dark Forest"
            describe(context: context)
        } else {
            var attributedString = AttributedString("The beast’s final strike lands with brutal force, and the world around you fades into darkness. The forest falls silent, and your journey ends here, lost to the shadows.")
            attributedString.swiftUI.foregroundColor = .red
            context.write("The beast lunges at you with terrifying speed. You try to fight back, but without a weapon strong enough to pierce its hide, your efforts are futile. The beast’s jaws close in, and you realize too late that you have no way to defend yourself.")
            context.write(attributedString)
            context.endGame()
        }
    }
    
    mutating func winGame(context: AdventureGameContext) {
        var attributedString = AttributedString("You've made it to the Spring Court, but your journey has only just begun.")
        attributedString.swiftUI.foregroundColor = .green
        attributedString.inlinePresentationIntent = .emphasized // This applies italics
        context.write("As you step through the Wall, the world shifts. The heavy gloom of the forest lifts, replaced by the warmth of eternal spring. Lush meadows stretch out, dotted with vibrant wildflowers, while sunlight filters through the green canopy. A clear stream winds through the landscape, and the air is filled with the sweet scent of blossoms and birdsong.")
        context.write("The warmth of the Spring Court embraces you as you step through the Wall. You take a breath and feel the magic all around you.")
        context.write(attributedString)
        context.endGame()
    }
    
    // MARK: - Command Handlers
    
    mutating func handleTakeCommand(arguments: [Substring], context: AdventureGameContext) {
        if arguments.count > 1 {
            let itemName = arguments[1...].joined(separator: " ")
            takeItem(named: itemName, context: context)
        } else {
            context.write("Take what?")
        }
    }
    
    mutating func handleWearCommand(arguments: [Substring], context: AdventureGameContext) {
        if arguments.count > 1 {
            let itemName = arguments[1...].joined(separator: " ")
            wearItem(named: itemName, context: context)
        } else {
            context.write("Wear what?")
        }
    }
    
    // MARK: - Helper Methods
    
    func describe(context: AdventureGameContext) {
        if let location = locations[currentLocationName] {
            context.write(location.description)
//            displayExits(context: context)
//            displayItems(context: context)
        } else {
            context.write("You are lost.")
        }
    }
    
//    func displayExits(context: AdventureGameContext) {
//        if let location = locations[currentLocationName], !location.exits.isEmpty {
//            let exits = location.exits.keys.joined(separator: ", ")
//            context.write("Exits: \(exits)")
//        }
//    }
    
//    func displayItems(context: AdventureGameContext) {
//        if let location = locations[currentLocationName], !location.items.isEmpty {
//            let items = location.items.map { $0.name }.joined(separator: ", ")
//            context.write("You see: \(items)")
//        }
//    }
    
    func displayInventory(context: AdventureGameContext) {
        if inventory.isEmpty {
            context.write("Your inventory is empty.")
        } else {
            let items = inventory.map { $0.name }.joined(separator: ", ")
            context.write("Inventory: \(items)")
        }
    }
    
    func lost(context: AdventureGameContext) {
        context.write("Current location: \(currentLocationName)")
    }
    
    mutating func takeItem(named itemName: String, context: AdventureGameContext) {
        if var location = locations[currentLocationName] as? Court {
            if let index = location.items.firstIndex(where: { $0.name.lowercased() == itemName.lowercased() }) {
                let item = location.items.remove(at: index)
                inventory.append(item)
                context.write("You have taken the \(item.name).")
                // Update the location's items
                locations[currentLocationName] = location
            } else {
                context.write("There is no \(itemName) here.")
            }
        } else {
            context.write("You can't take items here.")
        }
    }
    
    mutating func wearItem(named itemName: String, context: AdventureGameContext) {
        if let index = inventory.firstIndex(where: { $0.name.lowercased() == itemName.lowercased() }) {
            let item = inventory[index]
            if item.name.lowercased() == "magic amulet" {
                isWearingAmulet = true
                context.write("You put the \(item.name) on. You feel a protective aura surround you.")
            } else {
                context.write("You can't wear the \(item.name).")
            }
        } else {
            context.write("You don't have a \(itemName).")
        }
    }
    
    mutating func performAction(type: ActionType, context: AdventureGameContext) {
        guard let location = locations[currentLocationName] as? Court else {
            context.write("Location not found.")
            return
        }
        if let action = location.actions.first(where: { $0.type == type }) {
            context.write(action.message)
        } else {
            context.write("Nothing happens.")
        }
    }
    
    func displayHelp(context: AdventureGameContext) {
        var attributedString = AttributedString("Available Commands:")
        attributedString.swiftUI.foregroundColor = .green
        context.write(attributedString)

        // Display exits
        if let location = locations[currentLocationName], !location.exits.isEmpty {
            let exits = location.exits.keys.joined(separator: ", ")
            context.write("- Exits: \(exits)")
        }
        
        // Display actions
        if let location = locations[currentLocationName] as? Court, !location.actions.isEmpty {
            let actions = location.actions.map { actionTypeToString($0.type) }.joined(separator: ", ")
            context.write("- Actions: \(actions)")
        }
        
        // Display general commands
        let generalCommands = ["take [item]", "wear [item]", "inventory", "help"]
        context.write("- General Commands: \(generalCommands.joined(separator: ", "))")
    }
    
    func actionTypeToString(_ actionType: ActionType) -> String {
        switch actionType {
        case .idle:
            return "idle"
        case .listen:
            return "listen"
        case .investigate:
            return "investigate"
        case .look:
            return "look"
        case .feel:
            return "feel"
        }
    }
}

// Leave this line in - this line sets up the UI you see on the right.
// Update this if you rename your AdventureGame implementation.
YourGame.display()
