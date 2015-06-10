require 'spec_helper'

describe OmniLogger do
  before { OmniLogger.reset_default_loggers }

  let(:omni_logger) do
    OmniLogger.new
  end

  it 'has a version number' do
    expect(OmniLogger::VERSION).not_to be nil
  end

  describe '#new' do
    it 'initializes with loggers' do
      omni_logger = OmniLogger.new(loggers: [FakeLogger.new])
      expect(omni_logger.instance_variable_get(:@loggers).size).to eq(1)
    end
  end

  describe '#level' do
    it 'defaults to debug' do
      expect(OmniLogger.new.level).
        to eq :debug
    end
    [:debug, :info, :warn, :fatal, :error].each do |severity|
      it "handles #{severity} severity" do
        expect(OmniLogger.new(level: severity).level).
          to eq severity
      end
    end
  end

  describe '#add_logger' do
    it 'adds' do
      expect{ omni_logger.add_logger(FakeLogger.new) }.
        to change{ omni_logger.instance_variable_get(:@loggers).size}.
        by(1)
    end
    [:debug, :info, :warn, :fatal, :error].each do |severity|
      it "sets #{severity} log level" do
        omni_logger.level=severity
        omni_logger.add_logger(FakeLogger.new)
        logger = omni_logger.instance_variable_get(:@loggers).first
        expect(logger.level).to eq(OmniLogger::LOG_LEVELS[severity])
      end
    end
  end
  context 'logging' do
    let(:logger) do
      omni_logger.add_logger(FakeLogger.new)
      omni_logger.instance_variable_get(:@loggers).first
    end
    before { logger }
    it 'sends' do
      expect{ omni_logger.info('The quick brown fox jumps over a lazy dog') }.
        to change { logger.messages }

      expect(logger.messages).to include( 'The quick brown fox jumps over a lazy dog' )
    end
    it 'ignores' do
      omni_logger.level = :fatal
      expect{ omni_logger.info('The quick brown fox jumps over a lazy dog') }.
        to_not change { logger.messages }

      expect(logger.messages).to be_empty
    end
    it 'can send to multiple' do
      expect{ omni_logger.info('The quick brown fox jumps over a lazy dog') }.
        to change { logger.messages }

      omni_logger.add_logger(FakeLogger.new)
      another = omni_logger.instance_variable_get(:@loggers).last

      omni_logger.info('two')

      expect(logger.messages).to include( 'two' )

      expect(another.messages).to_not include( 'The quick brown fox jumps over a lazy dog' )
      expect(another.messages).to include( 'two' )
    end
  end

  context 'default_loggers' do
    it 'defaults to empty' do
      expect(OmniLogger.default_loggers).to be_empty
    end
    it 'collects' do
      expect{ OmniLogger.add_default_loggers(FakeLogger.new, FakeLogger.new) }.
        to change{ OmniLogger.default_loggers.size }.by(2)
    end
    it 'resets' do
      OmniLogger.add_default_loggers(FakeLogger.new, FakeLogger.new)

      expect{ OmniLogger.reset_default_loggers }.
        to change{ OmniLogger.default_loggers.size }.by(-2)
    end
    it 'uses to send' do
      OmniLogger.add_default_loggers(FakeLogger.new, FakeLogger.new)
      loggers = omni_logger.instance_variable_get(:@loggers)
      expect(loggers.size).to eq 2

      omni_logger.info('message')

      loggers.each do |logger|
        expect(logger.messages).to include('message')
      end
    end
  end
end
