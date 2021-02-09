# SlothfulCode

ある程度人間にとって扱いやすい長さ、複雑さで、類推しにくく、重複しないコードを生成、検証する

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slothful-code-generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slothful-code-generator

## Usage

```ruby
require 'slothful_code'
```

### ganerate

```ruby
sc = SlothfulCode.new(<salt>)
sc.generate(type_id: '1') # => '989JV7WDCN6Q-1'
```

### decode

```ruby
sc = SlothfulCode.new(<salt>)
sc.decode(<code>) # => {:type_id=>'1', :time=>[1612769809, 113]}
```

### valid?

```ruby
sc = SlothfulCode.new(<salt>)
sc.valid?(<code>) # => true / false
```
