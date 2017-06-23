defmodule Dora.UserController do
  use Dora.Web, :controller

  alias Dora.User

  def create(conn, params) do
    changeset = User.registration_changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user, :access)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> render(Dora.SessionView, "show.json", user: user, jwt: jwt)
        
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Dora.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
