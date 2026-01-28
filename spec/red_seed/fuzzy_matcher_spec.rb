# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/red_seed"

RSpec.describe RedSeed::FuzzyMatcher do
  describe ".levenshtein_distance" do
    it "returns 0 for identical strings" do
      expect(described_class.levenshtein_distance("kitten", "kitten")).to eq(0)
    end

    it "calculates distance correctly for 1 substitution" do
      expect(described_class.levenshtein_distance("kitten", "sitten")).to eq(1)
    end

    it "calculates distance correctly for 1 insertion" do
      expect(described_class.levenshtein_distance("kit", "kitten")).to eq(3)
    end
  end

  describe ".find_best_match" do
    let(:candidates) { ["Downtown", "Kitsilano", "Mount Pleasant"] }

    it "finds the closest match for a typo" do
      match = described_class.find_best_match("Kitsalano", candidates)
      expect(match[:name]).to eq("Kitsilano")
      expect(match[:distance]).to eq(1)
    end

    it "finds the closest match regardless of case and hyphens" do
      match = described_class.find_best_match("mount-pleasant", candidates)
      expect(match[:name]).to eq("Mount Pleasant")
      expect(match[:distance]).to eq(0)
    end
  end
end
