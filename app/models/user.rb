class User < ApplicationRecord

  AFFILIATIONS = {
    member: "Member",
    faculty: "Faculty",
    student: "Student",
    alum: "Alumnus",
    affiliate: "Affiliate",
    'library-walk-in': "Library Walk-In"
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :username, presence: true, uniqueness: true
  validates :affiliation, presence: true
  validates :affiliation,
    inclusion: { in: AFFILIATIONS.stringify_keys.keys,
    message: "%{value} is not a valid affiliation" }
end
