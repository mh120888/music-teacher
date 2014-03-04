require 'spec_helper'

describe Contact do
  it { should respond_to :user }
  it { should belong_to :user }
end
