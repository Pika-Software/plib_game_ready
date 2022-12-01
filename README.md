# Game Ready
A small module that adds the ability to record the end of the player connection or start the server.

## Functions
### `[SHARED]` game.IsReady()
- Return: `boolean` - true if the startup is complete.

### Player Object
#### `[SHARED]` PLAYER:Initialized()
- Return: `boolean` - true if player fully connected and can move (net library is ready to use).

## Hooks
### `[CLIENT]` GM:PlayerDisconnected( `player` ply )
### `[SHARED]` GM:PlayerInitialized( `player` ply )
### `[SHARED]` GM:GameReady()
