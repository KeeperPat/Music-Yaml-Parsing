import yaml                                                                 

class MusicYAML(object):

  def __init__(self, data=None, filename=None):
    if filename:
      file_data = '\r'.join(open(filename, 'r').readlines())
      self.data = yaml.load(file_data)
    if data:
      self.data = data

  def __getitem__(self, key):
    return self.__getattr__(key)

  def __getattr__(self, attr_name):
    if type(self.data.get(attr_name)) == list:
      return [MusicYAML(data=item) for item in self.data[attr_name]]
    elif type(self.data.get(attr_name)) == dict:
      return MusicYAML(data=data[attr_name])
    else:
      return self.data[attr_name]

if __name__ == '__main__':
  parser = MusicYAML(filename='music.yaml')
  print parser.genres[0]['artists'][0]['albums'][0]['tracks'][0]['name']
  print parser.genres[0].artists[0].albums[0].tracks[0].name
