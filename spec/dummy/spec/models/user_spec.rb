require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one :subscription }
  it { should have_one :payment_method }
  it { should have_one :gateway_customer }
end
