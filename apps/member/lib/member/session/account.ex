defmodule M.Member.Session.Account do
  use GenServer
  alias M.Member.Repo
  alias M.Member.User.Account

  @spec start_link(iusername: username :: String.t(), password: password :: String.t()) :: GenServer.on_start()
  def start_link(username: username, password: password),
    do: Repo.signin(username, password)
    |> then(&(GenServer.start_link(M.Member.Session.Account, &1)))

  @spec get_user_token(account_pid :: pid()) :: {user_token :: String.t(), expired_when :: NaiveDateTime.t()}
  def get_user_token(account_pid),
    do: GenServer.call(account_pid, :user_token)

  @spec get_username(account_pid :: pid()) :: (username :: String.t())
  def get_username(account_pid),
    do: GenServer.call(account_pid, :username)

  @impl true
  @spec init({:ok,Account.t()}) :: {:ok,state::map()} | {:stop,{:error,:failed}}
  def init({:ok,account}) do
    {:ok, %{
        account: account
     }}
  end

  def init(error) do
    {:stop, error}
  end

  @impl true
  def handle_call(:user_token, _from, %{account: %Account{user_token: user_token, expired_when: expired_when}}=state),
    do: {:reply, {user_token,expired_when}, state}

  def handle_call(:username, _from, %{account: %Account{username: username}}=state),
    do: {:reply, username, state}

  def handle_call(_message, _from, state),
    do: {:noreply, state}
end
