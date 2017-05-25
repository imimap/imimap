#!/usr/bin/env ruby

$LOAD_PATH.unshift File.join(File.dirname(__FILE__))

require 'helpers'

module CICD
  class DockerDeploy
    include Helpers::Travis
    include Helpers::General

    def initialize
      @root = File.dirname(File.expand_path(File.join(__FILE__, '..')))

      @deployment_user = "deployer"

      @hosts = {
        staging: "imi-map-staging.f4.htw-berlin.de",
        production: "imi-map-production.f4.htw-berlin.de"
      }
    end

    def start
        puts "Deploying image for environment: #{environment} with tag #{tag}"
        in_environment(environment) do
          deploy_command = "scp -i id_rsa_#{environment} -o StrictHostKeyChecking=no docker-compose-#{environment}.yml #{@deployment_user}@#{@hosts[environment]}:~  && \
            ssh  -i id_rsa_#{environment} -o StrictHostKeyChecking=no #{@deployment_user}@#{@hosts[environment]} \"export TAG=#{tag}; docker-compose -f ~/docker-compose-#{environment}.yml\" up -d"
            copy_docker_compose = "scp -i id_rsa_#{environment} -o StrictHostKeyChecking=no docker-compose-#{environment}.yml #{@deployment_user}@#{@hosts[environment]}:~  "
            puts "copy_docker_compose #{copy_docker_compose}"
            system(copy_docker_compose)
            deploy_command = "ssh  -i id_rsa_#{environment} -o StrictHostKeyChecking=no #{@deployment_user}@#{@hosts[environment]} \"export TAG=#{tag}; docker-compose -f ~/docker-compose-#{environment}.yml\" up -d"
            puts "deploy_command #{deploy_command}"
            system(deploy_command)
        end
    end
  end
end

puts "*** start #{__FILE__}"
CICD::DockerDeploy.new.start
puts "*** end #{__FILE__}"
