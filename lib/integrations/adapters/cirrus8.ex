defmodule Integrations.Adapters.Cirrus8 do
  defstruct(
    base_url: "https://api.cirrus8.com.au/v1/",
    api_key: nil
  )

  def new(fields) do
    struct!(__MODULE__, fields)
  end
end
