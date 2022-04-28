defmodule M.Repo.Worker do
	use GenServer
  import  Ecto.Query
  require M.Core.Common
  alias   M.Core.Common
  require M.Core.Common.RepoCommand
  alias M.Repo.Basket
  alias M.Repo.Bought
  alias M.Repo.Course
  alias M.Repo.Lecturer
  alias M.Repo.Lession
  alias M.Repo.Payment
  alias M.Repo.Pricing
  alias M.Repo.Promotion
  alias M.Repo.Repo
  alias M.Repo.Room
  alias M.Repo.SalesOrder
  alias M.Repo.Shop
  alias M.Repo.SKU
  alias M.Repo.Studentship
  alias M.Repo.Tutorship
  alias M.Repo.User
  alias Phoenix.PubSub

  def start_link(args), do: GenServer.start_link(__MODULE__, args)





  @impl true

  def init(_args) do

    # Subscribe orders in command channel.
    #[
    #  "set on_network"
    #] |>
    #  Enum.map(&( PubSub.subscribe(Common.repo_write_pub_sub_name(), &1) ))

    # Subscribe "topic {:list, aggregate}" in query channel.
    [
      Basket,
      Bought.Package,
      Bought.Ticket,
      Course,
      Course.Plan,
      Lecturer,
      Lession,
      Payment,
      Pricing,
      Promotion,
      Room,
      Room.Vlog,
      SalesOrder,
      SalesOrder.Item,
      Shop,
      SKU,
      Studentship,
      Tutorship,
      User.Account,
      User.Token
    ]
    |> Enum.map(&( Common.RepoCommand.list(&1) |> Common.RepoCommand.topic ))
    |> Enum.map(&( PubSub.subscribe(M.Repo.pubsub_repo_query, &1) ))

    {:ok, %{}}
  end



  @impl true
  @spec handle_info(msg :: :timeout | term(), state :: term()) ::
  {:noreply, new_state}
  | {:noreply, new_state, timeout() | :hibernate | {:continue, term()}}
  | {:stop, reason :: term(), new_state}
  when new_state: term()

  def handle_info(msg, state)


  def handle_info({:list, target}, state) do
    list(target)
    |> then(&(
          PubSub.broadcast!(
            M.Repo.pubsub_repo_query,
            {:list, target} |> Common.RepoCommand.topic |> Common.RepoCommand.return,
            &1
          )
        ))
	  {:noreply, state}
  end


  def handle_info(_msg, state),
    do: {:noreply, state}



  @spec list(binary()) :: [{:object, binary(), id: term()}]

  defp list(target)

  defp list(table),
    do: Repo.all(from t in table, select: {:obejct, ^table, id: t.id})


end
