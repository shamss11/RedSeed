<div align="center">

# RedSeed 🍎
### Neighborhood Food Security Intelligence

Empowering city planners and social workers with actionable food asset insights—before neighborhoods fall behind.

`Ruby` `Thor` `Faraday` `Terminal-Table` `Vancouver Open Data API`

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

📈 **Intelligent Scoring Engine**
Calculates a weighted score based on the impact of different food assets. Meal programs offer immediate relief (5pts), while gardens provide long-term sustainability (2pts).

🎨 **Clean Terminal UI**
Uses `terminal-table` for high-contrast, professional data presentation in your shell.

🔗 **Extensible Architecture**
Modular Ruby design makes it easy to add new datasets (like food vendors or farmers markets) by simply updating the `DataFetcher`.

---

🛠 **Tech Stack**

| Layer | Technology | Purpose |
| :--- | :--- | :--- |
| **Language** | Ruby | Modern, expressive language for fast CLI development |
| **CLI Framework** | Thor | Powerful toolkit for building high-quality CLI interfaces |
| **HTTP Client** | Faraday | Robust HTTP client for reliable API communication |
| **Data Format** | JSON | Standard parsing of Open Data records |
| **Formatting** | Terminal-Table | Generates professional tables directly in the terminal |
| **Source Control** | Git | Versioning and collaboration |

---

🚀 **Getting Started**

**Prerequisites**

| Requirement | Version | Check Command |
| :--- | :--- | :--- |
| **Ruby** | 2.6+ | `ruby -v` |
| **Bundler** | 2.0+ | `bundle -v` |

**Installation**

```bash
# 1. Clone the repository
git clone https://github.com/shamss11/RedSeed.git
cd RedSeed

# 2. Install dependencies
bundle install --path vendor/bundle

# 3. Verify installation
bundle exec bin/urban --help
```

---

📖 **Usage Guide**

### 1. Analyze a Neighborhood
See the live score and a breakdown of every food asset in a specific area.
```bash
bundle exec bin/urban analyze "Kitsilano"
```

### 2. Export a Professional Report
Saves the analysis results to a styled Markdown file in the `reports/` folder.
```bash
bundle exec bin/urban export "Downtown"
```

---

🚦 **Understanding Score Status**

| Status | Total Score | Action Recommended |
| :--- | :--- | :--- |
| 🟢 **Healthy** | ≥ 30 | Maintain current assets |
| 🟡 **Warning** | 10-30 | Consider expanding community garden sites |
| 🔴 **Critical** | < 10 | **Immediate action needed for meal programs!** |

---

🔌 **Data Sources**

RedSeed utilizes the [Vancouver Open Data Portal](https://opendata.vancouver.ca/) via their REST API. **No API Key is required** for development.

*   **Dataset 1**: `free-and-low-cost-food-programs`
*   **Dataset 2**: `community-gardens-and-food-trees`

---

<div align="center">

📜 **License**

This project is open source and available under the **MIT License**.

Made with 🍎 by [shamss11](https://github.com/shamss11)

**Stop guessing. Start planting.**

</div>