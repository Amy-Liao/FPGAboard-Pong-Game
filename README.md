# FPGAboard-Pong-Game
## Game Rule
This project is an implementation of pong game on FPGA board. You need to hit the ball and get scores as much as possible.  
#### Game Objects
- Paddle (consecutive LEDs)
- Designated ball position (right 2 digits of 7-segment display)
- Your score (left 2 digits of 7-segment display)

#### Game Control
- Control paddle ("A" and "D" keys on keyboard)
- Start game (up button)
- Restart game (down button)
- Choose game level (When the rightmost switch is on, it's level 1. When the second switch from the right is on, it's level 2.)

Before the game starts, all LEDs are lighted up. You can now select game level. Level 1 has paddle with 5 LEDs long, while level 2 has only 3 LEDs for paddle. 
After selecting game level, you can start the game by pressing "up" button on FPGA board. The game lasts for 20 seconds. During the game, the right 2 digits of 7-segment display
will show the designated ball position which indicates which LED you should light up by your paddle. For example, if the designated ball position is 15, you need to move your paddle 
by pressing "A" (left) or "D" (right) to light up the leftmost LED. Once you successfully light the right LED, your score (displayed on the left 2 digits of 7-segment) will be 
incremented by 1. The game will be over after 20 seconds, and the music which represents the end of game will be played as well. You can restart your game by pressing "up" button.
## Required Tools
- FPGA board (Basys 3 Xilinx Artix-7)
- Pmod I2S
- Vivado
- Keyboard
- Audio device



