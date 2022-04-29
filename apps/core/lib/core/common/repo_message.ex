defmodule M.Core.Common.RepoMessage do

  @type id() :: integer() | String.t()
  @type table_name() :: atom()
  @type t() ::
  {:aggregate, table_name()}
  | {:aggregate, table_name(), id: id()}
  | {:field, table_name(), id: id(), field: String.t(), value: term()}
  | {:list, table_name(),}
  | {:object, table_name(), id: id()}
  @type topic() :: String.t()
  @type return_addr() :: String.t()


  @aggregate2 "{:aggregate, aggregate}"
  @aggregate3 "{:aggregate, aggregate, id: id}"
  @field4 "{:field, field, id: id, field: field_name, value: value}"
  @list1 "{:list, thing}"
  @object2 "{:object, object, id: id}"
  @collection [
    @aggregate2,
    @aggregate3,
    @field4,
    @list1,
    @object2
  ]


  @doc "Message `#{@aggregate2}``."
  defmacro aggregate(aggregate),
    do: quote do: {:aggregate, unquote(aggregate)}

  @doc "Message `#{@aggregate3}`."
  defmacro aggregate(aggregate, id),
    do: quote do: {:aggregate, unquote(aggregate), id: unquote(id)}

  @doc "Message `#{@field4}`."
  defmacro field(field, id, field_name, value),
    do: quote do: {:field, unquote(field), id: unquote(id), field: unquote(field_name), value: unquote(value)}

  @doc "Message `#{@list1}` as list of things."
  defmacro list(thing),
    do: quote do: {:list, unquote(thing)}

  @doc "Message `#{@object2}`."
  defmacro object(object, id),
    do: quote do: {:object, unquote(object), id: unquote(id)}



  @doc @collection
  |> Enum.map(&( "`\"topic #{&1}\"`" ))
  |> Enum.join(", ")
  |> then(&( "String such as\n" <> &1 ))

  @spec topic(t()) :: topic()
  def topic(name),
    do: "topic #{inspect name}"


  @doc @collection
  |> Enum.map(&( "`\"return topic #{&1}\"`" ))
  |> Enum.join(", ")
  |> then(&( "String such as\n" <> &1 ))

  @spec return(topic()) :: return_addr()
  def return(topic),
    do: "return " <> topic


  @doc @collection
  |> Enum.map(&( "`\"return topic #{&1}\" to _id_`" ))
  |> Enum.join(", ")
  |> then(&( "String such as\n" <> &1 ))

  @spec return(topic(), id()) :: return_addr()
  def return(topic, id),
    do: "return #{topic} to #{inspect id}"

end
