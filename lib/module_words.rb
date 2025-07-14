module Words
  def self.word_sample
    txt_file = 'lib/words.txt'
    words = []
    filtered_words = []

    File.readlines(txt_file).each do |line|
      words += line.gsub(/[^a-z\s]/, '').split(' ')
    end

    words.each do |word|
      filtered_words.push(word) if word.length > 5 && word.length < 12
    end
    filtered_words.sample
  end
end
