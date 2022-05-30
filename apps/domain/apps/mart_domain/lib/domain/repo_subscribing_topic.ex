defmodule M.Domain.RepoSubscribingTopic do

  def for_member, do: "#{inspect Application.fetch_env!(M.Domain.app(), :repo_subscribing_topics)[:for_member]}"
  def for_branding, do: "#{inspect Application.fetch_env!(M.Domain.app(), :repo_subscribing_topics)[:for_branding]}"
  def for_portfolio, do: "#{inspect Application.fetch_env!(M.Domain.app(), :repo_subscribing_topics)[:for_portfolio]}"
  def for_course, do: "#{inspect Application.fetch_env!(M.Domain.app(), :repo_subscribing_topics)[:for_course]}"
  def for_listing, do: "#{inspect Application.fetch_env!(M.Domain.app(), :repo_subscribing_topics)[:for_listing]}"
  def for_sales, do: "#{inspect Application.fetch_env!(M.Domain.app(), :repo_subscribing_topics)[:for_sales]}"
end
