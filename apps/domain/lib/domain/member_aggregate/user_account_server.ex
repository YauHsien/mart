defmodule M.Domain.MemberAggregate.UserAccountServer do
	use GenServer

  import M.Domain.MemberAggregate.UserAccount, only: [
    username_tuple: 1,
    password_triple: 3,
    user_token_tuple: 1,
    create_password: 3
  ]
  alias M.Domain.MemberAggregate.UserAccount
  alias Plug.Crypto

  @type t :: GenServer.t


  @impl true
  def init(user_account) do
    {:ok, user_account}
  end
  def init(_), do: {:stop, :not_sup}



  @spec verify_and_set_password(t, String.t, String.t) :: {:ok, UserAccount.t} | {:error, reason :: term()}

  def verify_and_set_password(server, old_password, password),
    do: GenServer.call(server, {:verify_and_set_password, old_password, password})



  @impl true
  def handle_call(request, from, state)


  def handle_call(
    {:verify_and_set_password, old_password, password},
    _from,
    %UserAccount{name: username_tuple(username), password: password_triple(old_password,_,_)} = state) do

    UserAccount.create_password(username, password, NaiveDateTime.utc_now())
    |> then(&( %UserAccount{state | password: &1} ))
    |> then(&( {:reply, {:ok, &1}, &1} ))
  end


  def handle_call({:verify_and_set_password, old_password, _}, _from, state) do
    {:reply, {:error, :not_found}, state}
  end


  def handle_call(
    {:verify_password, password},
    _from,
    %UserAccount{name: username_tuple(username), password: password_triple(enc_password, salt, _)} = state) do

    case Crypto.verify(password, salt, enc_password) do
      term when term == {:ok, username} or term == {:error, :expired} ->
        :ok
      {:error, :invalid} ->
        :invalid
    end
    |> then(&( {:reply, &1, state} ))
  end


  def handle_call(
    {:verify, user_token_tuple(user_token)},
    _from,
    %UserAccount{
      name: username_tuple(username),
      password: password_triple(enc_password, salt, _),
      user_token: user_token_tuple(enc_user_token)} = state) do

    case Crypto.verify(user_token, salt, enc_password) do
      {:ok, ^username} -> :valid
      {:error, :expired} -> :expired
      {:error, :invalid} -> :invalid
    end
    |> then(&( {:reply, &1, state} ))
  end


  def handle_call(
    {:create, user_token_tuple(user_token)},
    _from,
    %UserAccount{name: username_tuple(username), password: password_triple(enc_password, salt, _)} = state) do

    Crypto.sign(enc_password, salt, username, max_age: @max_age)
    |> then(&( {:reply, {:ok, &1}, %UserAccount{state | user_token: user_token_tuple(&1)}} ))
  end


  def handle_call(request, _from, state),
    do: {:reply, {:bare, request}, state}

end
