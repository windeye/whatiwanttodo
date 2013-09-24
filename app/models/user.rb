class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,:validatable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :async 

	has_many :powerpoints, dependent: :destroy

	has_many :favourites, dependent: :destroy
	has_many :favourite_powerpoints, through: :favourites, source: :powerpoint

	mount_uploader :avatar, AvatarUploader 

	#验证失败信息的顺序和这里的验证顺序相关
	validates :email, presence: { message: "邮箱不能为空"}
	validates :email, format: {with: Devise.email_regexp, message: "请输入有效的邮箱"}, if: "email.present?"
	validates :email, uniqueness: {case_sensitive: false, message: "该邮箱已经被注册"}, if: "email.present?"
	
	#before_validation :strip_and_downcase_username
	validates :username, presence: {message: "用户名不能为空"}
	validates :username, uniqueness: { case_sensitive: false, message: "该用户名已经被注册"}, if: "username.present?"
	#validates :username, exclusion: {in: %w(leokmax admin administrator hostmaster info postmaster root ssladmin ssladministrator sslwebmaster sysadmin webmaster support contact), message: "不允许使用该用户名"}
	validates :username, length: {minimum: 6, maximum: 20, message: "用户名至少6个字符，不要超过20个字符"}, if: "username.present?"
	validates :username, format: {with: /\A[a-zA-Z0-9]*[a-zA-Z][a-zA-Z0-9_]*\z/, message: "用户名格式不正确,请包含字母和数字，不要只有数字"}, if: "username.present?"

	validates :password, presence: { message: "密码不能为空"}, if: :password_required?
	validates :password, length: { within: Devise.password_length, message: "密码最少6个字符，不要超过20个字符", :allow_blank => true}, if: :password_required?
	validates :password, confirmation: {message: "密码确认不匹配"}, if: :password_required?
	#validates :password_confirmation, presence: {message: "密码确认不匹配"}, if: "password.present?"


	#validates :terms_of_service, acceptance: true
	def password_required?
	  !persisted? || !password.nil? || !password_confirmation.nil?
	end


	def favourited?(ppt)
		favourite_powerpoints.include?(ppt)
	end

	def admin?
		roles.to_i === 8
	end

	def member?
		roles.to_i === 0
	end
end
