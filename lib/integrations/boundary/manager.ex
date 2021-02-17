defmodule Integrations.Boundary.Manager do
  use GenServer

  alias Integrations.Core.Integration

  def add_client(manager \\ __MODULE__, client) do
    GenServer.call(manager, {:add_client, client})
  end

  def add_client_integration(manager \\ __MODULE__, client, service, fields) do
    GenServer.call(manager, {:add_integration, client, service, fields})
  end

  def list_integrations(manager \\ __MODULE__) do
    GenServer.call(manager, {:list_integrations})
  end

  def init(integrations) when is_map(integrations) do
    {:ok, integrations}
  end

  def init(_integrations), do: {:error, "Must be map"}

  def handle_call({:add_client, client}, _from, integrations) do
    cond do
      Map.has_key?(integrations, client) -> {:reply, :ok, integrations}
      true ->
        {:reply, :ok, Map.put(integrations, client, %{})}
    end
  end

  def handle_call({:add_integration, client, service, fields}, _from, integrations) do
    with {:ok, integration} <- Integration.new(service, fields) do

      integrations = Map.update!(integrations, client, fn(client_integrations) ->
        Map.put(client_integrations, service, integration)
      end)
      {:reply, :ok, integrations}
    else
      {:error, msg} ->
        {:reply, {:error, msg}, integrations}
    end
  end

  def handle_call({:list_integrations}, _from, integrations) do
    {:reply, {:ok, integrations}, integrations}
  end

end
