defmodule Integrations.Core.Processor do
  use GenServer

  def init(integration) do
    {:ok, integration}
  end
end
