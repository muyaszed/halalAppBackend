class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :city, :country, :postcode, :category,
  :cuisine, :start, :desc, :cover_uri, :created_at, :end, :latitude, :longitude,
  :location, :web, :updated_at, :contact_number, :soc_med, :family_friendly, :surau, :disabled_accessibility,
  :sub_header, :certificate_verification, :confirmation_verification, :logo_verification
  has_many :bookmarking_user, serializer: UserBookmarkSerializer
  has_many :checking_ins, serializer: UserCheckinSerializer
  has_many :reviews, serializer: UserReviewSerializer
  has_many :halal_verifications, serializer: UserHalalVerificationSerializer

  def updated_at
    self.object.updated_at.to_i
  end

  def certificate_verification
    (self.object.halal_verifications.count != 0 ? (self.object.halal_verifications.where(certificate: true).count / self.object.halal_verifications.count)*100 : 0).to_s
  end

  def confirmation_verification
    (self.object.halal_verifications.count != 0 ? (self.object.halal_verifications.where(confirmation: true).count / self.object.halal_verifications.count)*100 : 0).to_s
  end

  def logo_verification 
    (self.object.halal_verifications.count != 0 ? (self.object.halal_verifications.where(logo: true).count / self.object.halal_verifications.count)*100 : 0).to_s
  end

  
end
