# Two player chess
Play from the command line. Written in Ruby

This is a work in progress.

As it stands, the game is pretty playable. En passant and castling have not yet been implemented. Nor has checkmate, and being in check doesn't actually trigger anything. There is also no end to the game, even if all pieces are captured, there will be no gameover.

You can save, load, and quit by typing the corresponding word in instead of coordinates.

There is limited error checking. The game restricts piece movement to what is legal (other than castling and en passant and moves while in check), but does not confirm the player has selected to move a piece from their team. This gives sneaky players a chance to cheat (may leave this as a feature).
