class FakeLogger
  attr_accessor :level

  def messages
    @message ||= []
  end

  def method_missing(method_sym, message)
    log_level = OmniLogger::LOG_LEVELS[method_sym]
    if !log_level.nil?
      messages.concat(message) if  OmniLogger::LOG_LEVELS.rassoc(level).last <= log_level
    else
      super
    end
  end
end
