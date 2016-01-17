require "yaml"

module BestCommiter
  module Config
    module Loader
      def self.from_yaml_file(file)
        Root.from_yaml File.read(file)
      end
    end

    class Root
      YAML.mapping({
        github: GitHub,
        users:  Array(String),
        repos:  Array(String),
      })
    end

    class GitHub
      YAML.mapping({
        access_token: String,
      })
    end
  end
end
