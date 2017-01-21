use Mix.Config

if Mix.env == :test do
  import_config "test.secret.exs"
end
