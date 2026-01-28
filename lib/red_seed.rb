require "faraday"
require "json"
require "thor"
require "terminal-table"

require_relative "red_seed/data_fetcher"
require_relative "red_seed/analyzer"
require_relative "red_seed/cli"

module RedSeed
  class Error < StandardError; end
end
