class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    by_exhibit_interest = {}
    exhibits.each do |exhibit|
      by_exhibit_interest[exhibit] = []
      patrons.each do |patron|
        if recommend_exhibits(patron).include?(exhibit)
          by_exhibit_interest[exhibit] << patron
        end
      end
    end
    by_exhibit_interest
  end

end
