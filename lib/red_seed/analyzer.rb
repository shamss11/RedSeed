module RedSeed
  class Analyzer
    SCORING_RULES = {
      'Community Garden' => 2,
      'Free Meal Program' => 5
    }.freeze

    def initialize(data)
      @data = data
    end

    def analyze_neighborhood(target_name)
      target_name = target_name.to_s.downcase.strip
      
      # The API uses 'local_areas' for programs and often 'local_area' for gardens
      # We'll normalize this by checking common field names
      assets = @data.select do |item|
        neighborhood = item["local_areas"] || item["local_area"] || item["neighborhood_name"] || item["geo_local_area"]
        neighborhood&.downcase&.include?(target_name)
      end

      score = assets.reduce(0) do |sum, asset|
        sum + (SCORING_RULES[asset["asset_type"]] || 0)
      end

      {
        neighborhood: target_name.capitalize,
        score: score,
        assets_count: assets.count,
        assets: assets
      }
    end

    def neighborhoods
      @data.map do |item| 
        item["local_areas"] || item["local_area"] || item["neighborhood_name"] || item["geo_local_area"]
      end.compact.uniq.sort
    end
  end
end
