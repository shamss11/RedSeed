# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/red_seed"

RSpec.describe RedSeed::Analyzer do
  let(:data) do
    [
      {
        "asset_type" => "Community Garden",
        "local_areas" => "Kitsilano",
        "name" => "Kits Garden"
      },
      {
        "asset_type" => "Free Meal Program",
        "local_areas" => "Kitsilano",
        "program_name" => "Kits Meal"
      },
      {
        "asset_type" => "Community Garden",
        "local_areas" => "Downtown",
        "name" => "Urban Garden"
      }
    ]
  end

  subject(:analyzer) { described_class.new(data) }

  describe "#analyze_neighborhood" do
    it "calculates the correct score for Kitsilano" do
      result = analyzer.analyze_neighborhood("Kitsilano")
      # 1 Garden (2pts) + 1 Meal (5pts) = 7pts
      expect(result[:score]).to eq(7)
    end

    it "groups the correct number of assets" do
      result = analyzer.analyze_neighborhood("Kitsilano")
      expect(result[:assets_count]).to eq(2)
    end

    it "handles case-insensitive matching" do
      result = analyzer.analyze_neighborhood("kitsilano")
      expect(result[:score]).to eq(7)
    end

    it "returns zero for unknown neighborhoods" do
      result = analyzer.analyze_neighborhood("Marpole")
      expect(result[:score]).to eq(0)
    end
  end

  describe "#neighborhoods" do
    it "returns a sorted list of unique neighborhoods" do
      expect(analyzer.neighborhoods).to eq(%w(Downtown Kitsilano))
    end
  end
end
