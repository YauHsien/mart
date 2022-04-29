defmodule M.Core.Common.RepoMessage do
  @moduledoc """
  Terms to use in pub-sub channel of repositories tier.
  """

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


  @aggregate2 "{:aggregate,` _aggregate_ `}"
  @aggregate3 "{:aggregate,` _aggregate_ `, id:` _id_ `}"
  @field4 "{:field,` _field_ `, id:` _id_ `, field:` _field\_name_ `, value:` _value_ `}"
  @list1 "{:list,` _thing_ `}"
  @object2 "{:object,` _object_ `, id:` _id_ `}"
  @collection [
    @aggregate2,
    @aggregate3,
    @field4,
    @list1,
    @object2
  ]


  @doc "Message pattern `#{@aggregate2}`."
  defmacro aggregate(aggregate),
    do: quote do: {:aggregate, unquote(aggregate)}

  @doc "Message pattern `#{@aggregate3}`."
  defmacro aggregate(aggregate, id),
    do: quote do: {:aggregate, unquote(aggregate), id: unquote(id)}

  @doc "Message pattern `#{@field4}`."
  defmacro field(field, id, field_name, value),
    do: quote do: {:field, unquote(field), id: unquote(id), field: unquote(field_name), value: unquote(value)}

  @doc "Message pattern `#{@list1}` as list of things."
  defmacro list(thing),
    do: quote do: {:list, unquote(thing)}

  @doc "Message pattern `#{@object2}`."
  defmacro object(object, id),
    do: quote do: {:object, unquote(object), id: unquote(id)}



  @doc @collection
  |> Enum.map(&( "`\"topic #{&1}\"`" ))
  |> Enum.join(", ")
  |> then(&( "Topic to use in a pub-sub channel. String such as\n" <> &1 ))

  @spec topic(t()) :: topic()
  def topic(name),
    do: "topic #{inspect name}"


  @doc @collection
  |> Enum.map(&( "`\"return topic #{&1}\"`" ))
  |> Enum.join(", ")
  |> then(&( """
  Topic as return address to use in a pub-sub channel. That means to share messages channel-wisely.

  String such as #{&1}.
  """ ))

  @spec return(topic()) :: return_addr()
  def return(topic),
    do: "return " <> topic


  @doc @collection
  |> Enum.map(&( "`\"return topic #{&1} to ` _id_ `\"`" ))
  |> Enum.join(", ")
  |> then(&( """
  Topic as return address to use in a pub-sub channel. That means to share messages id-wisely.

  String such as #{&1}.
  """ ))

  @spec return(topic(), id()) :: return_addr()
  def return(topic, id),
    do: "return #{topic} to #{inspect id}"

end
