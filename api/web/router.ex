defmodule Dora.Router do
  use Dora.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Dora do
    pipe_through :api
  end
end
