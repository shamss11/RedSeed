# frozen_string_literal: true

require "thor"
require "terminal-table"
require "rbconfig"

module RedSeed
  # CLI defines the commands and user interface for the RedSeed tool
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    desc "analyze NEIGHBORHOOD", "Calculate food security score for a given neighborhood"
    def analyze(neighborhood)
      result = perform_analysis(neighborhood)
      return unless result

      display_results(result)
    end

    desc "stats", "Show city-wide food security statistics and rankings"
    def stats
      say "Analyzing all neighborhoods... this may take a moment", :yellow
      data = DataFetcher.fetch_all
      analyzer = Analyzer.new(data)
      stats = analyzer.city_stats

      puts TableBuilder.build_city_stats_table(stats)
    end

    desc "neighborhoods", "List all supported neighborhoods in Vancouver"
    def neighborhoods
      say "Fetching available neighborhoods...", :yellow
      data = DataFetcher.fetch_all
      analyzer = Analyzer.new(data)

      say "\nSupported Neighborhoods:", :bold
      analyzer.neighborhoods.each { |n| say "- #{n}", :cyan }
    end

    desc "export NEIGHBORHOOD", "Export analysis results to a markdown file in reports/"
    def export(neighborhood)
      result = perform_analysis(neighborhood)
      return unless result

      dirname = "reports"
      Dir.mkdir(dirname) unless File.exist?(dirname)

      filename = "#{dirname}/#{neighborhood.downcase.tr(' ', '_')}_analysis.md"
      File.write(filename, ReportGenerator.generate_markdown(result))
      say "Report exported successfully to #{filename}", :green
    end

    desc "compare NEIGHBORHOOD1 NEIGHBORHOOD2", "Compare food security between two neighborhoods"
    def compare(n1, n2)
      say "Fetching data for comparison...", :yellow
      data = DataFetcher.fetch_all
      analyzer = Analyzer.new(data)

      res1 = analyzer.analyze_neighborhood(n1)
      res2 = analyzer.analyze_neighborhood(n2)

      if res1[:assets].empty? || res2[:assets].empty?
        say "One or both neighborhoods returned no data.", :red
        return
      end

      display_comparison(res1, res2)
    end

    desc "map NEIGHBORHOOD", "Generate an interactive HTML map for a neighborhood"
    def map(neighborhood)
      result = perform_analysis(neighborhood)
      return unless result

      dirname = "reports"
      Dir.mkdir(dirname) unless File.exist?(dirname)

      filename = "#{dirname}/#{neighborhood.downcase.tr(' ', '_')}_map.html"
      File.write(filename, ReportGenerator.generate_html_map(result))
      say "Interactive map generated: #{filename}", :green

      # Automatically open on macOS
      system("open", filename) if RbConfig::CONFIG["host_os"] =~ /darwin/
    end

    private

    def perform_analysis(neighborhood)
      say "Fetching data from Vancouver Open Data...", :yellow
      data = DataFetcher.fetch_all
      analyzer = Analyzer.new(data)
      result = analyzer.analyze_neighborhood(neighborhood)

      return result unless result[:assets].empty?

      handle_missing_neighborhood(neighborhood, analyzer)
      nil
    rescue StandardError => e
      say "Error: #{e.message}", :red
      nil
    end

    def handle_missing_neighborhood(neighborhood, analyzer)
      say "No data found for neighborhood: #{neighborhood}", :red
      best_match = FuzzyMatcher.find_best_match(neighborhood, analyzer.neighborhoods)

      if best_match && best_match[:distance] <= 3
        say "\nDid you mean: \"#{best_match[:name]}\"?", :yellow
      else
        say "\nNote: RedSeed currently focuses on the City of Vancouver.", :yellow
        say "Available neighborhoods include:", :bold
        analyzer.neighborhoods.each { |name| say "  • #{name}", :cyan }
      end
    end

    def display_results(result)
      puts TableBuilder.build_analysis_table(result)
      check_low_score(result[:score])
    end

    def display_comparison(res1, res2)
      puts TableBuilder.build_comparison_table(res1, res2)
    end

    def check_low_score(score)
      return unless score < 5

      say "\nNote: This neighborhood has a low food security score. " \
          "Consider advocating for more programs!", :magenta
    end
  end
end
