module BooksHelper
  def publication_years
    (1900..Date.today.year).to_a.reverse
  end
  
  def rating_options
    [['Any Rating', '']] + (1..5).step(0.5).map { |r| ["#{r}+", r] }
  end
end