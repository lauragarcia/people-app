module ApplicationHelper
# Return image url from a object
#
# person  - Objet type Person
#
# Return and string of a url image
# If an object hasn't image, return default image url.
  def avatar_image(person)
    person.picture.present? ? person.picture.mid.url : 'default-avatar.jpg'
  end
end
