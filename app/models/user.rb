class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token

  before_save :downcase_email 
  after_save :update_home_path
  before_create :create_activation_digest 
  before_destroy :rm_home
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:{ with: VALID_EMAIL_REGEX }, length:{maximum: 255}, uniqueness: {case_sensitive: false} 
  validates :password, length: { minimum: 6}, format:{ with: /\A[a-zA-z\d]+\z/ }, allow_nil: true
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def remember
    self.remember_token =  User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #def destroy
    #super
    #FileUtils.rm_rf self.reload.home_path if Dir.exists?(self.home_path)
    #return
  #end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute :activated, true
    update_attribute :activated_at, Time.zone.now
  end

  def create_home
    rm_home
    FileUtils.mkdir_p Datafolder::Env.root_path + "/#{self.id}"
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def create_reset_digest
    self.reset_token = User.new_token
    #update_attribute :reset_digest, User.digest(reset_token)
    #update_attribute :reset_sent_at, Time.zone.now
    update_attributes reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  private
    def downcase_email
      self.email = email.downcase
    end

    def update_home_path
      if self.home_path.nil? || self.home_path != "/#{self.id}"
        self.home_path = "/#{self.id}"
        update_attribute :home_path, self.home_path
      end
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    def rm_home
      absolute_home_path = Datafolder::Env.root_path + "/#{self.id}"
      FileUtils.rm_rf absolute_home_path if Dir.exists?(absolute_home_path)
    end

end
