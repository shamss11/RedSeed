# frozen_string_literal: true

require "thor"
require "terminal-table"

module RedSeed
  # CLI defines the commands and user interface for the RedSeed tool
  class CLI < Thor
    desc "analyze NEIGHBORHOOD", "Calculate food security score for a given neighborhood"
    def analyze(neighborhood)
      result = perform_analysis(neighborhood)
      return unless result

      display_results(result)
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

    private

    def perform_analysis(neighborhood)
      say "Fetching data from Vancouver Open Data...", :yellow
      data = DataFetcher.fetch_all
      analyzer = Analyzer.new(data)
      result = analyzer.analyze_neighborhood(neighborhood)

      if result[:assets].empty?
        say "No data found for neighborhood: #{neighborhood}", :red
        say "Available neighborhoods include: #{analyzer.neighborhoods.first(10).join(', ')}...", :cyan
        return nil
      end
      result
    rescue StandardError => e
      say "Error: #{e.message}", :red
      nil
    end

    def display_results(result)
      table = ::Terminal::Table.new do |t|
        t.title = "RedSeed Analysis: #{result[:neighborhood]}"
        t.headings = ["Asset Name", "Type", "Points", "Recommendation"]
        add_asset_rows(t, result[:assets])
        t.add_separator
        t.add_row [{ value: "Total Score: #{result[:score]}", colspan: 4, alignment: :center }]
      end
      puts table
      check_low_score(result[:score])
    end

    def display_comparison(res1, res2)
      table = ::Terminal::Table.new do |t|
        t.title = "RedSeed Comparison: #{res1[:neighborhood]} vs #{res2[:neighborhood]}"
        t.headings = ["Metric", res1[:neighborhood], res2[:neighborhood], "Diff"]
        add_comparison_rows(t, res1, res2)
      end
      puts table
    end

    def add_comparison_rows(table, r1, r2)
      table.add_row ["Total Score", r1[:score], r2[:score], r1[:score] - r2[:score]]
      table.add_row ["Asset Count", r1[:assets_count], r2[:assets_count],
                     r1[:assets_count] - r2[:assets_count]]
      add_asset_type_comparison_rows(table, r1, r2)
    end

    def add_asset_type_comparison_rows(table, r1, r2)
      table.add_row ["Gardens", r1[:stats][:gardens], r2[:stats][:gardens],
                     r1[:stats][:gardens] - r2[:stats][:gardens]]
      table.add_row ["Meal Programs", r1[:stats][:meals], r2[:stats][:meals],
                     r1[:stats][:meals] - r2[:stats][:meals]]
    end

    def add_asset_rows(table, assets)
      assets.each do |asset|
        name = asset["program_name"] || asset["name"] || "Unknown"
        points = Analyzer::SCORING_RULES[asset["asset_type"]] || 0
        rec = points < 5 ? "Potential site for new community garden" : "N/A"
        table.add_row [name, asset["asset_type"], points, rec]
      end
    end

    def check_low_score(score)
      return unless score < 5

      say "\nNote: This neighborhood has a low food security score. " \
          "Consider advocating for more programs!", :magenta
    end
  end
end
