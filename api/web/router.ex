defmodule Dora.Router do
  use Dora.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", Dora do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", Dora do
    pipe_through :api
    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    resources "/users", UserController, only: [:create]

    get "/users/:id/rooms", UserController, :rooms
    # resources "/rooms", RoomController, only: [:index, :create]
    get "/rooms", RoomController, :index
    post "/rooms", RoomController, :create
    options "/rooms", RoomController, :create
    post "/rooms/:id/join", RoomController, :join
  end

  # resources "/users", UserController, except: [:new, :edit]
  # resources "/rooms", RoomController, except: [:new, :edit]
end
