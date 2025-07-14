
module Words
      
    def self.word_sample
      txt_file = 'lib/words.txt'
      words = []
      filtered_words = []

      File.readlines(txt_file).each do |line|
        words = words + line.gsub(/[^a-z\s]/, '').split(' ')
      end
      
      words.each do |word|
        if word.length > 5 && word.length < 12
          filtered_words.push(word)
          
        end
      end
      current_word = filtered_words.sample
      return current_word
    end
end
