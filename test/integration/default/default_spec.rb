# frozen_string_literal: true
title 'Chruby should be installable and available'

describe file('/usr/local/share/chruby/chruby.sh') do
  it { should exist }
end

describe file('/usr/local/share/chruby/auto.sh') do
  it { should exist }
end
