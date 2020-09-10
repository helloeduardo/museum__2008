class Museum
  attr_reader :name, :exhibits, :patrons, :revenue

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
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
    attend_exhibits(patron)
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

  def ticket_lottery_contestants(exhibit)
    patrons_by_exhibit_interest[exhibit].find_all do |patron|
      patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    winner = ticket_lottery_contestants(exhibit).sample
    winner.name unless winner.nil?
  end

  def announce_lottery_winner(exhibit)
    return "No winners for this lottery" if draw_lottery_winner(exhibit).nil?
    "#{draw_lottery_winner(exhibit)} has won the #{exhibit.name} exhibit lottery"
  end

  def attend_exhibits(patron)
    recommend_exhibits(patron).each do |exhibit|
      if patron.spending_money >= exhibit.cost
        patron.spending_money -= exhibit.cost
        @revenue += exhibit.cost
        patrons_of_exhibits[exhibit] << patron
      end
    end
  end

  def patrons_of_exhibits
    of_exhibits = {}
    exhibits.each do |exhibit|
      if of_exhibits[exhibit].nil?
        of_exhibits[exhibit] = []
      end
    end
    of_exhibits
  end

end
