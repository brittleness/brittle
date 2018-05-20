defmodule Brittle.Web.Router do
  use Brittle.Web, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Brittle.Web do
    pipe_through :browser # Use the default browser stack

    get "/", SuiteController, :index
    resources "/suites", SuiteController, only: [:index] do
      resources "/runs", RunController, only: [:index, :show]
    end
  end

  scope "/api", Brittle.Web do
    pipe_through(:api)
    post("/runs", RunController, :create)
  end
end
