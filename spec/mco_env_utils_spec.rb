# frozen_string_literal: true

RSpec.describe McoEnv::Utils do
  context '::active_environment' do
    it 'returns nil when outside of an environment' do
      Dir.chdir('/')
      expect(McoEnv::Utils.active_environment).to be_nil
    end

    it 'returns the environment name when inside an environment' do
      Dir.chdir(File.expand_path('fixtures', __dir__))
      expect(McoEnv::Utils.active_environment).to eq('test123')
    end
  end
end
