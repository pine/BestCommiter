require "yaml"

module BestCommiter
  module Config
    class GitHub
      YAML.mapping({
        access_token: String,
      })
    end

    class Config
      YAML.mapping({
        github: GitHub,
        users:  Array(String),
        repos:  Array(String),
      })

      def self.from_yaml_file(file)
        from_yaml File.read(file)
      end
    end
  end
end
