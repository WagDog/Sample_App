module UsersHelper

  # Return the Gravatar for the given user from http://gravatar.com position 8375
  # Gravatar Login P - tr34cl3t4rt
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png" # This works
    #gravatar_url = "https://secure.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50.png" # This URL came from the tech notes at https://secure.gravatar.com/site/implement/images/
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
