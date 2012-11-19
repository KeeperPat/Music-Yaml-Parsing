require 'yaml'

class Hash
  def method_missing(music_method)

    # When a missing method comes in, its name is assigned to the 'music_key' variable.
    # It's then tested to see if it matches any of the nodes in the yaml file, an if so, pulls that node into the 'music_value' variable.

    music_key = music_method
    music_value =self["#{music_method}"]

    # Once a music_key and music_value are set, they are sent into the following methods to generate accessor methods and assigned
    # their respective instance variables.

    if music_value
      self.class.create_accessors(music_key)
      set_values_to_accessors(music_key, music_value)
    else
      # If no music_value exists, something went wrong and super is called on method_missing to invoke its normal behavior.
      super
    end
  end

  def self.create_accessors(key)
    send(:attr_accessor, "#{key}".to_sym)
  end

  def set_values_to_accessors(key, value)
    send("#{key}=".to_sym, value)
  end
end


class Music < Hash

  # At this point, the Music class is simply inheriting from Hash, since most of the yaml parsing happens on hash data types.
  # In the future, it might be better to create a module that extends Music instead of using inheritence.

  def initialize(data)
    super(data.first.last)
  end
end

data = YAML::load(File.open('music.yaml'))

music = Music.new(data)
puts music.genres.last.artists.first.albums.first.tracks.last.name