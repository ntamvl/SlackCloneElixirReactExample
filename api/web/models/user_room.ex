defmodule Dora.UserRoom do
  use Dora.Web, :model

  schema "user_rooms" do
    belongs_to :user, Dora.User
    belongs_to :room, Dora.Room

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :room_id])
    |> validate_required([:user_id, :room_id])
    |> unique_constraint(:user_id_room_id)
  end
end
