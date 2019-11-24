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
      action = args.shift

      command = []
      command << mco_path
      command << action unless action.nil?
      command += ['--config', config_path] if has_config?
      command += args
      system(*command)
      $?.exitstatus
    end

    private

    def mco_path
      '/usr/local/bin/mco'
    end

    def config_path
      File.join(ENV['HOME'], ".mcollective-#{@environment}", 'client.cfg')
    end

    def has_config?
      @environment
    end
  end
end
