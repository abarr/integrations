defmodule Integrations.Core.Actions do
  use Tesla
  plug(Tesla.Middleware.JSON)

  def get(adapter, entity) do
    case get(build_url(adapter, entity)) do
      {:ok, %Tesla.Env{body: %{"error" => %{"code" => nil}, "results" => entities}}} ->
        {:ok, entities}

      result ->
        result
    end
  end

  defp build_url(adapter, entity) do
    Tesla.build_url(
      "#{adapter.base_url}#{entity}",
      access_token: adapter.api_key,
      status: "all"
    )
  end
end
