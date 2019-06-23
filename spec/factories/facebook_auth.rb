FactoryBot.define do
    factory :facebook_auth do
      email { 'foo@bar.com' }
      name {'Yazed Yazed'}
      uid {'234'}
      oauth_token {Faker::Omniauth.facebook[:credentials][:token]}
      fb_avatar {Faker::Omniauth.facebook[:info][:image]}
      
    end
  end