describe Multy do
  let(:obj) { Class.new { include Multy }.new }

  describe 'define multi methods' do
    before do
      obj.define_multi_method('print', Fixnum) do |_a|
        'fixnum'
      end

      obj.define_multi_method('print', String) do |_a|
        'string'
      end
    end

    it { expect(obj.mcall('print', 1)).to eq 'fixnum' }
    it { expect(obj.mcall('print', 'a')).to eq 'string' }
    it { expect(obj.print(1)).to eq 'fixnum' }
    it { expect(obj.print('s')).to eq 'string' }
  end
end
