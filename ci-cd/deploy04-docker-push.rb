#!/usr/bin/env ruby

$LOAD_PATH.unshift File.join(File.dirname(__FILE__))

require 'helpers'

module CICD
  class DockerPush
    include Helpers::Travis

    def initialize
      @root = File.dirname(File.expand_path(File.join(__FILE__, '..')))
    end

    def start
        push_command = "docker login -u #{ENV["DOCKER_USERNAME"]} -p #{ENV["DOCKER_PASSWORD"]} && \
        docker push #{ENV["DEPLOYMENT_DOCKER_ORGANISATION"]}/#{ENV["DEPLOYMENT_ENVIRONMENT"]}:#{ENV["DEPLOYMENT_TAG"]}"
        system(push_command)
    end
  end
end

puts "*** start #{__FILE__}"
CICD::DockerPush.new.start
puts "*** end #{__FILE__}"
