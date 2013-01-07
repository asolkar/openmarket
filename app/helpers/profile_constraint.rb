class ProfileConstraint
  def self.matches?(request)
    reserved_words = ['login', 'signup', 'logout', 'help', 'about']
    !reserved_words.include?(request.path_parameters[:username])
  end
end
