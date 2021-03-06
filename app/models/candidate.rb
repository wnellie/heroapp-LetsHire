class Candidate < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :source, :description, :resume

  # valid phone number examples
  # 754-647-0105 x6950
  # (498)479-4559 x2262
  # 775.039.9227 x42375
  # 1-220-680-6355 x59164
  phone_format = Regexp.new("^(\\(\\d+\\)){0,1}(\\d+)[\\d|\\.|-]*(\\sx\\d+){0,1}$")

  validates :name, :presence => true
  validates :email, :email_format => { :message => 'format error'}
  validates :phone, :format => { :with => phone_format, :message => 'format error' }

  has_many :opening_candidates, :class_name => "OpeningCandidate", :dependent => :destroy
  has_many :openings, :class_name => "Opening", :through => :opening_candidates

  def opening(index)
    opening_candidates[index].opening if opening_candidates.size > index
  end

end
