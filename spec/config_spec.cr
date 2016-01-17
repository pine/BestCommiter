require "tempfile"

require "./spec_helper"
require "../src/best_commiter/config"

ROOT_YAML_DATA = %{
  github:
    access_token: access_token

  users:
    - username

  repos:
    - private_repo_name
}

module BestCommiter::Config
  describe Root do
    it "from_yaml" do
      root = Root.from_yaml(ROOT_YAML_DATA)
      root.github.access_token.should eq("access_token")
      root.users[0].should eq("username")
      root.repos[0].should eq("private_repo_name")
    end
  end

  describe GitHub do
    it "from_yaml" do
      github = GitHub.from_yaml("access_token: access_token")
      github.access_token.should eq("access_token")
    end
  end

  describe Loader do
    it "from_yaml_file" do
      tempfile = Tempfile.open("config.yml") do |file|
        file.print(ROOT_YAML_DATA)
      end

      root = Loader.from_yaml_file(tempfile.path)
      root.github.access_token.should eq("access_token")
      root.users[0].should eq("username")
      root.repos[0].should eq("private_repo_name")

      tempfile.delete
    end
  end
end
