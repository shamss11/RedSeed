# frozen_string_literal: true

require "terminal-table"

module RedSeed
  # TableBuilder generates Terminal::Table objects for the CLI
  module TableBuilder
    def self.build_analysis_table(result)
      ::Terminal::Table.new do |t|
        t.title = "RedSeed Analysis: #{result[:neighborhood]}"
        t.headings = ["Asset Name", "Type", "Points", "Recommendation"]
        add_asset_rows(t, result[:assets])
        t.add_separator
        t.add_row [{ value: "Total Score: #{result[:score]}", colspan: 4, alignment: :center }]
      end
    end

    def self.build_comparison_table(res1, res2)
      ::Terminal::Table.new do |t|
        t.title = "RedSeed Comparison: #{res1[:neighborhood]} vs #{res2[:neighborhood]}"
        t.headings = ["Metric", res1[:neighborhood], res2[:neighborhood], "Diff"]
        add_comparison_rows(t, res1, res2)
      end
    end

    def self.add_asset_rows(table, assets)
      assets.each do |asset|
        name = asset["program_name"] || asset["name"] || "Unknown"
        points = Analyzer::SCORING_RULES[asset["asset_type"]] || 0
        rec = points < 5 ? "Potential site for new community garden" : "N/A"
        table.add_row [name, asset["asset_type"], points, rec]
      end
    end

    def self.add_comparison_rows(table, r1, r2)
      table.add_row ["Total Score", r1[:score], r2[:score], r1[:score] - r2[:score]]
      table.add_row ["Asset Count", r1[:assets_count], r2[:assets_count],
                     r1[:assets_count] - r2[:assets_count]]
      add_asset_type_comparison_rows(table, r1, r2)
    end

    def self.add_asset_type_comparison_rows(table, r1, r2)
      table.add_row ["Gardens", r1[:stats][:gardens], r2[:stats][:gardens],
                     r1[:stats][:gardens] - r2[:stats][:gardens]]
      table.add_row ["Meal Programs", r1[:stats][:meals], r2[:stats][:meals],
                     r1[:stats][:meals] - r2[:stats][:meals]]
    end

    private_class_method :add_asset_rows, :add_comparison_rows, :add_asset_type_comparison_rows
  end
end
