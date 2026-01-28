# RedSeed 🍎

RedSeed is a Ruby-based CLI tool that analyzes neighborhood food security in Vancouver by quantifying local food assets.

## Features
- **Data Integration**: Fetches real-time data from the City of Vancouver Open Data Portal.
- **Scoring System**:
  - Community Gardens = 2 pts
  - Free Meal Programs = 5 pts
- **Analysis**: Groups assets by neighborhood and calculates a "Food Security Score".
- **Recommendations**: Suggests potential sites for new community gardens in low-scoring areas.
- **Export**: Generates Markdown reports for offline review.

## Installation

1. Ensure you have Ruby installed.
2. Clone this repository.
3. Install dependencies:
   ```bash
   bundle install --path vendor/bundle
   ```

## Usage

### Analyze a Neighborhood
Run the following command to see a live table of food assets and the neighborhood's score:
```bash
bundle exec bin/urban analyze "Kitsilano"
```

### Export a Report
Generate a Markdown report in the `reports/` folder:
```bash
bundle exec bin/urban export "Kitsilano"
```

## API Information
This tool uses the Vancouver Open Data Portal (OpenDataSoft API v2.1). 
- **Datasets**: 
  - `free-and-low-cost-food-programs`
  - `community-gardens-and-food-trees`
- **Key Requirement**: No API key is required for public usage.

## Development
To add new scoring rules, modify `lib/red_seed/analyzer.rb`.
To add new datasets, update `lib/red_seed/data_fetcher.rb`.

---
_Built for Social Good using Vancouver Open Data._