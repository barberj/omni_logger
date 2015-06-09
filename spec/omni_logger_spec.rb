require 'spec_helper'

describe OmniLogger do
  it 'has a version number' do
    expect(OmniLogger::VERSION).not_to be nil
  end

  describe '#level' do
    it 'defaults to debug' do
      expect(OmniLogger::Broadcast.new.level).
        to eq :debug
    end
    [:debug, :info, :warn, :fatal, :error].each do |severity|
      it "handles #{severity} severity" do
        expect(OmniLogger::Broadcast.new(level: severity).level).
          to eq severity
      end
    end
  end

  describe '#add_logger' do
    let(:broadcaster) do
      OmniLogger::Broadcast.new
    end
    it 'adds' do
      expect{ broadcaster.add_logger(FakeLogger.new) }.
        to change{ broadcaster.instance_variable_get(:@loggers).size}.
        by(1)
    end
    it 'sets log level' do
      broadcaster.add_logger(FakeLogger.new)
      broadcaster.instance_variable_get(:@loggers).first
    end
  end
end
