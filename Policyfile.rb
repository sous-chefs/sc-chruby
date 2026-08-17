# frozen_string_literal: true

name 'sc-chruby'

run_list 'test::default'

cookbook 'sc-chruby', path: '.'
cookbook 'test', path: './test/fixtures/cookbooks/test'

named_run_list :default, 'test::default'
