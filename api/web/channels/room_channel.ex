defmodule Dora.RoomChannel do
  use Dora.Web, :channel

  def join("rooms:" <> room_id, _params, socket) do
    room = Repo.get!(Dora.Room, room_id)
    IO.puts "join room...."
    IO.inspect room

    response = %{
      room: Phoenix.View.render_one(room, Dora.RoomView, "room.json"),
    }

    {:ok, response, assign(socket, :room, room)}
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end
end
