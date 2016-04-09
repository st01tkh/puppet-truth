require 'spec_helper'
describe 'truth' do

  context 'with defaults for all parameters' do
    it { should contain_class('truth') }
  end
end
