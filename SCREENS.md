# Game Screens

## Main Menu
```
╔════════════════════════════════════╗
║                                    ║
║         [Purple/Blue               ║
║          Gradient                  ║
║          Background]               ║
║                                    ║
║           DODGE IT                 ║
║         (Large, Bold,              ║
║          Glowing)                  ║
║                                    ║
║         PLAY OR DIE                ║
║         (Red, Bold)                ║
║                                    ║
║      ┌──────────────┐              ║
║      │  PLAY NOW    │              ║
║      └──────────────┘              ║
║      (Red Button)                  ║
║                                    ║
║   "Dodge falling objects and       ║
║    survive as long as you can!"    ║
║                                    ║
╚════════════════════════════════════╝
```

## Game Screen (Before Start)
```
╔════════════════════════════════════╗
║  Score: 0                     [X]  ║
║                                    ║
║      [Dark Blue/Black              ║
║       Gradient Background]         ║
║                                    ║
║                                    ║
║        TAP TO START                ║
║        (Large, Glowing)            ║
║                                    ║
║      ┌──────────────┐              ║
║      │    START     │              ║
║      └──────────────┘              ║
║      (Green Button)                ║
║                                    ║
║    "Swipe left/right to move"     ║
║                                    ║
║                                    ║
║                                    ║
║            [Player]                ║
║          (Green Circle)            ║
║                                    ║
╚════════════════════════════════════╝
```

## Game Screen (Playing)
```
╔════════════════════════════════════╗
║  Score: 42                    [X]  ║
║                                    ║
║         ●                          ║
║        (Red)                       ║
║                                    ║
║                   ●                ║
║                (Yellow)            ║
║                                    ║
║      ●                             ║
║    (Purple)                        ║
║                                    ║
║                        ●           ║
║                      (Red)         ║
║                                    ║
║              ●                     ║
║           (Yellow)                 ║
║                                    ║
║                    [Player]        ║
║                  (Green Circle)    ║
║                                    ║
╚════════════════════════════════════╝
```

## Game Over Screen
```
╔════════════════════════════════════╗
║                                    ║
║       [Black Overlay]              ║
║                                    ║
║         GAME OVER                  ║
║      (Large, Red, Glowing)         ║
║                                    ║
║       Final Score: 42              ║
║       (White, Bold)                ║
║                                    ║
║                                    ║
║  ┌────────┐      ┌────────┐        ║
║  │  MENU  │      │ RETRY  │        ║
║  └────────┘      └────────┘        ║
║  (Grey Btn)      (Green Btn)       ║
║                                    ║
║                                    ║
╚════════════════════════════════════╝
```

## Visual Elements

### Player
- Green circle with white border
- Glowing effect (greenAccent shadow)
- Game controller icon in center
- Size: 60x60 pixels

### Falling Objects
- Three types: Red, Yellow, Purple
- Circular shapes
- Glowing effects matching their colors
- Size: 40x40 pixels
- Random spawn positions
- Constant falling speed

### UI Elements
- Modern Material Design buttons
- Rounded corners (30px radius)
- Elevation shadows
- Clear text with good contrast
- Responsive to different screen sizes

### Color Scheme
- Background: Purple (#4A148C) → Blue (#0D47A1) → Black gradient
- Player: Green (#4CAF50) with white border
- Objects: Red (#F44336), Yellow (#FFEB3B), Purple (#9C27B0)
- Text: White (#FFFFFF) with blue glow effect
- Accent: Red (#FF5252) for "PLAY OR DIE" tagline

### Animations
- Smooth 60 FPS gameplay
- Falling objects move continuously
- Player responds instantly to touch
- Score updates in real-time
- Smooth transitions between screens
