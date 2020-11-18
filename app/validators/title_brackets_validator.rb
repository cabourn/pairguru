class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    valid_pairs = {"(" => ")", "{" => "}", "[" => "]"}
    brackets = []
    bracket_content = []
    record.title.each_char do |x|
      if valid_pairs.keys.include?(x)
        brackets.push(x)
        bracket_content.clear
      elsif valid_pairs.values.include?(x)
        record.errors.add(:base, "has invalid title") if bracket_content.empty? || brackets.empty? || (valid_pairs[brackets.last] != x)
        brackets.pop
      else
        bracket_content << x
      end
    end
    record.errors.add(:base, "has invalid title") unless brackets.empty?
  end
end
