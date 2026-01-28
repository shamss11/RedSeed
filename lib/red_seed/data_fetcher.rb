module RedSeed
  class DataFetcher
    BASE_URL = "https://opendata.vancouver.ca/api/explore/v2.1/catalog/datasets"
    
    DATASETS = {
      meals: "free-and-low-cost-food-programs",
      gardens: "community-gardens-and-food-trees"
    }.freeze

    def self.fetch_data(dataset_type)
      dataset_id = DATASETS[dataset_type]
      url = "#{BASE_URL}/#{dataset_id}/records"
      
      conn = Faraday.new(url: url) do |f|
        f.request :url_encoded
        f.adapter Faraday.default_adapter
      end

      response = conn.get do |req|
        req.params['limit'] = 100
      end

      if response.success?
        JSON.parse(response.body)["results"]
      else
        raise "Failed to fetch #{dataset_type} from Vancouver Open Data: #{response.status}"
      end
    end

    def self.fetch_all
      meals = fetch_data(:meals).map { |r| r.merge("asset_type" => "Free Meal Program") }
      gardens = fetch_data(:gardens).map { |r| r.merge("asset_type" => "Community Garden") }
      meals + gardens
    end
  end
end
