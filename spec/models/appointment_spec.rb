require 'spec_helper'

describe Appointment do
  it { should belong_to(:user) }
  it { should validate_presence_of(:date) }
end
