<div align="center">

# RedSeed 🍎
### Neighborhood Food Security Intelligence

Empowering city planners and social workers with actionable food asset insights—before neighborhoods fall behind.

<p>
  <img src="https://img.shields.io/badge/RUBY-CC342D?style=for-the-badge&logo=ruby&logoColor=white" alt="Ruby" />
  <img src="https://img.shields.io/badge/CLI-THOR-blue?style=for-the-badge&logo=ruby&logoColor=white" alt="Thor" />
  <img src="https://img.shields.io/badge/API-FARADAY-brightgreen?style=for-the-badge" alt="Faraday" />
  <img src="https://img.shields.io/badge/DATA-VANCOUVER_OPEN_DATA-orange?style=for-the-badge" alt="Data" />
</p>

<p>
  <img src="https://img.shields.io/badge/LICENSE-MIT-gray?style=for-the-badge" alt="License" />
</p>

<br />

<i>Building the future of community wellness through open data and agricultural intelligence.</i>

---

</div>

📑 **Table of Contents**

🎯 [Mission](#-mission)
✨ [Key Features](#-key-features)
🛠 [Tech Stack](#-tech-stack)
🚀 [Getting Started](#-getting-started)
📖 [Usage Guide](#-usage-guide)
🔌 [Data Sources](#-data-sources)
📜 [License](#-license)

---

🎯 **Mission**

**Identify Needs. Plant Seeds.**

Every day, residents in Vancouver rely on local food assets. When neighborhoods are underserved, the community suffers two critical failures:

| ❌ Problem | 💰 Impact |
| :--- | :--- |
| **Asset Deserts** | Low-income residents lose access to affordable, healthy nutrition |
| **Poor Planning** | Resources are allocated to saturated areas while others starve |

**RedSeed** bridges this gap by providing an instant "Food Security Score"—answering one critical question:

> "Is this neighborhood providing enough food support for its people?"

💡 **How RedSeed Helps Communities**

| Feature | User Benefit |
| :--- | :--- |
| 🔮 **Asset Scoring Logic** | Quantifies food security (Gardens = 2pts, Meal Programs = 5pts) |
| ⏱ **Live API Integration** | Pulls real-time data from Vancouver Open Data—no stale files |
| 🚦 **Status Recommendations** | Suggests new garden sites automatically for low-scoring areas |
| 📑 **Markdown Reporting** | Export professional analysis reports for stakeholders in one click |

---

✨ **Key Features**

📡 **Real-Time Data Extraction**  
Fetches the latest records directly from the City of Vancouver's `free-and-low-cost-food-programs` and `community-gardens` datasets.

📊 **Interactive Mapping**  
Generates a professional Leaflet.js HTML map for any neighborhood. On macOS, the report opens automatically in your browser.

⚖️ **Comparison Engine**  
Pit two neighborhoods against each other to identify resource gaps and food security disparities.

📈 **Intelligent Scoring Engine**  
Calculates a weighted score based on the impact of different food assets. Meal programs offer immediate relief (5pts), while gardens provide long-term sustainability (2pts).

⚡ **Performance Cache**  
Includes a smart 24-hour local caching system to ensure instant results while respecting the City's API resource limits.

🧪 **Robust Test Suite**  
Fully integrated RSpec suite with unit and integration tests to ensure data integrity and scoring accuracy.

---

🛠 **Tech Stack**

**Languages**
- **Ruby**: Core logic, API orchestration, and CLI engine.
- **HTML/JS**: Leaflet.js integration for interactive mapping.
- **JSON**: Data interchange format for Open Data API results and local caching.

**Frameworks & Libraries**
- **Thor**: High-performance Ruby CLI framework.
- **Faraday**: Resilient HTTP client for API requests.
- **Terminal-Table**: ASCII table generator for console output.
- **RSpec**: Behavior-driven development framework for testing.

---

🚀 **Getting Started**

**Prerequisites**

| Requirement | Version | Check Command |
| :--- | :--- | :--- |
| **Ruby** | 2.6+ | `ruby -v` |
| **Bundler** | 2.0+ | `bundle -v` |

**Installation**

1. **Clone the Repository**
   ```bash
   git clone https://github.com/shamss11/RedSeed.git
   cd RedSeed
   ```

2. **Install Dependencies**
   ```bash
   bundle install --path vendor/bundle
   ```

3. **Verify Installation**
   ```bash
   bundle exec bin/urban --help
   ```

---

📖 **Usage Guide**

### 1. Identify Supported Areas
List all official Vancouver neighborhoods parsed by our engine.
```bash
bundle exec bin/urban neighborhoods
```

### 2. Analyze a Neighborhood
See the live score and a breakdown of every food asset in a specific area.
```bash
bundle exec bin/urban analyze "Kitsilano"
```

### 3. Compare Two Neighborhoods
Generate a side-by-side gap analysis between two areas.
```bash
bundle exec bin/urban compare "Kitsilano" "Mount Pleasant"
```

### 4. Create an Interactive Map
Generates a styled Leaflet.js map in the `reports/` folder. (Opens automatically on macOS).
```bash
bundle exec bin/urban map "West End"
```

### 5. Export a Professional Report
Saves the analysis results to a styled Markdown file for stakeholders.
```bash
bundle exec bin/urban export "Downtown"
```

### 6. Run the Test Suite
Verify the logic and API connectivity.
```bash
bundle exec rspec
```

---

🚦 **Understanding Score Status**

| Status | Total Score | Action Recommended |
| :--- | :--- | :--- |
| 🟢 **Healthy** | ≥ 30 | Maintain current assets |
| 🟡 **Warning** | 10-30 | Consider expanding community garden sites |
| 🔴 **Critical** | < 10 | **Immediate action needed for meal programs!** |

### 🗺️ Data Coverage
RedSeed currently supports all 22 official local areas within the **City of Vancouver**:

Arbutus Ridge • Downtown • Dunbar Southlands • Fairview • Grandview Woodland • Hastings Sunrise • Kensington Cedar Cottage • Killarney • Kitsilano • Marpole • Mount Pleasant • Oakridge • Renfrew Collingwood • Riley Park • Shaughnessy • South Cambie • Strathcona • Sunset • Victoria Fraserview • West End • West Point Grey

---

<p align="center">
  <b>Built with ❤️ for a more food-secure Vancouver</b><br>
  <i>Data provided by the City of Vancouver Open Data Portal</i>
</p>

---

🔌 **Data Sources**

RedSeed utilizes the [Vancouver Open Data Portal](https://opendata.vancouver.ca/) via their REST API.

*   **Dataset 1**: `free-and-low-cost-food-programs`
*   **Dataset 2**: `community-gardens-and-food-trees`

---

<div align="center">

📜 **License**

This project is open source and available under the **MIT License**.

Made with 🍎 by [shamss11](https://github.com/shamss11)


</div>