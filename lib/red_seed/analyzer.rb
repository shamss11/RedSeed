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
        raw_name = item["local_areas"] || item["local_area"] ||
                   item["neighborhood_name"] || item["geo_local_area"]
        neighborhood = raw_name&.tr("-", " ")
        neighborhood&.downcase&.include?(target_name.tr("-", " "))
      end

      {
        neighborhood: target_name.capitalize,
        score: calculate_score(assets),
        assets_count: assets.count,
        assets: assets,
        stats: calculate_stats(assets)
      }
    end

    def neighborhoods
      @data.map do |item|
        raw = item["local_areas"] || item["local_area"] ||
              item["neighborhood_name"] || item["geo_local_area"]
        raw&.tr("-", " ")
      end.compact.uniq.sort
    end

    def city_stats
      all_neighborhoods = neighborhoods
      results = all_neighborhoods.map { |name| analyze_neighborhood(name) }

      {
        total_neighborhoods: all_neighborhoods.count,
        total_assets: @data.count,
        average_score: results.map { |r| r[:score] }.sum / all_neighborhoods.count.to_f,
        ranked: results.sort_by { |r| r[:score] }.reverse
      }
    end

    private

    def calculate_score(assets)
      assets.reduce(0) do |sum, asset|
        sum + (SCORING_RULES[asset["asset_type"]] || 0)
      end
    end

    def calculate_stats(assets)
      {
        gardens: assets.count { |a| a["asset_type"] == "Community Garden" },
        meals: assets.count { |a| a["asset_type"] == "Free Meal Program" }
      }
    end
  end
end
