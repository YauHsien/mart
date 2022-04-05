defmodule M.Member.Session.Registry do
  use GenServer
  alias Registry
  alias M.Member.Session.Account
  @reg_key_member_user "member:user"

  def start_link(id: id),
    do: GenServer.start_link(M.Member.Session.Registry, :noargs, name: id)

  @spec find_user_by_username(registry::pid(), username::String.t(), password::String.t()) :: {:ok, user_pid :: pid()} | {:error, reason :: term()}
  def find_user_by_username(registry, username, password),
    do: GenServer.call(registry, {@reg_key_member_user,username,password})

  @spec find_user_by_token(registry :: pid(), user_token :: String.t()) :: {:ok, user_pid :: pid()} | {:error, reason :: term()}
  def find_user_by_token(registry, user_token),
    do: GenServer.call(registry, {@reg_key_member_user,user_token})

  @impl true
  @spec init(any) :: {:ok, %{registry_name: M.Member.Registry}}
  def init(_args) do
    {:ok, %{
        registry_name: M.Member.Registry
     }}
  end

  @impl true
  def handle_call({@reg_key_member_user, username, password}, _from, %{registry_name: registry_name}=state),
    do: {:reply,
         find_user(username, password, registry_name),
         state}

  def handle_call({@reg_key_member_user, user_token}, _from, %{registry_name: registry_name}=state),
    do: {:reply, user_token, state} # FIXME: check available user_token

  def handle_call(_request, _from, state),
    do: {:noreply, state}

  def find_user(username, password, registry_name),
    do: Registry.lookup(registry_name, @reg_key_member_user<>":"<>username)
  |> find_user_pid(username, password, registry_name)

  @spec find_user_pid(entries::[tuple()], username::String.t(), password::String.t(), registry_name::String.t()) :: GenServer.on_start()
  defp find_user_pid([], username, password, registry_name),
    do: Account.start_link(username: username, password: password)
  |> maybe_register_user_pid(username, registry_name)

  defp find_user_pid([{_pid,user_pid}], _username, _password, _registry_name),
    do: {:ok, user_pid}

  @spec maybe_register_user_pid(a_case :: {:ok,pid()} | {:error,term()}, username :: String.t(), registry_name :: String.t()) :: GenServer.on_start()
  defp maybe_register_user_pid({:ok, user_pid}, username, registry_name),
    do: user_pid
    |> Account.get_user_token()
    |> then(&( Registry.register(registry_name, @reg_key_member_user<>":"<>elem(&1,0), user_pid) ))
    |> then(&(
        case &1 do
          {:ok, owner_pid} -> {:ok, owner_pid}
          {:error, {:already_registered, owner_pid}} -> {:ok, owner_pid}
          {:error, reason} -> {:error, reason}
        end
      ))
      |> then(&(
          case &1 do
            {:error, reason} -> {:error, reason}
            {:ok, _owner_pid} ->
              Registry.register(registry_name, @reg_key_member_user<>":"<>username, user_pid)
          end
        ))
        |> then(&(
            case &1 do
              {:ok, owner_pid} -> {:ok, owner_pid}
              {:error, {:already_registered, owner_pid}} -> {:ok, owner_pid}
              {:error, reason} -> {:error, reason}
            end
          ))
          |> then(&(
            case &1 do
              {:error, reason} -> {:error, reason}
              {:ok, _owner_pid} ->
                case Registry.lookup(registry_name, @reg_key_member_user<>":"<>username) do
                  [] -> {:error, :failed}
                  [{pid,user_pid}] ->
                    find_user_pid([{pid,user_pid}], username, "not password", registry_name)
                end
            end
            ))

  defp maybe_register_user_pid({:error, reason}, _username, _registry_name),
    do: {:error, reason}
end
