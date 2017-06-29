defmodule Dora.RoomController do
  use Dora.Web, :controller

  alias Dora.Room

  plug Guardian.Plug.EnsureAuthenticated, handler: Dora.SessionController

  def index(conn, params) do
    rooms = Repo.all(Room)
    render(conn, "index.json", rooms: rooms)

    # page =
    #   Dora.Room
    #   |> order_by([asc: :id])
    #   |> Dora.Repo.paginate(params)
    #
    # render(conn, "index.json", page: page)
  end

  def create(conn, params) do
    IO.puts "Starting to create a new room..."
    IO.inspect params
    IO.puts "+++++++++++++++++++++++++++++++++++++x"

    current_user = Guardian.Plug.current_resource(conn)
    changeset = Room.changeset(%Room{}, params)

    case Repo.insert(changeset) do
      {:ok, room} ->
        assoc_changeset = Dora.UserRoom.changeset(
          %Dora.UserRoom{},
          %{user_id: current_user.id, room_id: room.id}
        )
        Repo.insert(assoc_changeset)

        conn
        |> put_status(:created)
        |> render("show.json", room: room)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Dora.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, params) do
    room = Repo.get!(Room, params["id"])
    changeset = Room.changeset(room, params)

    case Repo.update(changeset) do
      {:ok, room} ->
        conn
        |> put_status(:ok)
        |> render("show.json", %{room: room})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Dora.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def join(conn, %{"id" => room_id}) do
    current_user = Guardian.Plug.current_resource(conn)
    room = Repo.get(Room, room_id)

    changeset = Dora.UserRoom.changeset(
      %Dora.UserRoom{},
      %{room_id: room.id, user_id: current_user.id}
    )

    case Repo.insert(changeset) do
      {:ok, _user_room} ->
        conn
        |> put_status(:created)
        |> render("show.json", %{room: room})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Dora.ChangesetView, "error.json", changeset: changeset)
    end
  end
end

# defmodule Dora.RoomController do
#   use Dora.Web, :controller
#
#   alias Dora.Room
#
#   plug Guardian.Plug.EnsureAuthenticated, handler: Dora.SessionController
#
#   def index(conn, _params) do
#     rooms = Repo.all(Room)
#     render(conn, "index.json", rooms: rooms)
#   end
#
#   def create(conn, %{"room" => room_params}) do
#     IO.puts "Creating a new room..."
#
#     current_user = Guardian.Plug.current_resource(conn)
#     changeset = Room.changeset(%Room{}, room_params)
#
#     case Repo.insert(changeset) do
#       {:ok, room} ->
#         assoc_changeset = Dora.UserRoom.changeset(
#           %Dora.UserRoom{},
#           %{user_id: current_user.id, room_id: room.id}
#         )
#         Repo.insert(assoc_changeset)
#
#         conn
#         |> put_status(:created)
#         |> render("show.json", room: room)
#       {:error, changeset} ->
#         conn
#         |> put_status(:unprocessable_entity)
#         |> render(Dora.ChangesetView, "error.json", changeset: changeset)
#     end
#   end
#
#   def join(conn, %{"id" => room_id}) do
#     current_user = Guardian.Plug.current_resource(conn)
#     room = Repo.get(Room, room_id)
#
#     changeset = Dora.UserRoom.changeset(
#       %Dora.UserRoom{},
#       %{room_id: room.id, user_id: current_user.id}
#     )
#
#     case Repo.insert(changeset) do
#       {:ok, _user_room} ->
#         conn
#         |> put_status(:created)
#         |> render("show.json", %{room: room})
#       {:error, changeset} ->
#         conn
#         |> put_status(:unprocessable_entity)
#         |> render(Dora.ChangesetView, "error.json", changeset: changeset)
#     end
#   end
#
#   def show(conn, %{"id" => id}) do
#     room = Repo.get!(Room, id)
#     render(conn, "show.json", room: room)
#   end
#
#   def update(conn, %{"id" => id, "room" => room_params}) do
#     room = Repo.get!(Room, id)
#     changeset = Room.changeset(room, room_params)
#
#     case Repo.update(changeset) do
#       {:ok, room} ->
#         render(conn, "show.json", room: room)
#       {:error, changeset} ->
#         conn
#         |> put_status(:unprocessable_entity)
#         |> render(Dora.ChangesetView, "error.json", changeset: changeset)
#     end
#   end
#
#   def delete(conn, %{"id" => id}) do
#     room = Repo.get!(Room, id)
#
#     # Here we use delete! (with a bang) because we expect
#     # it to always work (and if it does not, it will raise).
#     Repo.delete!(room)
#
#     send_resp(conn, :no_content, "")
#   end
# end
