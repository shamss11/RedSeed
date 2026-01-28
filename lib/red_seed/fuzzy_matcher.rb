# frozen_string_literal: true

module RedSeed
  # FuzzyMatcher provides string distance calculations to suggest neighborhoods
  module FuzzyMatcher
    def self.find_best_match(target, candidates)
      target = target.downcase.tr("-", " ")
      matches = candidates.map do |candidate|
        {
          name: candidate,
          distance: levenshtein_distance(target, candidate.downcase.tr("-", " "))
        }
      end
      matches.min_by { |m| m[:distance] }
    end

    def self.levenshtein_distance(str_s, str_t)
      m_len = str_s.length
      n_len = str_t.length
      return m_len if n_len.zero?
      return n_len if m_len.zero?

      matrix = Array.new(m_len + 1) { Array.new(n_len + 1) }
      initialize_matrix(matrix, m_len, n_len)
      fill_matrix(matrix, str_s, str_t)
      matrix[m_len][n_len]
    end

    def self.initialize_matrix(matrix, rows, cols)
      (0..rows).each { |i| matrix[i][0] = i }
      (0..cols).each { |j| matrix[0][j] = j }
    end

    def self.fill_matrix(matrix, str_s, str_t)
      (1..str_t.length).each do |j|
        (1..str_s.length).each do |i|
          matrix[i][j] = calculate_cell(matrix, i, j, str_s[i - 1], str_t[j - 1])
        end
      end
    end

    def self.calculate_cell(matrix, row, col, char_s, char_t)
      cost = char_s == char_t ? 0 : 1
      [
        matrix[row - 1][col] + 1,      # deletion
        matrix[row][col - 1] + 1,      # insertion
        matrix[row - 1][col - 1] + cost # substitution
      ].min
    end

    private_class_method :initialize_matrix, :fill_matrix, :calculate_cell
  end
end
