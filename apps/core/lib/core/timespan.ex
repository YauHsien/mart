defmodule M.Core.Timespan do
  @spec to_datetime([{:after, {integer, :day | :second}}, ...]) :: DateTime.t()
  def to_datetime(after: {n, :day}) do
    s =
      n * 24 * 60 * 60
    Timex.Timezone.local.full_name
    |> DateTime.now!
    |> DateTime.add(s, :second)
  end
  def to_datetime(after: {n, :second}) do
    Timex.Timezone.local.full_name
    |> DateTime.now!
    |> DateTime.add(n, :second)
  end
end
