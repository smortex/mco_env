# frozen_string_literal: true

require 'English'

module McoEnv
  module Utils
    def self.all_environments
      directories = Dir[File.join(ENV['HOME'], '.mcollective-*')]

      directories.map { |dir| dir.sub(%r{^.*/\.mcollective-(.*)$}, '\1') }
    end

    def self.active_environment
      dir = Dir.getwd.split('/')

      loop do
        return nil if dir.empty?

        break if File.exist?(File.join(dir, '.mco-environment'))

        dir.pop
      end

      File.readlines(File.join(dir, '.mco-environment'))[0].chomp
    end
  end

  class Wrapper
    def initialize(environment = nil)
      @environment = environment || McoEnv::Utils.active_environment
    end

    def run(args)
      command = []
      command << mco_path
      command += args
      command += ['--config', config_path] if config_path?
      system(*command)
      $CHILD_STATUS.exitstatus
    end

    private

    def mco_path
      '/usr/local/bin/mco'
    end

    def config_path
      File.join(ENV['HOME'], ".mcollective-#{@environment}", 'client.cfg')
    end

    def config_path?
      @environment
    end
  end

  class Lister
    def initialize
      @environments = []
    end

    def add(environment, active)
      @environments << { environment: environment, active: active }
    end

    def print
      @environments
        .sort_by { |environment| environment[:environment] }
        .map     { |environment| environment[:active] = environment[:active] ? '*' : ' '; environment }
        .each    { |environment| puts format(' %<active>c %<environment>s', environment) }
    end
  end
end
