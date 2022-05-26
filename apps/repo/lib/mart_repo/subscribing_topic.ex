defmodule M.Repo.SubscribingTopic do

  def for_member, do: Application.fetch_env!(M.Repo.app(), :subscribing_topics)[:for_member]
  def for_branding, do: Application.fetch_env!(M.Repo.app(), :subscribing_topics)[:for_branding]
  def for_portfolio, do: Application.fetch_env!(M.Repo.app(), :subscribing_topics)[:for_portfolio]
  def for_course, do: Application.fetch_env!(M.Repo.app(), :subscribing_topics)[:for_course]
  def for_listing, do: Application.fetch_env!(M.Repo.app(), :subscribing_topics)[:for_listing]
  def for_sales, do: Application.fetch_env!(M.Repo.app(), :subscribing_topics)[:for_sales]
end
