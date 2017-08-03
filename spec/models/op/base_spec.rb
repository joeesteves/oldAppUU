require 'rails_helper'

RSpec.describe Op::Base, type: :model do
  it 'no guarda sin empresa' do
    validate_presence_of(:empresa_id)
  end

  it { should belong_to(:asiento) }
end
