require "logger"
require "omni_logger/version"

class OmniLogger
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

  def initialize(args={})
    @loggers = [].concat(OmniLogger.default_loggers)
    self.level = args[:level] || :debug

    Array(args[:loggers]).each { |logger| add_logger(logger) }
  end

  def add_logger(logger)
    logger.level = @level
    @loggers << logger
  end

  def level=(level_to_log)
    @level = OmniLogger::LOG_LEVELS.fetch(level_to_log, level_to_log)
    @loggers.each { |logger| logger.level = @level }
  end

  def level
    OmniLogger::LOG_LEVELS.rassoc(@level).first
  end

  def close
    @loggers.map(&:close)
  end

  def add(level, *args)
    @loggers.each { |logger| logger.add(level, *args) }
  end

  Logger::Severity.constants.each do |level|
    define_method(level.downcase) do |*args|
      @loggers.each { |logger| logger.send(level.downcase, args) }
    end

    define_method("#{ level.downcase }?".to_sym) do
      @level <= Logger::Severity.const_get(level)
    end
  end
end
