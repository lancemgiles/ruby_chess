# Two player chess
Play from the command line. Written in Ruby

This is mostly functional and unlikely to receive further updates.

As it stands, the game is pretty playable. En passant and castling have not yet been implemented and are not planned to be. This game is a learning exercise, and while it is possible to implement these more advanced chess techniques, ultimately, chess is not the best game to play from a terminal, especially when restricted to two human players sharing one keyboard. Transforming this project into a polished game is contradictory to the nature of the project itself.

The game has very harsh error handling. Essentially, if a player tries to make an invalid move, they lose a turn. This means that if a player makes an invalid move while in check, on the following turn, their king can be captured. This eliminates the need for determining checkmate.

You can save, load, and quit by typing the corresponding word in instead of coordinates.

The game restricts piece movement to what is legal (other than castling and en passant), but does not confirm the player has selected to move a piece from their team. This gives sneaky players a chance to cheat.
