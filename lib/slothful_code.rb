require "hashids"
require "slothful_code/version"

#
# 識別コードを生成、検証する
#
# hashids を利用して長過ぎず短過ぎない、人間に読み書きしやすくユニー
# クな文字列を生成し、またその文字列が適切にこのシステムが生成したも
# のかどうかを検証できる仕組み
#
# 数字と英大文字のうち数字と紛らわしくない文字を利用して11, 12桁程度に
# 収まるだろう文字列を生成する
#
# sc = SlothfulCode.new
# sc.generate(type_id: '1') # => 'R6B7ZRDT6EY-1'
#
# see https://hashids.org/
# 
class SlothfulCode
  class Error < StandardError; end
  class WrongTypeId < Error; end
  
  HASHIDS_INCLUDE_CHARS = '1234567890ABCDEFGHJKLMNPQRSTUVWXYZ'.freeze
  TYPE_CHARS = /\A[0-9A-Z]+\z/
  
  #
  # [param] String salt
  #
  def initialize(salt = '')
    @id_processor = Hashids.new(salt, 6, HASHIDS_INCLUDE_CHARS)
  end
  attr_reader :resources

  #
  # コードを生成する
  #
  # [param] String type_id
  # [return] String
  #
  def generate(type_id:)
    t = time_array

    if type_id.to_s =~ TYPE_CHARS
      hash = [
        @id_processor.encode(t),
        type_id.to_s
      ].join('-')

      @resources = { type_id: type_id.to_s, time: t }
      hash
    else
      raise WrongTypeId
    end
  end

  #
  # 与えられたコードが hashids で decode できるかどうか
  #
  # [param] String code
  # [return] Boolean
  #
  def valid?(code)
    decode(code).size > 0
  end

  #
  # [param] String code
  # [return] Hash
  #
  # :reek:TooManyStatement
  def decode(code)
    begin
      id_str, type_id = code.split('-')
      id = @id_processor.decode(id_str)

      if id && type_id
        @resources = { type_id: type_id, time: id }
      else
        {}
      end
    rescue Hashids::InputError => e
      if e.message == 'unable to unhash'
        {}
      else
        raise
      end
    end
  end

  #
  # [return] Time
  #
  def now
    Time.now
  end
  
  #
  # 現在時刻を2つの整数の配列にして返す
  #
  # 少数部を 1 msec にまで丸めて2つの整数の配列にして返している。この
  # 部分は完全に hashids での利用のために特化している。この際、0.1 と
  # 0.001 が同じ整数 1 にならないように 0 を埋めている。
  #
  # ex)
  # [12345, 123] = time_array
  #
  # [return] Array
  #
  # :reek:UncommunicativeVariableName
  def time_array
    t = now.to_f.round(3)
    sleep 0.001

    ht, lt = t.to_s.split('.')
    [ht.to_i, (lt.to_s + '00')[0, 3].to_i]
  end

  #
  # decode 済みのコードについて確認用の日付を取得する
  #
  # [return] String
  #
  # :reek:UncommunicativeVariableName, :reek:FeatureEnvy
  def date
    time = resources[:time]
    
    if time
      t = Time.at(time.first)
      { month: t.month, mon: t.mon, day: t.day }
    else
      nil
    end
  end
end
