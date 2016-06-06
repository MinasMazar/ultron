# coding: utf-8
require 'pry'

# NOTE To run this script you must have youtube-dl tool installed (https://rg3.github.io/youtube-dl/)

# When ultron gem is required via autoinit it automatically loads YAML objects of DATA block (the stuff after __END__ keyword in ruby scripts)
# require 'ultron/autoinit'

# But remember: YAML could load classes not already loaded!
# In this case require the ultron gem in the normal way.
#
# require 'ultron'
#

# Then you can define all the class objects used within your YAML DATA block.
# ex.
#
# class Foo
# ...
# end

# Now you can init ultron and DATA will be loaded
# __ultron_init


# Define class for Youtube videos 
class YoutubeVid
  attr_accessor :url, :title, :filename, :downloaded
  def initialize(url, other_params = {})
    @url = url
    @title = other_params[:title]
    @filename = other_params[:filename]
    @downloaded = other_params[:downloaded]
  end
  def sync
    return self if self.title && self.filename
    self.title, self.filename = `youtube-dl -s --get-title --get-filename #{self.url}`.split("\n")
    self
  end
  def download
    download! unless downloaded?
  end
  def download!
    self.downloaded = system "youtube-dl #{self.url}"
  end
  def downloaded?
    self.downloaded ||= ( self.filename ? File.exists?(self.filename) : false )
  end
  # To change YAML encoding
  def encode_with(coder)
    [ :url, :title, :filename, :downloaded ].each { |attr| coder[attr] = self.send attr }
    coder
  end
end

##############
# Start script

# Read all YAML objects from DATA block via *ultron* gem
__ultron_init

# Read YAML DATA objects and save in vids
vids = __ultron_data

# If added new youtube urls, convert to YoutubeVid object
vids.map! { |v| v = v.kind_of?(String) ? YoutubeVid.new(v) : v }

# Download title and filename of videos calling YoutubeVid#sync
#  vids.each { |v| v.sync }

# or you can download a video if it is not already saved in the current directory
#  vids.last.download

# Now vids are synced. Let's save the YAML DATA BLOCK
# Call __ultron_update with data to be saved as parameter (!! All data will be replaced with new data!!)
#  __ultron_update vids

# Start interactive session
binding.pry

# YAML DATA BLOCK

__END__
---
- http://www.youtube.com/watch?v=umCVFVANdfs
- http://www.youtube.com/watch?v=Zz-6BgsmYe4
- http://www.youtube.com/watch?v=IMuwI3qrhWI
- http://www.youtube.com/watch?v=CGnt_PWoM5Y
- http://www.youtube.com/watch?v=oJTwQvgfgMM
- https://www.youtube.com/watch?v=kC5YdDZ5X6U
- https://www.youtube.com/watch?v=dX3k_QDnzHE
