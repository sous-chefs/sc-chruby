require 'spec_helper'

describe 'chruby_install' do
  step_into :chruby_install
  platform 'ubuntu'

  context 'install chruby' do
    recipe do
      chruby_install ''
    end

    it { create_file('chruby.tar.gz.asc') }
  end
end
