import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 2D Arcade',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const GameMenu(),
    );
  }
}

class GameMenu extends StatelessWidget {
  const GameMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade900,
              Colors.blue.shade900,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DODGE IT',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.blue,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'PLAY OR DIE',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10,
                  ),
                  child: const Text(
                    'PLAY NOW',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Dodge falling objects and survive as long as you can!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double playerX = 0.5;
  int score = 0;
  bool gameOver = false;
  bool gameStarted = false;
  Timer? gameTimer;
  List<FallingObject> fallingObjects = [];
  final Random random = Random();
  
  // Game constants
  static const double playerWidth = 60.0;
  static const double playerHeight = 60.0;
  static const double objectSize = 40.0;
  static const int frameDurationMs = 16; // ~60 FPS
  static const double objectFallSpeed = 0.008;
  static const double objectSpawnChance = 0.02;
  static const int scoreFrameDivisor = 60; // Convert frames to seconds

  void startGame() {
    setState(() {
      gameStarted = true;
      gameOver = false;
      score = 0;
      fallingObjects.clear();
      playerX = 0.5;
    });

    gameTimer = Timer.periodic(const Duration(milliseconds: frameDurationMs), (timer) {
      if (!gameOver) {
        updateGame();
      }
    });
  }

  void updateGame() {
    setState(() {
      // Update falling objects
      for (var obj in fallingObjects) {
        obj.y += objectFallSpeed;
      }

      // Remove objects that are off screen
      fallingObjects.removeWhere((obj) => obj.y > 1.2);

      // Add new objects randomly
      if (random.nextDouble() < objectSpawnChance) {
        fallingObjects.add(FallingObject(
          x: random.nextDouble() * 0.9 + 0.05,
          y: -0.1,
          type: random.nextInt(3),
        ));
      }

      // Check collisions
      for (var obj in fallingObjects) {
        if (checkCollision(obj)) {
          endGame();
          break;
        }
      }

      // Increase score
      if (gameStarted && !gameOver) {
        score++;
      }
    });
  }

  bool checkCollision(FallingObject obj) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    final playerLeft = playerX * screenWidth - playerWidth / 2;
    final playerRight = playerX * screenWidth + playerWidth / 2;
    final playerTop = screenHeight - 120 - playerHeight;
    final playerBottom = screenHeight - 120;
    
    final objLeft = obj.x * screenWidth - objectSize / 2;
    final objRight = obj.x * screenWidth + objectSize / 2;
    final objTop = obj.y * screenHeight - objectSize / 2;
    final objBottom = obj.y * screenHeight + objectSize / 2;
    
    return !(playerRight < objLeft ||
        playerLeft > objRight ||
        playerBottom < objTop ||
        playerTop > objBottom);
  }

  void endGame() {
    setState(() {
      gameOver = true;
    });
    gameTimer?.cancel();
  }

  void movePlayer(double delta) {
    setState(() {
      playerX = (playerX + delta).clamp(0.1, 0.9);
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (gameStarted && !gameOver) {
            movePlayer(details.delta.dx / screenWidth);
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.blue.shade900,
              ],
            ),
          ),
          child: Stack(
            children: [
              // Score display
              Positioned(
                top: 50,
                left: 20,
                child: Text(
                  'Score: ${(score / scoreFrameDivisor).floor()}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.blue,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),

              // Falling objects
              ...fallingObjects.map((obj) {
                return Positioned(
                  left: obj.x * screenWidth - objectSize / 2,
                  top: obj.y * screenHeight - objectSize / 2,
                  child: Container(
                    width: objectSize,
                    height: objectSize,
                    decoration: BoxDecoration(
                      color: obj.type == 0
                          ? Colors.red
                          : obj.type == 1
                              ? Colors.yellow
                              : Colors.purple,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: obj.type == 0
                              ? Colors.red.withOpacity(0.5)
                              : obj.type == 1
                                  ? Colors.yellow.withOpacity(0.5)
                                  : Colors.purple.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              }),

              // Player
              if (gameStarted)
                Positioned(
                  left: playerX * screenWidth - playerWidth / 2,
                  bottom: 120,
                  child: Container(
                    width: playerWidth,
                    height: playerHeight,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.greenAccent,
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.sports_esports,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

              // Start game overlay
              if (!gameStarted && !gameOver)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'TAP TO START',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.blue,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: startGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'START',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Swipe left/right to move',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

              // Game over overlay
              if (gameOver)
                Container(
                  color: Colors.black87,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'GAME OVER',
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.redAccent,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Final Score: ${(score / scoreFrameDivisor).floor()}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'MENU',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: startGame,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'RETRY',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              // Back button
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FallingObject {
  double x;
  double y;
  int type;

  FallingObject({
    required this.x,
    required this.y,
    required this.type,
  });
}
