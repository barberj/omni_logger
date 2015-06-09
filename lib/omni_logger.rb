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
end
