require 'rails_helper'

describe Merchant, type: :model do
  describe 'relationships' do
    it { should validate_presence_of(:name) }
    # it { should have_many(:invoices) }
    # it { should have_many(:items) }
    # it { should have_many(:transactions).though(:invoices) }
  end
end
