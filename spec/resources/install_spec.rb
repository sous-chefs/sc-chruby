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

  context 'on Amazon Linux' do
    platform 'amazon', '2023'

    recipe do
      chruby_install ''
    end

    it { remove_package('gnupg2-minimal') }
    it { install_package('gnupg2-full') }
  end
end
