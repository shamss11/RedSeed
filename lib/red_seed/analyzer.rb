# frozen_string_literal: true

module RedSeed
  # Analyzer processes food asset records to calculate neighborhood scores
  class Analyzer
    SCORING_RULES = {
      "Community Garden" => 2,
      "Free Meal Program" => 5
    }.freeze

    def initialize(data)
      @data = data
    end

    def analyze_neighborhood(target_name)
      target_name = target_name.to_s.downcase.strip

      # The API uses different keys for neighborhoods across datasets
      assets = @data.select do |item|
        neighborhood = item["local_areas"] || item["local_area"] ||
                       item["neighborhood_name"] || item["geo_local_area"]
        neighborhood&.downcase&.include?(target_name)
      end

      {
        neighborhood: target_name.capitalize,
        score: calculate_score(assets),
        assets_count: assets.count,
        assets: assets
      }
    end

    def neighborhoods
      @data.map do |item|
        item["local_areas"] || item["local_area"] ||
          item["neighborhood_name"] || item["geo_local_area"]
      end.compact.uniq.sort
    end

    private

    def calculate_score(assets)
      assets.reduce(0) do |sum, asset|
        sum + (SCORING_RULES[asset["asset_type"]] || 0)
      end
    end
  end
end
