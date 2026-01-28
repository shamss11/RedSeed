# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/red_seed"

RSpec.describe RedSeed::DataFetcher do
  describe ".fetch_all" do
    let(:mock_response) { double("Faraday::Response", success?: true, body: '{"results": []}') }

    before do
      # Mock the cache methods to avoid hitting filesystem or API
      allow(described_class).to receive(:cache_fresh?).and_return(false)
      allow(described_class).to receive(:update_cache)
      allow(Faraday).to receive(:get).and_return(mock_response)
    end

    it "calls the API twice (once for each dataset)" do
      described_class.fetch_all
      expect(Faraday).to have_received(:get).twice
    end
  end
end
