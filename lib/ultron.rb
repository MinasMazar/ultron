require "ultron/version"
require "yaml"

module Ultron
  def __ultron_data
    @__ultron_data
  end
  def __ultron_data=(data)
    @__ultron_data = data
  end
  def __ultron_init
    unless defined? DATA
      f = File.new $0, "r+"
      f.seek 0, File::SEEK_END
      f.write "\n__END__\n"
      @__ultron_data_pos = f.pos
      f.flush
      f.close
    else
      @__ultron_data_pos = DATA.pos
      @__ultron_data = YAML.load DATA.read
    end
  end
  def __ultron_update(data = @__ultron_data)
    data = YAML.dump data
    file = File.new $0, "r+"
    file.seek @__ultron_data_pos
    file.write data
    file.close
  end
  alias :__ultron_save :__ultron_update
end

include Ultron

