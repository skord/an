class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :authentications, dependent: :destroy
  has_one :steam_auth, -> { where provider: 'steam'}
  has_many :slack_auths, -> {where provider: 'slack'}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  def authenticated_for?(provider)
    authentications.pluck(:provider).include? provider
  end
  def authentication_for(provider)
    authentications.where(provider: provider).first
  end
  def fully_integrated?
    slack_auths.any? && steam_auth.present?
  end
  def friends
    if fully_integrated?
      ids = (
             steam_auth.local_steam_friend_ids +
             slack_auths.collect {|x| x.local_slack_friend_ids} +
             [id]
             ).flatten
      User.where(id: ids)
    else
      self
    end
  end
end
