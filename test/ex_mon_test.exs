defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Horla"
      }

      assert expected_response == ExMon.create_player(:punch, :kick, :heal, "Horla")
    end
  end

  describe "start_game/1" do
    test "when the game starts return a message" do
      player = Player.build(:punch, :kick, :heal, "Horla")

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The battle has started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build(:punch, :kick, :heal, "Horla")
      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid do the move and computer makes a move" do
      messages =
        capture_io(fn ->
          assert ExMon.make_move(:punch) == :ok
        end)

      assert messages =~ "Player attacks enemy"
      assert messages =~ "It's computer turn"
      assert messages =~ "status: :continue"
      assert messages =~ "turn: :player"
    end

    test "when the move is invalid returns a message" do
      messages =
        capture_io(fn ->
          assert ExMon.make_move(:wrong) == :ok
        end)

      assert messages =~ "Oh oh! Looks that you're trying to do an inexistent move: wrong"
    end
  end
end
