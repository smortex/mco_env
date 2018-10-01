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
        raise 'no mco environment configured here (or in any of the parent directories): .mco-environment' unless @environment
    end

    def run(args)
      action = args.shift
      system('/usr/local/bin/mco', action, '--config', config_path, *args)
      $?.exitstatus
    end

    private

    def config_path
      File.join(ENV['HOME'], ".mcollective-#{@environment}", 'client.cfg')
    end
  end
end
