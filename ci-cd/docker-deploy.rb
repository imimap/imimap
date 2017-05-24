#!/usr/bin/env ruby

$LOAD_PATH.unshift File.join(File.dirname(__FILE__))

require 'helpers'

module CICD
  class DockerDeploy
    include Helpers::Travis
    include Helpers::General

    def initialize
      @root = File.dirname(File.expand_path(File.join(__FILE__, '..')))

      @deployment_user = "deployment"

      @hosts = {
        staging: "imi-map-staging.f4.htw-berlin.de",
        production: "imi-map-production.f4.htw-berlin.de"
      }
    end

    def start
      if environment = is_release
        puts "Building image for environment: #{environment} with tag #{tag}"
        in_environment(environment) do
          deploy_command = "scp -i id_rsa_#{environment} -o StrictHostKeyChecking=no docker-compose-#{environment}.yml #{@deployment_user}@#{@hosts[environment]}:~  && \
            ssh  -i id_rsa_#{environment} -o StrictHostKeyChecking=no #{@deployment_user}@#{@hosts[environment]} \"export TAG=#{tag}; docker-compose -f ~/docker-compose-#{environment}.yml\" up -d"
            system(deploy_command)
        end
      else
        puts "Current build environment is neither master branch nor a tagged release. Exiting."
        exit 0
      end
    end
  end
end

CICD::DockerDeploy.new.start
