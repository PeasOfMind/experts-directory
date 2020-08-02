class Member < ApplicationRecord
  has_many :friendships, class_name: 'Friendship'
  has_many :friends, through: :friendships, foreign_key: :friend_id

  after_create :create_profile_and_short_url

  def create_profile_and_short_url
    update_attributes(profile: set_profile, short_url: set_short_url)
  end

  def set_profile
    uri = URI.parse(website)
    response = Net::HTTP.get_response(uri)
    html = response.body

    doc = Nokogiri::HTML(html)
    headings.each do |heading|
      doc.css(heading).each do |element|
        profile.push(element.text)
      end
    end
    profile
  end

  def set_short_url
    access_token = ENV['BITLY_ACCESS_TOKEN']
    return unless access_token

    client = Bitly::API::Client.new(token: access_token)
    bitlink = client.shorten(long_url: website)
    bitlink.link
  end

  def headings
    ['h1', 'h2', 'h3']
  end
end
