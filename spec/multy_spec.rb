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

      obj.define_multi_method('print', Proc) do |arg|
        arg.call('proc')
      end
      obj.define_multi_method('print', String, String) do |s1, s2|
        s1 + s2
      end
    end

    it { expect(obj.print(1)).to eq 'fixnum' }
    it { expect(obj.print('s')).to eq 'string' }
    it { expect(obj.print(-> (a) {  "print_#{a}" })).to eq 'print_proc' }
    it { expect(obj.print('hoge', 'fuga')).to eq 'hogefuga' }
  end
end
