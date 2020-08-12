# ###### ExMon ######

This is a funny turn based game project built with Elixir

To create a player to the game you need to provide some initial informations

ExMon.create_player(MOVE_AVERAGE, MOVE_RANDOM, MOVE_HEAL, PLAYER_NAME)

MOVE_AVERAGE: Damage  18..25
MOVE_RANDOM:  Damage  10..35
MOVE_HEAL:    Restore 18..35

To run/test the game execute the following commands:

1: iex -S mix

# For attacks and heal choose the names you want... Horla parameter is a name, you can choose whatever you want
2: player = ExMon.create_player(:punch, :kick, :heal, "Horla") 
3: ExMon.start_game(player)

# Call make_move function providing the attack parameter with name has been choosed
4: ExMon.make_move(:punch) or ExMon.make_move(:kick) or ExMon.make_move(:heal)

# ENJOY IT! #





