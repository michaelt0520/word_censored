require "word_censored/version"
require "json"

module WordCensored
  class Error < StandardError; end
  # Your code goes here...

  REGEX_FIRST_LETTER = /[a-zàáãạảăắằẳẵặâấầẩẫậèéẹẻẽêềếểễệđìíĩỉịòóõọỏôốồổỗộơớờởỡợùúũụủưứừửữựỳỵỷỹý]/i
  REGEX_PREPROCESS   = /([^0-9a-zàáãạảăắằẳẵặâấầẩẫậèéẹẻẽêềếểễệđìíĩỉịòóõọỏôốồổỗộơớờởỡợùúũụủưứừửữựỳỵỷỹý ])/i

  def filter(str)
    blacklist  = combine_blacklist
    @str_array = str.split(/[[:space:]]/)
    cindex     = -1

    @str_array.each_with_index do |word, index|
      next if index <= cindex
      next if preprocess(word).strip.empty?

      first_letter = preprocess(word)[0].match?(REGEX_FIRST_LETTER) ? preprocess(word)[0] : 'other'
      ibadword     = detect_badword(blacklist[first_letter], index, index)
      replace_asterisk(index, ibadword) && cindex = ibadword if ibadword >= index
    end

    @str_array.join(' ')
  end

  private

  def detect_badword(arr, origin_index, index, result_index = -1)
    return result_index if arr.nil?

    word           = preprocess(@str_array[origin_index..index].join(' '))
    list_badwords  = arr.find_all { |value| value =~ /\A#{word} /i }
    result_index   = index if arr.include?(word)
    return result_index if list_badwords.empty? || @str_array[index + 1].nil?

    detect_badword(list_badwords, origin_index, index + 1, result_index)
  end

  def replace_asterisk(from, to)
    (from..to).to_a.each { |i| @str_array[i] = '*' * @str_array[i].length }
  end

  def preprocess(word)
    word.downcase.gsub(REGEX_PREPROCESS, '')
  end

  def combine_blacklist
    blacklist  = JSON.parse(File.read(File.join(File.dirname(__FILE__), 'files/blacklist.json')))
    eblacklist = validate_external_blacklist
    return blacklist unless eblacklist

    blacklist.merge(eblacklist) { |key, _| (blacklist[key] + eblacklist[key]).uniq }
  end

  def validate_external_blacklist
    path = Rails.public_path.join('assets', 'blacklist.json')
    return false unless File.exist?(path)

    external = JSON.parse(File.read(path))
    return false if external.values.any? { |value| value.is_a?(String) }

    external
  rescue JSON::ParserError
    false
  end
end
