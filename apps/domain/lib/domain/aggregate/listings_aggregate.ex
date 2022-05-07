defmodule M.Domain.Aggregate.ListingsAggregate do

  @type id :: integer | String.t

  defmodule Course do
	  use TypedStruct
    typedstruct do
      field :eid, id(), default: nil
      field :id, id(), default: nil
      field :name, String.t(), enforce: true
      field :plan, String.t(), enforce: true
      field :lessons, String.t(), enforce: true
      field :listing, Listing.t()
    end
  end

  defmodule Listing do
	  use TypedStruct
    typedstruct do
      field :id, id(), default: nil
      field :sku, String.t(), enforce: true
      field :use_count, integer(), default: 0
      field :shop, Shop.t()
    end
  end

  defmodule Shop do
    use TypedStruct
    typedstruct do
      field :id, id(), default: nil
      field :name, String.t(), enforce: true
    end
  end



  @spec externalize(Course.t()) :: Course.t()
  | externalize(Listing.t()) :: Listing.t()
  | externalize(Shop.t()) :: Shop.t()

  def externalize(target) do
    Map.keys(target)
    |> field_value_pairs_excepting(
      id: fn _value -> :intrinsic end,
    listing: fn value -> externalize(value) end,
    shop: fn value -> externalize(value) end
    )
    |> List.foldl(mimic(target), fn {field, value}, map -> Map.put(map, field, value) end)
  end

  defp mimic(%Course{}), do: %Course{}
  defp mimic(%Listing{}), do: %Listing{}
  defp mimic(%Shop{}), do: %Shop{}



  defmodule Macro do
    defmacro init_data(data), do: quote do: {:data, :init, unquote(data)}

    defmacro data_course(id, opts), do: quote do: {:data, :course, unquote(id), unquote(opts)}

    defmacro data_listing(course_id, id, opts),
      do: quote do: {:data, :course, unquote(course_id), :listing, unquote(id), unquote(opts)}

    defmacro data_shop(course_id, listing_id, id, opts),
      do: quote do: {:data,
                     :course, unquote(course_id),
                     :listing, unquote(listing_id),
                     :shop, unquote(id),
                     unquote(opts)}

    defmacro query_all, do: quote do: {:query, :root}

    defmacro query_course(eid, field_or_fields),
      do: quote do: {:query, :course, unquote(eid), field_or_fields}

    defmacro query_listing(eid, field_or_fields),
      do: quote do: {:query, :listing, unquote(eid), field_or_fields}

    defmacro query_shop(eid, field_or_fields),
      do: quote do: {:query, :shop, unquote(eid), field_or_fields)
  end



  defmacro __using__(opts) do
    quote do
      use GenServer
      import M.Domain.Aggregate.ListingsAggregate
      alias  M.Domain.Aggregate.ListingsAggregate.Course
      alias  M.Domain.Aggregate.ListingsAggregate.Listing
      import M.Domain.Aggregate.ListingsAggregate.Macro
      alias  M.Domain.Aggregate.ListingsAggregate.Shop

      def start_link(args),
        do: GenServer.start_link(
              __MODULE__,
              args,
              id: Keyword.get(args, :id, Keyword.get(opts, :id)), opts)

      @impl true
      def init(args), do: {:ok, %{
                              opts: args,
                              eid: Keyword.get(args, :root_id) |> eid(),
                              root_id: Keyword.get(args, :root_id),
                              data: nil
                           }}

      defp eid(id), do: UUID.uuid5(:oid, id, :hex)

      @impl true

      @spec handle_call(
        {:data, :init, Course.t()}
        | {:data, :course, id(), Keyword.t()}
        | {:data, :course, id(), :listing, id(), Keyword.t()}
        | {:data, :course, id(), :listing, id(), :shop, id(), Keyword.t()},
        from(),
        state :: term()
      ) :: {:noreply, new_state :: term()}

      def handle_call(request, from, state)

      def handle_call(
        init_data(course) = update, _from, %{root_id: id, eid: eid} = state
      ) when course.id == id,
        do: {:noreply, Map.put(state, :data, %Course{course|eid: eid})}

      def handle_call(
        data_course(id, _opts) = update,
        _from,
        %{root_id: id, data: course} = state
      ),
        do: {:noreply, Map.put(state, :data, update_data(course, update))}

      def handle_call(
        data_listing(course_id, _id, _opts) = update,
        _from,
        %{root_id: course_id, data: course} = state
      ),
        do: {:noreply, Map.put(state, :data, update_data(course, update))}

      def handle_call(
        data_shop(course_id, _listing_id, _id, _opts) = update,
        _from,
        %{root_id: course_id, data: course} = state
      ),
        do: {:noreply, Map.put(state, :data, update_data(course, update))}

      def handle_call(query_all(), _from, %{data: course} = state),
        do: {:reply, externalize(course), state}

      def handle_call(query, _from, %{data: course} = state)
      when query_course(eid, field_or_fields) = query
      or query_listing(eid, field_or_fields) = query
      or query_shop(eid, field_or_fields) = query,
        do: {:reply, query_result(course, query), state}

      def handle_call(_request, _from, state),
        do: {:reply, {:error, :badreq}, state}

      @spec update_data(
        Course.t(),
        {:data, :course, id(), Keyword.t()}
        | {:data, :course, id(), :listing, id(), Keyword.t()}
        | {:data, :course, id(), :listing, id(), :shop, id(), Keyword.t()}
      ) :: Course.t()
      | update_data(
        Listing.t() | nil,
        {:data, :listing, id(), Keyword.t()}
        | {:data, :listing, id(), :shop, id(), Keyword.t()}
      ) :: Listing.t()
      | update_data(Shop.t() | nil, {:data, :shop, id(), Keyword.t()}) :: Shop.t()

      defp update_data(course, data_course(id, opts)) when course.id == id,
        do: %Course{
              course |
              name: Keyword.get(opts, :name, course.name),
              plan: Keyword.get(opts, :plan, course.plan),
              lessons: Keyword.get(opts, :lessons, course.lessons)
        }

      defp update_data(course, data_listing(id, listing_id, opts)) when course.id == id,
        do: %Couse{
              courrse |
              listing: update_data(course.listing, data_listing(listing_id, opts))
        }

      defp update_data(course, data_shop(id, listing_id, shop_id, opts)) when course.id == id,
        do: %Course{
              course |
              listing: update_data(course.listing, data_listing(listing_id, shop_id, opts))
        }

      defp update_data(nil, data_listing(id, opts)),
        do: %Listing{
              eid: eid(id),
              id: id,
              sku: Keyword.get(opts, :sku, listing.sku),
              use_count: Keyword.get(opts, :use_connt, listing.use_count)
        }

      defp update_data(listing, data_listing(id, opts)) when listing.id == id,
        do: %Listing{
              listing |
              sku: Keyword.get(opts, :sku, listing.sku),
              use_count: Keyword.get(opts, :use_connt, listing.use_count)
        }

      defp update_data(listing, data_listing(id, shop_id, opts)) when listing.id == id,
        do: %Listing{
              listing |
              shop: update_data(listing.shop, data_shop(shop_id, opts))
        }

      defp update_data(nil, data_shop(id, opts)),
        do: %Shop{
              eid: eid(id),
              id: id,
              name: Keyword.get(opts, :name, shop.name)
        }

      defp update_data(shop, data_shop(id, opts)) when shop.id == id,
        do: %Shop {
              shop |
              name: Keyword.get(opts, :name, shop.name)
        }

      @spec query_result(
        Course.t() | Listing.t() | Shop.t(),
        {:query, :course, id(), atom() | [atom()]}
        | {:query, :listing, id(), atom() | [atom()]}
        | {:query, :shop, id(), atom() | [atom()]}
      ) :: term() | [term()]

      defp query_result(target, query)
      when (qeury_course(_eid, field) = query and is_atom(field))
      or (query_listing(_eid, field) = query and is_atom(field))
      or (query_shop(_eid, field) = query and is_atom(field)),
        do: _query_result(target, query)

      defp query_result(target, query_course(eid, fields) = query)
      when is_list(fields),
        do: fields
        |> Enum.map(&( _query_result(target, query_course(eid, &1)) ))

      defp query_result(target, query_listing(eid, fields) = query)
      when is_list(fields),
        do: fields
        |> Enum.map(&( _query_result(target, query_listing(eid, &1)) ))

      defp query_shop(target, query_shop(eid, fields) = query)
      when is_list(fields),
        do: fields
        |> Enum.map(&( _query_result(target, query_shop(eid, &1)) ))

      @spec _query_result(
        Course.t() | Listing.t() | Shop.t() | nil,
        {:query, :course, id(), atom()}
        | {:query, :listing, id(), atom()}
        | {:query, :shop, id(), atom()}
      ) :: term() | nil

      defp _query_result(nil, query)
      when (qeury_course(_eid, _field) = query)
      or (query_listing(_eid, _field) = query)
      or (query_shop(_eid, _field) = query),
        do: nil

      defp _query_result(course, query_course(eid, field))
      when course.eid == eid,
        do: Map.get(course, field)

      defp _query_result(course, query)
      when query_listing(_eid, _field) = query
      or query_shop(_eid, _field) = query,
        do: _query_result(course.listing, query)

      defp _query_result(listing, query_listing(eid, field))
      when listing.eid == eid,
        do: Map.get(listing, field)

      defp _query_result(listing, query_shop(_eid, _field) = query),
        do: _query_result(listing.shop, query)

      defp _query_result(shop, query_shp(eid, field))
      when shop.eid == eid,
        do: Map.get(shop, field)
    end
  end


end
