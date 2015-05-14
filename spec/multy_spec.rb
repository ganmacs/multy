describe Multy do
  let(:obj) { Class.new { include Multy }.new }

  describe 'define multi methods' do
    before do
      obj.build_multi_method('print', Fixnum) do |a|
        'fixnum'
      end

      obj.build_multi_method('print', String) do |a|
        'string'
      end
    end

    it { expect(obj.mcall('print', 1)).to eq 'fixnum' }
    it { expect(obj.mcall('print', 'a')).to eq 'string' }
  end
end
