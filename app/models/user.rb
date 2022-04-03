# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable


  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy

  def has_board_written?(board)
    boards.exists?(id: board.id)
  end

  def has_task_written?(task)
    tasks.exists?(id: task.id)
  end

  # avatar用 current_user.avatar_image
  # def avatar_image
  #   if profile&.avatar&.attached?
  #     profile.avatar
  #   else
  #     'default-avatar.png'
  #   end
  # end
  
end
