require "omni_logger/version"
require "omni_logger/broadcast"

module OmniLogger
  LOG_LEVELS = {
    debug: Logger::Severity::DEBUG,
    info: Logger::Severity::INFO,
    warn: Logger::Severity::WARN,
    fatal: Logger::Severity::FATAL,
    error: Logger::Severity::ERROR
  }

  def self.default_loggers
    @default_loggers ||= []
  end

  def self.add_default_loggers(*loggers)
    default_loggers.concat(loggers)
  end

  def self.reset_default_loggers
    @default_loggers = []
  end
end
