import Config

config :mart_domain,
  repo_write_pub_sub: RepoWritePubSub,
  repo_for_tutor_model: Domain.TutorModel.Repository

config :ex_domain_toolkit,
  registry: Domain.Registry
