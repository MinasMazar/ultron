require "ultron/version"

module Ultron
  @@ultron_instance = nil
  def self.init(file)
    @@ultron_instance ||= Instance.new(file)
  end
  def self.update!(data)
    @@ultron_instance || init($0) && @@ultron_instance.update!(data)
  end
  def self.inst
    @@ultron_instance || init($0)
  end
  class Instance
    attr_reader :file, :data_pos
    attr_accessor :data
    def initialize(file)
      @file = file
      unless defined? DATA
        f = File.new @file, "r+"
        f.seek 0, File::SEEK_END
        f.write "\n__END__\n"
        @data_pos = f.pos
        @data = []
        f.flush
        f.close
      else
        @data_pos = DATA.pos
        @data = DATA.readlines.map(&:chomp)
      end
    end
    def update!(data = [])
      data = [ data ] unless data.kind_of? Array
      @data += data
      file = File.new @file, "r+"
      file.seek @data_pos
      file.write @data.join "\n"
      file.close
    end
  end
end
