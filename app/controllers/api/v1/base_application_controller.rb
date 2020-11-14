class Api::V1::BaseApplicationController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  # userがサインインしていない場合、401エラーを返す
  before_action :authenticate_api_v1_user!

  protect_from_forgery with: :null_session
end
