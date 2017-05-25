#!/usr/bin/env ruby

module CICD

  module Helpers

    module Travis
      # determines, whether the current build is a tagged release or not
      def is_release
        # hack to always deploy
        return ENV["DEPLOYMENT_ENVIRONMENT"]
        if ENV["TRAVIS_TAG"] && ENV["TRAVIS_BRANCH"] == "master"
          :staging
        elsif ENV["TRAVIS_TAG"] && (ENV["TRAVIS_BRANCH"] == ENV["TRAVIS_TAG"])
          :production
        else
          # not on branch master + no tagged release
          # => no need to build
          false
        end
      end



      def tag
        return ENV["DEPLOYMENT_TAG"]
        if !ENV["TRAVIS_TAG"].empty? && !ENV["TRAVIS_COMMIT"].empty?
          ENV["TRAVIS_TAG"]
        elsif ENV["TRAVIS_TAG"].empty? && !ENV["TRAVIS_COMMIT"].empty?
          ENV["TRAVIS_COMMIT"]
        else
          puts "This does not feel like travis. Exiting."
          exit 1
        end
      end
    end

    module General

      # copy files for the environment to root, execute block, clean up when done
      def in_environment(environment, *extra_files)
        environment_files = [
          "docker-compose-#{environment}.yml",
         'docker-entrypoint.sh',
         'Dockerfile'
        ].concat(extra_files)

        environment_files.each do |file|
          `cp #{path('.docker', environment.to_s, file)} #{File.dirname(File.expand_path(File.join(__FILE__, '..')))}`
        end

        begin
          yield
        rescue
        ensure
          environment_files.each do |file|
            `rm #{path(file)}`
          end
        end

      end

      def path(root = File.dirname(File.expand_path(File.join(__FILE__, '..'))), *path)
        File.join(root, *path)
      end


      def system_call(command, suppress: false)
        begin
          PTY.spawn(command) do |stdout, stdin, pid|
            stdout.each do |line|
              puts line unless suppress
            end
          end
        rescue Exception
        end
      end

      def confirm(question:, color:, exit_on_no: true, exit_code: 1)
        if ask(question, color, limited_to: ["yes", "no"]) == "yes"
          yield if block_given?
        else
          if exit_on_no
            say "Exiting.", :green
            exit exit_code
          end
        end
      end
    end
  end
end
