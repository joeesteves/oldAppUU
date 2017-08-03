require "set"

shared_examples "standard abm" do
  let(:nuevo) { described_class.new nombre: 'appuu' }
  it { expect(nuevo).to respond_to(:nombre) }
  [:nombre].each { |attr| it { should validate_presence_of(attr)} }
  [:nombre].each { |attr| it { should validate_uniqueness_of(attr)} }
end

shared_examples "standard coded abm" do
 let(:nuevo) { described_class.new }
 it_behaves_like "standard abm"
 it { expect(nuevo).to respond_to(:codigo) }
 it { should validate_presence_of(:codigo)}
 it { should validate_uniqueness_of(:codigo)}
 it { expect(nuevo.estado).to eq(1) }
end
