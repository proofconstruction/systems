{ config
, pkgs
, lib
, ...
}:

let
  api_fqdn = "ollama-api.${config.networking.domain}";

  models = [
    # general models
    { name = "llama3.1"; tokens = "8b"; }
    { name = "gemma2"; tokens = "9b"; }
    { name = "mistral"; tokens = "7b"; }

    # code generation and instruction-following
    { name = "codegemma"; tokens = "7b"; }
    { name = "llama3-groq-tool-use"; tokens = "8b"; }

    # embedding
    { name = "nomic-embed-text"; tokens = ""; }
  ];

  mkModels = cfg: if cfg.tokens != "" then cfg.name + ":" + cfg.tokens else cfg.name;

  modelsComposed = map mkModels models;
in
{
  options.custom.ollama.enable = lib.mkEnableOption "Meta's Ollama model";

  config = lib.mkIf config.custom.ollama.enable {
    services = {
      ollama = {
        enable = true;
        package = if config.custom.nvidia.enable then pkgs.ollama-cuda else pkgs.ollama;
        loadModels = modelsComposed;
        acceleration = if config.custom.nvidia.enable then "cuda" else false;
        host = "0.0.0.0";
      };

      caddy = {
        virtualHosts.${api_fqdn} = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString config.services.ollama.port}
          '';
        };
      };
    };
  };
}
