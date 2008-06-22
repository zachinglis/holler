module RubyExtensions; end

class Time
  def pretty_date
    day = self.strftime("%e").to_i.ordinalize
    self.strftime("#{day} %B")
  end
end
