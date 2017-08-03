require 'rails_helper'

RSpec.describe Ba::Acceso, type: :model do
  it { should belong_to(:empresa) }
  it { should belong_to(:usuario) }
  it { should belong_to(:rol) }
  it { should validate_presence_of(:rol) }
end
