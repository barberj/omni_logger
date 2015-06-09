class FakeLogger
  attr_accessor :level

  def method_missing(method_sym, *arguments, &block)
    if OmniLogger::LOG_LEVELS.rassoc(method_sym) <= level
      binding.pry
    else
      super
    end
  end
end
