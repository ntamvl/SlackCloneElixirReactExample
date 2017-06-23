defmodule Dora.UserView do
  use Dora.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Dora.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Dora.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email
    }
  end
end
