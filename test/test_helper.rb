$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "slothful_code"

require "minitest/autorun"
require "minitest/power_assert"
require "minitest/reporters"
require "minitest/skip_dsl"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
