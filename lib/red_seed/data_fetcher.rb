# frozen_string_literal: true

module RedSeed
  # DataFetcher handles fetching food asset data from Vancouver Open Data API
  class DataFetcher
    BASE_URL = "https://opendata.vancouver.ca/api/explore/v2.1/catalog/datasets".freeze

    DATASETS = {
      meals: "free-and-low-cost-food-programs",
      gardens: "community-gardens-and-food-trees"
    }.freeze

    CACHE_FILE = ".red_seed_cache.json".freeze
    CACHE_EXPIRY = 86_400 # 24 hours

    def self.fetch_data(dataset_type)
      return load_from_cache(dataset_type) if cache_fresh?(dataset_type)

      fetch_and_cache(dataset_type)
    end

    def self.fetch_all
      meals = fetch_data(:meals).map { |r| r.merge("asset_type" => "Free Meal Program") }
      gardens = fetch_data(:gardens).map { |r| r.merge("asset_type" => "Community Garden") }
      meals + gardens
    end

    def self.cache_fresh?(type)
      return false unless File.exist?(CACHE_FILE)

      cache = JSON.parse(File.read(CACHE_FILE))
      return false unless cache[type.to_s]

      Time.now.to_i - cache[type.to_s]["timestamp"] < CACHE_EXPIRY
    rescue StandardError
      false
    end

    def self.load_from_cache(type)
      cache = JSON.parse(File.read(CACHE_FILE))
      cache[type.to_s]["data"]
    end

    def self.fetch_and_cache(type)
      dataset_id = DATASETS[type]
      response = Faraday.get("#{BASE_URL}/#{dataset_id}/records?limit=100")

      fail "Failed to fetch #{type}: #{response.status}" unless response.success?

      data = JSON.parse(response.body)["results"]
      update_cache(type, data)
      data
    end

    def self.update_cache(type, data)
      cache = File.exist?(CACHE_FILE) ? JSON.parse(File.read(CACHE_FILE)) : {}
      cache[type.to_s] = { "timestamp" => Time.now.to_i, "data" => data }
      File.write(CACHE_FILE, JSON.generate(cache))
    end

    private_class_method :cache_fresh?, :load_from_cache, :fetch_and_cache, :update_cache
  end
end
