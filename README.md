# CIUP7
Basketball Game controllable via volume of voice.
Realized with the Processing Framework.

![Screenshot (254)](https://user-images.githubusercontent.com/44921828/160443383-6cfdc978-f1aa-4060-99d0-c0ce5c1b0056.png)

In the program a mini game related to basketball is implemented. 
Balls are falling from the top of the window and can either be catched with a basket or fall to the ground.
When the ball falls into the basket, the 'IN' counter is increased, otherwise, the 'OUT' counter is incresed.
A game takes 30 seconds and finishes, when the ball, which is falling at zero seconds, touches the ground or the basket(buzzer beater).
Sounds for the ball falling into the basket and the end of the game are added for more realism and auditive feedback.

The basket is controlled and moved by the sound volume of the user. When the volume is high, the basket is moving right or is at the lower right corner. If the volume is low, the basket moves left or is at the left lower corner.

We recommend playing the game without noise in the background.

The Processing sound library has to be imported to run the game and microphone access has to be granted.

References: Processing.org, Sound: https://mixkit.co/free-sound-effects/basketball/, Images:https://es.m.wikipedia.org/wiki/Archivo:Basketball_Clipart.svg, https://www.nicepng.com/ourpic/u2q8e6w7u2e6u2e6_basketball-net-png-high-quality-image-basketball-net/

Written by: Dascha Blehm 2022


