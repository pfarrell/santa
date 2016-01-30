require 'byebug'
require './app'



p = Project.new
p p.stories.size
p p.stories(epic: 'nes').size
p p.stories(epic: 'enes').size
p p.active(epic: 'enes').size
byebug;1



