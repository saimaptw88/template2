# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  # validates :name, presence: true, uniqueness: true
  # validates :email, presence: true, uniqueness: true
  # validates :uid, uniqueness: true
  # validates :provider, uniqueness: true
  # validates :reset_password_token, uniqueness: true
  # validates :confirmation_token, uniqueness: true
end
