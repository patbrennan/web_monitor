class Cred
  def self.find(name)
    Rails.application.secrets[name]
  end
end