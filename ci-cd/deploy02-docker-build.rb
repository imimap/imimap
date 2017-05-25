#!/usr/bin/env ruby
# basically just executes this shell command:
# docker build . -t $DEPLOYMENT_DOCKER_ORGANISATION/$DEPLOYMENT_ENVIRONMENT:$DEPLOYMENT_TAG
# docker images | grep imimaps
# but needs files copied in in_environment

$LOAD_PATH.unshift File.join(File.dirname(__FILE__))

require 'helpers'

module CICD
  class DockerBuild
    include Helpers::General
    include Helpers::Travis

    def initialize
      @root = File.dirname(File.expand_path(File.join(__FILE__, '..')))
    end

    def start
        organisation = ENV["DEPLOYMENT_DOCKER_ORGANISATION"]
        environment = ENV["DEPLOYMENT_ENVIRONMENT"]
        tag = ENV["DEPLOYMENT_TAG"]
        puts "Building image for environment: #{environment} with tag #{tag}"
        in_environment(environment) do
          system("cd #{@root} && docker build . -t #{organisation}/#{environment}:#{tag}")
          system("docker images | grep imimaps")
        end

    end
  end
end

puts "*** start #{__FILE__}"
CICD::DockerBuild.new.start
puts "*** end #{__FILE__}"
