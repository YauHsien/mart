import YDToolkit
alias M.Core.DataCache
alias DataCache.RequestTopic
alias DataCache.ReturnTopic
alias DataCache.TopicProtocol


defprotocol TopicProtocol do
  @spec to_binary(RequestTopic | ReturnTopic) :: binary()
  def to_binary(term)

  def create(term)
  def create(term, opts)
end



value_object RequestTopic do

  use TypedStruct
  typedstruct do
    field :on_domain, :atom, enforce: true
  end

  defimpl TopicProtocol do
    @range [:branding, :portfolio, :course, :listing, :sales]

    @spec to_binary(RequestTopic.t()) :: binary()
    def to_binary(%RequestTopic{on_domain: domain}),
      do: "topic on #{inspect domain}"

    @spec create(atom()) :: RequestTopic.t()
    def create(domain) do
      if Enum.member?(@range, domain),
        do: %RequestTopic{on_domain: domain},
        else: raise "bad topic #{inspect domain}"
    end

    def create(_term, _opts), do: raise "not implemented"
  end
end



value_object ReturnTopic do

  use TypedStruct
  typedstruct do
    field :on_domain, :string, enfoce: true
    field :alt, term(), enforce: true
  end

  defimpl TopicProtocol do
    @spec to_binary(ReturnTopic.t()) :: binary()
    def to_binary(%ReturnTopic{on_domain: domain, alt: alt}),
      do: "return topic on #{inspect domain}, alt #{inspect alt}"

    @spec create(ReturnTopic, term()) :: ReturnTopic.t()
    def create(%ReturnTopic{on_domain: domain}, alt \\ NaiveDateTime.utc_now()),
      do: %ReturnTopic{on_domain: domain, alt: alt}
  end
end




