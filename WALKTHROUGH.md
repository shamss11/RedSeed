# RedSeed Walkthrough: Food Security Analysis

RedSeed is now fully implemented and verified. This tool allows you to analyze food security across Vancouver neighborhoods using real-time open data.

## 1. Project Setup
The project is structured for modularity:
- `DataFetcher`: Communicates with Vancouver's OpenDataSoft API.
- `Analyzer`: Implements the scoring logic (Meals: 5pts, Gardens: 2pts).
- `CLI`: Provides the user interface via Thor and Terminal-Table.

## 2. Running Analysis
You can run the analysis for any Vancouver neighborhood. 

### Kitsilano Result
The tool identifies both Free Meal Programs and Community Gardens, calculating a total score and providing recommendations.

```bash
bundle exec bin/urban analyze Kitsilano
```
(Score: 49)

### Downtown Result
A high-density area with many meal programs.
```bash
bundle exec bin/urban analyze Downtown
```
(Score: 69)

### Marpole Result
A neighborhood with fewer assets, triggering the "Low Score" notification.
```bash
bundle exec bin/urban analyze Marpole
```
(Score: 16)

## 3. Exporting Reports
Results can be saved as Markdown files for reporting purposes.
```bash
bundle exec bin/urban export Kitsilano
```
_Exported to: reports/kitsilano_analysis.md_

---
The tool is ready for production use and can be easily extended with new datasets or scoring rules.
