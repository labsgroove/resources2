# Party NPC Spawner

## Overview
This project is a script for the QBCore framework that allows players to spawn NPCs around them by executing the "party" command. The script randomly places 20 NPCs within a 15-unit radius and assigns them specific models and animations.

## File Structure
```
party
├── client
│   └── main.lua
├── server
│   └── main.lua
├── config
│   └── config.lua
├── fxmanifest.lua
└── README.md
```

## Installation
1. Download the project files.
2. Place the `party` folder in your QBCore resources directory.
3. Add `start party` to your server configuration file (usually `server.cfg`).

## Usage
- To spawn the NPCs, simply type the command `/party` in the game chat.
- The NPCs will be randomly generated around the player and will perform their assigned animations.

## Configuration
- NPC Models: `cs_tracydisanto`, `s_f_y_clubbar_01`, `s_f_y_hooker_01`
- Animations: `mi_idle_c_m03`, `hi_dance_facedj_09_v1_female^3`
- Spawn Radius: 15 units

## Notes
- Ensure that you have the necessary permissions to execute commands in the game.
- This script is designed for use with the QBCore framework and may not work with other frameworks.