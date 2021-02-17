defmodule Integrations.Core.Integration do

  alias Integrations.Adapters

  defstruct ~w[
    adapter
  ]a

  def new(:cirrus8, fields) do
    adapter = Adapters.Cirrus8.new(fields)
    integration = struct!(
      __MODULE__,
      adapter: adapter
    )
    {:ok, integration}
  end
  def new(:another, fields) do
    adapter = Adapters.Cirrus8.new(fields)
    integration = struct!(
      __MODULE__,
      adapter: adapter
    )
    {:ok, integration}
  end
  def new(_, _), do: {:error, "Service not supported"}
end
