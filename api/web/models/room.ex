defmodule Dora.Room do
  use Dora.Web, :model

  schema "rooms" do
    field :name, :string
    field :topic, :string
    many_to_many :users, Dora.User, join_through: "user_rooms"
    has_many :messages, Dora.Message

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :topic])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
