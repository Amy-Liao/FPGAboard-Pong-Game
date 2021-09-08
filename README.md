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

## Block Diagram
#### The Whole Game
![image](https://user-images.githubusercontent.com/72532191/132470015-cb6b3afd-55ec-4203-8b5c-3bf87a173350.png)
#### Inside "game" Module
![image](https://user-images.githubusercontent.com/72532191/132470432-52721a77-c71b-4cb0-bfaa-3d853cef525b.png)
#### Inside "speaker" Module
![image](https://user-images.githubusercontent.com/72532191/132470736-7250b5cb-afa2-46d5-aa7a-2743eee9129d.png)

## Module Details
#### Frequency divider module:
Provide divided clock for other modules.
#### Level module: 
Assign level based on switches inputs.
#### Timer module:
Count game time. When the time is up, its output, “en”, will be 0 and be sent to 
“game” module. All LEDs will be lighted up and no new ball position will be 
generated.
#### Speaker module:
It contains two submodules which are “note_gen” and “speaker_control”. 
Together, they produce sound. In the speaker module, there is also a counter 
counting to 5 when the “timer” module sends “timeout” signal. For each
number in counter, it has one corresponding tone and submodules will generate 
those tones.
#### Game module:
This is where the game control be done. We can first detect left or right order for 
users via “keyboard” module. “Paddle” module gets the signal and outputs the 
leftmost paddle position. 
“Random_num” module can generate random ball position from zero to fifteen
which represents the rightmost to leftmost LED position. The output of this 
module is 4-bit ball position (LED position).
Given the current paddle leftmost position and assigned ball position, “get_point”
module will determine if our paddle cover the ball position. If it is, its output,
“next”, will be 1 and indicates the next ball position should be generated. That’s 
why this signal is also connected to “random_num” module. “Random_num”
module only generates new ball position when user gets point. “Next” signal is 
also sent to “score” module to record user’s score.
“Score” module record the tens digit and ones digit of user’s score and send it to 
“ssd” module.
#### ssd and ssd_control module:
Given “score_tens”, “score_ones”, and “ball_position” signals, “ssd” and 
“ssd_control” will display score and ball position on the 7-segment display.
