require "test_helper"

describe SlothfulCode do
  before {
    @sc = SlothfulCode.new
  }
  attr_reader :sc
  
  describe '#generate' do
    describe 'wrong arguments' do
      it {
        assert_raises ArgumentError do
          sc.generate(1)
        end
      }
    end

    describe 'collect arguments' do
      before { @code = sc.generate(type_id: '1') }
      it {
        assert { @code.class == String }
      }
      it {
        assert { sc.resources.class == Hash }
      }
      it {
        assert { sc.resources.has_key? :time }
      }
      it {
        assert { sc.resources[:type_id] == '1' }
      }
    end

    describe 'wrong type' do
      it {
        assert_raises SlothfulCode::WrongTypeId do
          sc.generate(type_id: {})
        end
      }
    end

    describe 'size' do
      describe 'time is 2050-10-10 00:00:00' do
        it {
          sc.stub :now, Time.new(2050, 10, 10) do
            assert { sc.generate(type_id: '1').size == 12 }
          end
        }
      end
      describe 'time is 2021-02-07 00:00:00' do
        it {
          sc.stub :now, Time.new(2021,2,7) do
            assert { sc.generate(type_id: '1') }
          end
        }
      end
    end
  end

  describe '#valid?' do
    describe 'wrong string' do
      it {
        assert { sc.valid?('abc') == false }
      }
    end

    describe 'collect string' do
      it {
        assert { sc.valid?(sc.generate(type_id: '1')) }
      }
    end
  end

  describe '#decode' do
    describe 'wrong string' do
      it {
        assert { sc.decode('abc') == {} }
      }
    end

    describe 'collect string' do
      it {
        p sc.generate(type_id: 1)
        assert { sc.decode(sc.generate(type_id: 1)).class == Hash }
      }
    end
  end

  describe '#date' do
    it {
      sc.stub :now, Time.new(2021,2,7) do
        sc.generate(type_id: 1)

        assert { sc.date == { month: 2, mon: 2, day: 7 } }
      end
    }
  end
end
