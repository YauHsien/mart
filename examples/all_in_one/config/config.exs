import Config
import_config "node_resources.exs"

[
  :backoffice,
  :env,
  :finance,
  :lobby,
  :repo,
  :studio
]
|> Enum.map(&( import_config "../../../apps/#{to_string &1}/config/config.exs" ))
